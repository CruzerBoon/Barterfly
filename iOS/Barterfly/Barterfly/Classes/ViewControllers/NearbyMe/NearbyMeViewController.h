//
//  NearbyMeViewController.h
//  Barterfly
//
//  Created by Mun Fai Leong on 6/13/15.
//  Copyright (c) 2015 angelhack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "AICommonUtils.h"
#import "azureMobileService.h"

@interface NearbyMeViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate, AzureMobileServiceDelegate>
{
    azureMobileService *mobileService;
    LoadingScreen *screen;
}

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property (strong, nonatomic) CLLocationManager *locationManager;

@end
