//
//  azureMobileService.h
//  Barterfly
//
//  Created by Mun Fai Leong on 6/13/15.
//  Copyright (c) 2015 angelhack. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WindowsAzureMobileServices/WindowsAzureMobileServices.h>
#import "azureAuthentication.h"

@protocol AzureMobileServiceDelegate;


@interface azureMobileService : NSObject <AzureAuthenticationDelegate>

@property (nonatomic) MSClient *client;

@property (nonatomic, assign) id <AzureMobileServiceDelegate> delegate;

/* INIT AZURE CLIENT */

-(instancetype)initAzureClient;

/* LOG OUT CURRENT AZURE CLIENT */

-(void)logoutAzureClient;


/* AUTHENTICATE AND LOGIN THROUGH SOCIAL INTEGRATION */

-(void)authenticateLoginForUser:(MSClient *)client atTarget:(id)target forAuthenticationType:(AuthenticationType)authenticationType;


/* GET DATA */

-(void)getDataFromTableWithName:(NSString *)tableName;
-(NSMutableArray *)getFilteredDataFromTableWithName:(NSString *)tableName withFilter:(NSString *)filter;
-(NSMutableArray *)getSortedDataUsingQueryFromTableWithName:(NSString *)tableName forColumnName:(NSString *)columnName isAscending:(BOOL)isAscending;
-(void)getSingleDataFromTableWithName:(NSString *)tableName forId:(NSString *)userId;
-(void)getFullListingItemForTableWithName:(NSString *)tableName;
-(void)getSingleItemUsingAPIForTableWithName:(NSString *)tableName queryString:(NSString *)queryString;
/* INSERT DATA */

-(void)insertDataIntoTableWithName:(NSString *)tableName forItem:(NSMutableDictionary *)itemDictionary;

/* UPDATE DATA */

-(void)updateDataIntoTableWithName:(NSString *)tableName forItem:(NSMutableDictionary *)itemDictionary;

/* DELETE DATA */

-(void)deleteDataFromTableWithName:(NSString *)tableName forItem:(NSMutableDictionary *)itemDictionary;

@end


@protocol AzureMobileServiceDelegate <NSObject>

@optional

-(void)azureMobileServiceDidFailWithError:(NSError *)error;

-(void)azureMobileServiceDidFinishInsertData;

-(void)azureMobileServiceDidFinishUpdateData;

-(void)azureMobileServiceDidFinishDeleteData;

-(void)azureMobileServiceDidSuccessAuthenticating;

-(void)azureMobileServiceDidSuccessLogoutAzureClient;


-(void)azureMobileServiceDidFinishGetData;

-(void)azureMobileServiceDidFinishGetDataForList:(id)object;

-(void)azureMobileServiceDidFinishGetDataForSingleItem:(id)object;

@end
