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
    self.mapView.delegate = self;
    self.mapView.showsUserLocation = YES;
    self.mapView.showsBuildings = YES;
    self.mapView.showsPointsOfInterest = YES;
    
    
    //initialize CLLocation Manager
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    [self.locationManager requestWhenInUseAuthorization];
    
    [self.locationManager startUpdatingLocation];
    //NSLog(@"loc: %f, %f", self.locationManager.location.coordinate.latitude, self.locationManager.location.coordinate.longitude);
    
    CLLocationCoordinate2D coord;

    coord = CLLocationCoordinate2DMake(self.locationManager.location.coordinate.latitude, self.locationManager.location.coordinate.longitude);
    
    MKMapCamera *camera = [MKMapCamera cameraLookingAtCenterCoordinate:coord fromEyeCoordinate:coord eyeAltitude:5000];
    [self.mapView setCamera:camera animated:YES];
    
    MKUserTrackingBarButtonItem *buttonItem = [[MKUserTrackingBarButtonItem alloc] initWithMapView:self.mapView];
    self.navigationItem.rightBarButtonItem = buttonItem;
    
    [self addAnnotation];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)showUserCurrentLocation:(id)sender
{
    
}

-(void)addAnnotation
{
    [self.mapView removeAnnotations:self.mapView.annotations];
    
    CLLocationCoordinate2D coord;
    
    coord = CLLocationCoordinate2DMake(self.locationManager.location.coordinate.latitude + 0.0020, self.locationManager.location.coordinate.longitude + 0.0020);
    
    MKPointAnnotation *LocationAnnotation = [[MKPointAnnotation alloc]init];
    LocationAnnotation.coordinate = coord;
    LocationAnnotation.title = @"Trader";
    
    
    [self.mapView addAnnotation:LocationAnnotation];
}

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
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Privacy Settings Disabled" message:errorType delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
    }
    else if (status == kCLAuthorizationStatusNotDetermined)
    {
        
        [self.locationManager requestWhenInUseAuthorization];
        
    }
    
    NSLog(@"CLLocationManager: %@", errorType);
    
}



#pragma mark - MKMapViewDelegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    if (![annotation isKindOfClass:[MKUserLocation class]])
    {
        MKAnnotationView *annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"merchantMarker"];
        annotationView.canShowCallout = YES;
        annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        annotationView.image = [UIImage imageNamed:@"map_pin"];
        annotationView.centerOffset = CGPointMake(0, -20); // To rectify the view's position off set due to the size of image
        
        // Setup merchant image view
        UIImageView *merchantImageView = [[UIImageView alloc] initWithFrame:CGRectMake(2, 2, 26, 26)];
        merchantImageView.layer.cornerRadius = merchantImageView.frame.size.height / 2;
        merchantImageView.clipsToBounds = YES;
        merchantImageView.image = [UIImage imageNamed:@"barterCyan"];
        
        // Add merchant image view to pin
        [annotationView addSubview:merchantImageView];
        
        return annotationView;
    }
    
    return nil;
}


-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    if (![view.annotation isKindOfClass:[MKUserLocation class]])
    {
        [AICommonUtils navigateToItemDetailsPageWithNavigationController:self.navigationController forDictionary:nil];
    }
}

@end
