//
//  azureAuthentication.m
//  Barterfly
//
//  Created by Mun Fai Leong on 6/13/15.
//  Copyright (c) 2015 angelhack. All rights reserved.
//

#import "azureAuthentication.h"

#import "SSKeychain.h"
#import "SSKeychainQuery.h"

#define SERVICE_NAME @"angelHack2015_AzureMobileService"

@implementation azureAuthentication

-(NSString *)getNameForAuthenticationType:(AuthenticationType)authenticationType
{
    NSString *name;
    
    switch (authenticationType)
    {
        case authenticationTypeFacebook:
            name = @"facebook";
            break;
            
        case authenticationTypeGoogle:
            name = @"google";
            break;
            
        case authenticationTypeMicrosoftAccount:
            name = @"microsoftaccount";
            break;
            
        case authenticationTypeTwitter:
            name = @"twitter";
            break;
            
        default:
            name = @"facebook";
            break;
    }
    
    return name;
}

/* AUTHENTICATE AND GET DATA */

-(void)loginAndGetDataForClient:(MSClient *)client atTarget:(id)target usingAuthenticationType:(AuthenticationType)authenticationType
{
    if (client.currentUser != nil)
        return;
    
    
    
    [client loginWithProvider:[self getNameForAuthenticationType:authenticationType] controller:target animated:YES completion:^(MSUser *user, NSError *error)
     {
         if (error)
         {
             NSLog(@"Error login user: %@", error.localizedDescription);
         }
         else
         {
             [self saveAuthenticationInfoForClient:client];
             
             if ([self.delegate respondsToSelector:@selector(azureAuthenticationDidSuccessAuthenticating)])
             {
                 [self.delegate azureAuthenticationDidSuccessAuthenticating];
             }
         }
     }];
}

/* SAVE AUTHENTICATION INFORMATION */

-(void)saveAuthenticationInfoForClient:(MSClient *)client
{
    [SSKeychain setPassword:client.currentUser.mobileServiceAuthenticationToken forService:SERVICE_NAME account:client.currentUser.userId];
}

/* LOAD AUTHENTICATION INFORMATION AND RETURNS THE AUTHENTICATED USER */

-(MSUser *)loadAuthenticationInfoWithUserForClient
{
    NSString *userId = [[SSKeychain accountsForService:SERVICE_NAME][0] valueForKey:@"acct"];
    
    MSUser *user = [[MSUser alloc]init];
    
    if (userId)
    {
        NSLog(@"userId: %@", userId);
        
        user = [[MSUser alloc]initWithUserId:userId];
        user.mobileServiceAuthenticationToken = [SSKeychain passwordForService:SERVICE_NAME account:userId];
        return user;
    }
    
    return nil;
}


+(void)deletePassword
{
    SSKeychainQuery *query = [[SSKeychainQuery alloc] init];
    
    NSArray *accounts = [query fetchAll:nil];
    
    for (id account in accounts) {
        
        SSKeychainQuery *query = [[SSKeychainQuery alloc] init];
        
        query.service = SERVICE_NAME;
        query.account = [account valueForKey:@"acct"];
        
        [query deleteItem:nil];
        
    }
}
@end