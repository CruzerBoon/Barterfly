//
//  NearbyMeViewController.m
//  Barterfly
//
//  Created by Mun Fai Leong on 6/13/15.
//  Copyright (c) 2015 angelhack. All rights reserved.
//

#import "NearbyMeViewController.h"

@interface NearbyMeViewController ()

@end

@implementation NearbyMeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self initializeMap];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initializeMap
{
    self.mapVIew.delegate = self;
    self.mapVIew.showsUserLocation = YES;
    self.mapVIew.showsBuildings = YES;
    self.mapVIew.showsPointsOfInterest = YES;
    
    
    //initialize CLLocation Manager
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    [self.locationManager requestWhenInUseAuthorization];
    
    [self.locationManager startUpdatingLocation];
    //NSLog(@"loc: %f, %f", self.locationManager.location.coordinate.latitude, self.locationManager.location.coordinate.longitude);
    
    CLLocationCoordinate2D coord;

    coord = CLLocationCoordinate2DMake(self.locationManager.location.coordinate.latitude, self.locationManager.location.coordinate.longitude);
    
    MKMapCamera *camera = [MKMapCamera cameraLookingAtCenterCoordinate:coord fromEyeCoordinate:coord eyeAltitude:2000];
    [self.mapVIew setCamera:camera animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - core location manager delegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSString *errorType;
    
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    
    if (status == kCLAuthorizationStatusRestricted || status == kCLAuthorizationStatusDenied)
    {
        errorType = @"Location Service: Access denied, please enable location service in phone settings to find nearby trades";
        
    }
    else if (status == kCLAuthorizationStatusNotDetermined)
    {
        
        [self.locationManager requestWhenInUseAuthorization];
        
    }
    
    NSLog(@"CLLocationManager: %@", errorType);
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Privacy Settings Disabled" message:errorType delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}

@end
