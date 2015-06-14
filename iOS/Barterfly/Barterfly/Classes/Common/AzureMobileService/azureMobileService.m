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
        
        azureAuthentication *auth = [[azureAuthentication alloc]init];

        self.client.currentUser = [auth loadAuthenticationInfoWithUserForClient];
    }
    
    return self;
}

-(MSTable *)createTableWithName:(NSString *)tableName
{
    MSTable *table = [self.client tableWithName:tableName];
    
    return table;
}

-(void)logoutAzureClient
{
    [self.client logout];
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

-(void)getDataFromTableWithName:(NSString *)tableName
{
    NSMutableArray *tempArray = [[NSMutableArray alloc]init];
    
    MSTable *table = [self createTableWithName:tableName];
    
    [table readWithCompletion:^(MSQueryResult *result, NSError *error)
     {
         if (error)
         {
             NSLog(@"Error getting data: %@", error);
             
             if ([self.delegate respondsToSelector:@selector(azureMobileServiceDidFailWithError:)])
             {
                 [self.delegate azureMobileServiceDidFailWithError:error];
             }
         }
         else
         {
             //NSLog(@"result: %@", result.items);
             
             [tempArray addObjectsFromArray:result.items];
             
             if ([self.delegate respondsToSelector:@selector(azureMobileServiceDidFinishGetDataForList:)])
             {
                 [self.delegate azureMobileServiceDidFinishGetDataForList:tempArray];
             }
         }
     }];
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
             NSLog(@"Error getting data: %@", error);
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


-(void)getSingleDataFromTableWithName:(NSString *)tableName forId:(NSString *)userId
{
    __block NSDictionary *tempdic;
    
    MSTable *table = [self createTableWithName:tableName];
    
    [table readWithId:userId completion:^(NSDictionary *dictionary, NSError *error){
        if (error)
        {
            NSLog(@"Error getting data: %@", error);
            
            if ([self.delegate respondsToSelector:@selector(azureMobileServiceDidFailWithError:)])
            {
                [self.delegate azureMobileServiceDidFailWithError:error];
            }
        }
        else
        {
            //NSLog(@"result: %@", dictionary);
            tempdic = dictionary;
            
            if ([self.delegate respondsToSelector:@selector(azureMobileServiceDidFinishGetDataForSingleItem:)])
            {
                [self.delegate azureMobileServiceDidFinishGetDataForSingleItem:tempdic];
            }
        }
    }];
    
}

-(void)getSingleItemUsingAPIForTableWithName:(NSString *)tableName queryString:(NSString *)queryString
{
    MSTable *table = [self createTableWithName:tableName];
    
    [table readWithQueryString:queryString completion:^(MSQueryResult *result, NSError *error)
    {
        if (error)
        {
            NSLog(@"Error getting data: %@", error);
            
            if ([self.delegate respondsToSelector:@selector(azureMobileServiceDidFailWithError:)])
            {
                [self.delegate azureMobileServiceDidFailWithError:error];
            }
        }
        else
        {
            //NSLog(@"result: %@", result.items);
            
            if ([self.delegate respondsToSelector:@selector(azureMobileServiceDidFinishGetDataForSingleItem:)])
            {
                [self.delegate azureMobileServiceDidFinishGetDataForSingleItem:result.items];
            }
        }
    }];
}

-(void)getFullListingItemForTableWithName:(NSString *)tableName
{
    NSMutableArray *tempArray = [[NSMutableArray alloc]init];
    
    NSString *stringapi = [NSString stringWithFormat:@"/%@", tableName];
    
    [self.client invokeAPI:stringapi body:nil HTTPMethod:@"GET" parameters:nil headers:nil completion:^(id result, NSHTTPURLResponse *response, NSError *error)
    {
        if (error)
        {
            NSLog(@"Error: %@", error);
            
            if ([self.delegate respondsToSelector:@selector(azureMobileServiceDidFailWithError:)])
            {
                [self.delegate azureMobileServiceDidFailWithError:error];
            }
        }
        else
        {
            [tempArray addObjectsFromArray:(NSArray *)result];
            
            if ([self.delegate respondsToSelector:@selector(azureMobileServiceDidFinishGetDataForList:)])
            {
                [self.delegate azureMobileServiceDidFinishGetDataForList:tempArray];
            }
        }
    }];
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
