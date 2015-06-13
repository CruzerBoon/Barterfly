//
//  GBConnectionManager.h
//  Globeam.Merchant
//
//  Created by Administrator on 4/7/15.
//  Copyright (c) 2015 MobileTeam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol GBConnectionManagerDelegate;

@interface GBConnectionManager : NSObject <NSURLConnectionDelegate>


@property (nonatomic, assign) IBOutlet id <GBConnectionManagerDelegate> delegate;

-(void)consumeServiceRequest:(NSString *)serviceURL JsonData:(NSData *)jsondata haveParam:(BOOL)haveParam;

-(NSData *)convertJsonDictionaryToNSData:(NSMutableDictionary *)dictionary;

@end



@protocol GBConnectionManagerDelegate <NSObject>

@optional


-(void)GBConnectionDidFinishLoading:(NSURLConnection *)connection withData:(NSMutableData *)data forURL:(NSString *)url withServerAddress:(NSString *)serverAddress forResponse:(NSHTTPURLResponse *)response;
-(void)GBConnectionDidReceiveResponse:(NSHTTPURLResponse *)response forURL:(NSString *)url withServerAddress:(NSString *)serverAddress;
-(void)GBConnection:(NSURLConnection *)connection didFailWithError:(NSError *)error;
-(void)GBPresentViewController:(UIViewController *)viewControllerToPresent animated: (BOOL)flag completion:(void (^)(void))completion NS_AVAILABLE_IOS(5_0);

@end
