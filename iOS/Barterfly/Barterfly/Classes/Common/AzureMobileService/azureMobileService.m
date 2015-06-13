//
//  azureMobileService.m
//  Barterfly
//
//  Created by Mun Fai Leong on 6/13/15.
//  Copyright (c) 2015 angelhack. All rights reserved.
//

#import "azureMobileService.h"


//Javascript backend
//#define APP_URL @"https://angelhack2015kl.azure-mobile.net/"
//#define APP_KEY @"GQuvQTYQQhEfoSvxhDGvHWJKwhOWeg34"

//.net backend
#define APP_URL @"https://angel2015kl.azure-mobile.net/"
#define APP_KEY @"QIeEkWaRzdBnPiqKFyXTyHfvwJSdTQ14"


@implementation azureMobileService

/* OBJECT INIT AND GET TABLE */

-(instancetype)initAzureClient
{
    self = [super init];
    
    if (self)
    {
        self.client = [MSClient clientWithApplicationURLString:APP_URL applicationKey:APP_KEY];
    }
    
    return self;
}

-(MSTable *)createTableWithName:(NSString *)tableName
{
    MSTable *table = [self.client tableWithName:tableName];
    
    return table;
}


/* AUTHENTICATE AND LOGIN THROUGH SOCIAL INTEGRATION */

-(void)authenticateLoginForUser:(MSClient *)client atTarget:(id)target forAuthenticationType:(AuthenticationType)authenticationType
{
    azureAuthentication *authentication = [[azureAuthentication alloc]init];
    authentication.delegate = self;
    
    client.currentUser = [authentication loadAuthenticationInfoWithUserForClient];
    
    [authentication loginAndGetDataForClient:client atTarget:target usingAuthenticationType:authenticationType];
    
}


/* GET DATA FROM TABLE */

-(NSMutableArray *)getDataFromTableWithName:(NSString *)tableName
{
    NSMutableArray *tempArray = [[NSMutableArray alloc]init];
    
    MSTable *table = [self createTableWithName:tableName];
    
    [table readWithCompletion:^(MSQueryResult *result, NSError *error)
     {
         if (error)
         {
             NSLog(@"Error getting data: %@", error.localizedDescription);
         }
         else
         {
             [tempArray addObjectsFromArray:result.items];
         }
     }];
    
    return tempArray;
}

-(NSMutableArray *)getFilteredDataFromTableWithName:(NSString *)tableName withFilter:(NSString *)filter
{
    NSMutableArray *tempArray = [[NSMutableArray alloc]init];
    
    MSTable *table = [self createTableWithName:tableName];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:filter];
    
    [table readWithPredicate:predicate completion:^(MSQueryResult *result, NSError *error)
     {
         if (error)
         {
             NSLog(@"Error getting data: %@", error.localizedDescription);
         }
         else
         {
             [tempArray addObjectsFromArray:result.items];
         }
     }];
    
    return tempArray;
}

-(NSMutableArray *)getSortedDataUsingQueryFromTableWithName:(NSString *)tableName forColumnName:(NSString *)columnName isAscending:(BOOL)isAscending
{
    MSTable *table = [self createTableWithName:tableName];
    
    MSQuery *query = [table query];
    
    if (isAscending)
        [query orderByAscending:columnName];
    else
        [query orderByDescending:columnName];
    
    NSMutableArray *tempArray = [[NSMutableArray alloc]init];
    
    [query readWithCompletion:^(MSQueryResult *result, NSError *error)
     {
         if (error)
         {
             NSLog(@"Error getting data: %@", error.localizedDescription);
         }
         else
         {
             [tempArray addObjectsFromArray:result.items];
         }
     }];
    return tempArray;
    
}


/* INSERT DATA INTO TABLE */

-(void)insertDataIntoTableWithName:(NSString *)tableName forItem:(NSMutableDictionary *)itemDictionary
{
    MSTable *table = [self createTableWithName:tableName];
    
    [table insert:itemDictionary completion:^(NSDictionary *item, NSError *error)
     {
         if (error)
         {
             NSLog(@"Error inserting data: %@", error.localizedDescription);
         }
         else
         {
             NSLog(@"Insert complete: %@", item);
         }
     }];
}


/* UPDATE DATA INTO TABLE */

-(void)updateDataIntoTableWithName:(NSString *)tableName forItem:(NSMutableDictionary *)itemDictionary
{
    MSTable *table = [self createTableWithName:tableName];
    
    [table update:itemDictionary completion:^(NSDictionary *item, NSError *error)
     {
         if (error)
         {
             NSLog(@"Error updating data: %@", error.localizedDescription);
         }
         else
         {
             NSLog(@"Update complete: %@", item);
         }
     }];
}

/* DELETE DATA FROM TABLE */

-(void)deleteDataFromTableWithName:(NSString *)tableName forItem:(NSMutableDictionary *)itemDictionary
{
    MSTable *table = [self createTableWithName:tableName];
    
    [table delete:itemDictionary completion:^(NSDictionary *item, NSError *error)
     {
         if (error)
         {
             NSLog(@"Error deleting data: %@", error.localizedDescription);
         }
         else
         {
             NSLog(@"Delete complete: %@", item);
         }
     }];
}


#pragma mark - Authentication Delegate

-(void)azureAuthenticationDidSuccessAuthenticating
{
    if ([self.delegate respondsToSelector:@selector(azureMobileServiceDidSuccessAuthenticating)])
    {
        [self.delegate azureMobileServiceDidSuccessAuthenticating];
    }
}

@end
