//
//  GBConnectionManager.m
//  Globeam.Merchant
//
//  Created by Administrator on 4/7/15.
//  Copyright (c) 2015 MobileTeam. All rights reserved.
//

#import "GBConnectionManager.h"
#import <WindowsAzureMobileServices/WindowsAzureMobileServices.h>
#import "azureMobileService.h"

NSMutableData *combinedData;
NSHTTPURLResponse *httpresponse;

@implementation GBConnectionManager

-(void)consumeServiceRequest:(NSString *)serviceURL JsonData:(NSData *)jsondata haveParam:(BOOL)haveParam
{
    combinedData = [[NSMutableData alloc]init];
    
    azureAuthentication *auth = [[azureAuthentication alloc]init];
    
    MSUser *user = [auth loadAuthenticationInfoWithUserForClient];
    
    NSURL *url = [NSURL URLWithString:serviceURL];
    
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:15.0];

    [theRequest setHTTPMethod:@"POST"];
    [theRequest addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue:user.mobileServiceAuthenticationToken forHTTPHeaderField:@"GLO-AUTH"];
    
    
    // should check for and handle errors here but we aren't
    
    if (haveParam)
        [theRequest setHTTPBody:jsondata];
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    
    if (!connection)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                        message:@"no connection"
                                                       delegate:nil
                                              cancelButtonTitle:@"cancel"
                                              otherButtonTitles:nil];
        [alert show];

        if ([self.delegate respondsToSelector:@selector(GBConnection:didFailWithError:)])
        {
            @try {
                [self.delegate GBConnection:connection didFailWithError:nil];
            }
            @catch (NSException *exception) {
                    NSLog(@"GBConnection Manager No Connection Exception: %@", exception.description);
            }
            @finally {
                
            }
            
        }
    }
}

-(NSData *)convertJsonDictionaryToNSData:(NSMutableDictionary *)dictionary
{
    NSError *error;
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:&error];
    
    return jsonData;
}


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark - NSURLConnectionDelegate
/*
// to deal with self-signed certificates
- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace
{
    return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust])
    {
        NSString *ipAddress = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"IPAddress"];
        
        // we only trust our own domain
        if ([challenge.protectionSpace.host isEqualToString:ipAddress])
        {
            NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
            [challenge.sender useCredential:credential forAuthenticationChallenge:challenge];
        }
    }
    
    [challenge.sender continueWithoutCredentialForAuthenticationChallenge:challenge];
}

- (void)connection:(NSURLConnection *)connection willSendRequestForAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    [GBCommonUtils performCheckingAndHandlingOnNSURLAuthenticationChallenge:challenge];
}
*/
- (void)connection:(NSConnection*)conn didReceiveResponse:(NSURLResponse *)response
{
    NSURLConnection *c1 = (NSURLConnection *)conn;
    NSURL *myurl = [[c1 currentRequest] URL];
    
    NSString *ipaddress = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"IPAddress"];
    NSString *portnumber = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"PortNumber"];
    NSString *ServiceAddress = [NSString stringWithFormat:@"%@%@", ipaddress, portnumber];
    NSString *protocol = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"Protocol"];
    NSString *ServerAddress = [NSString stringWithFormat:@"%@://%@/", protocol, ServiceAddress];

    httpresponse = (NSHTTPURLResponse *)response;
    
    NSLog(@"Connection Status %lu: %@", (long)httpresponse.statusCode, myurl);
    
    if ([httpresponse statusCode] != 200)
    {
        
            NSLog(@"Response error: %@", httpresponse);
        
       
    }
    
    
    if ([self.delegate respondsToSelector:@selector(GBConnectionDidReceiveResponse:forURL:withServerAddress:)])
    {
        [self.delegate GBConnectionDidReceiveResponse:httpresponse forURL:[NSString stringWithFormat:@"%@", myurl] withServerAddress:ServerAddress];
    }
    
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [combinedData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    if ([self.delegate respondsToSelector:@selector(GBConnection:didFailWithError:)])
    {
        [self.delegate GBConnection:connection didFailWithError:error];
    }
    
    NSLog(@"GBConnectionManager failedWithErrorForURL - %@\nError:%@, %@", connection.currentRequest.URL, error.localizedDescription, [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
    
    //NSLog(@"GBConnectionManager failedWithError - %@, %@", [error localizedDescription], [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    @try {
        
        if ([self.delegate respondsToSelector:@selector(GBConnectionDidFinishLoading:withData:forURL:withServerAddress:forResponse:)])
        {
            NSString *ipaddress = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"IPAddress"];
            NSString *portnumber = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"PortNumber"];
            NSString *ServiceAddress = [NSString stringWithFormat:@"%@%@", ipaddress, portnumber];
            NSString *protocol = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"Protocol"];
            NSString *ServerAddress = [NSString stringWithFormat:@"%@://%@/", protocol, ServiceAddress];
            
            [self.delegate GBConnectionDidFinishLoading:connection withData:combinedData forURL:[NSString stringWithFormat:@"%@", connection.currentRequest.URL] withServerAddress:ServerAddress forResponse:httpresponse];
        }
        
    }
    @catch (NSException *exception)
    {
        NSLog(@"Deserialize exception: %@", exception.description);
    }
    @finally {
        
    }
    
}



@end
