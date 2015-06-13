//
//  azureAuthentication.h
//  Barterfly
//
//  Created by Mun Fai Leong on 6/13/15.
//  Copyright (c) 2015 angelhack. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WindowsAzureMobileServices/WindowsAzureMobileServices.h>

typedef enum {
    authenticationTypeFacebook,
    authenticationTypeMicrosoftAccount,
    authenticationTypeGoogle,
    authenticationTypeTwitter
} AuthenticationType;

@protocol AzureAuthenticationDelegate;


@interface azureAuthentication : NSObject

@property (nonatomic) MSClient *client;

@property (nonatomic, assign) id <AzureAuthenticationDelegate> delegate;



/* AUTHENTICATE AND GET DATA */

-(void)loginAndGetDataForClient:(MSClient *)client atTarget:(id)target usingAuthenticationType:(AuthenticationType)authenticationType;


/* LOAD AUTHENTICATION INFORMATION AND RETURNS THE AUTHENTICATED USER */

-(MSUser *)loadAuthenticationInfoWithUserForClient;


-(void)deletePassword;
@end



@protocol AzureAuthenticationDelegate <NSObject>

@optional

-(void)azureAuthenticationDidSuccessAuthenticating;

@end