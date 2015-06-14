//
//  NearbyMeViewController.m
//  Barterfly
//
//  Created by Mun Fai Leong on 6/13/15.
//  Copyright (c) 2015 angelhack. All rights reserved.
//

#import "NearbyMeViewController.h"

@interface NearbyMeViewController ()
{
    NSMutableArray *listinArray;
}
@end

@implementation NearbyMeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initializeMap];
    
    [self performSelector:@selector(initAzureClient) withObject:nil afterDelay:1.0];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    
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
    
    MKMapCamera *camera = [MKMapCamera cameraLookingAtCenterCoordinate:coord fromEyeCoordinate:coord eyeAltitude:30000];
    [self.mapView setCamera:camera animated:NO];
    
    MKUserTrackingBarButtonItem *buttonItem = [[MKUserTrackingBarButtonItem alloc] initWithMapView:self.mapView];
    self.navigationItem.rightBarButtonItem = buttonItem;
    
}

-(void)initAzureClient
{
    mobileService = [[azureMobileService alloc]initAzureClient];
    mobileService.delegate = self;
    
    [self getData];
}

-(void)getData
{
    [mobileService getFullListingItemForTableWithName:[AICommonUtils getAzureTableNameForTable:tableAllTradeItem]];
    
    [self createLoadingScreen];
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


-(void)createLoadingScreen
{
    if (!screen)
    {
        screen = [[LoadingScreen alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) forSuperView:self.view atTarget:self];
        screen.backgroundColor = [AICommonUtils getAIColorWithRGB0_32_44:0.4];
        [self.view addSubview:screen];
    }
}

-(void)dismissLoadingScreen
{
    if (screen)
    {
        [UIView animateWithDuration:0.5 animations:^{
            screen.alpha = 0;
        }completion:^(BOOL finished){
            [screen removeFromSuperview];
            screen = nil;
        }];
    }
}



-(void)addAnnotation
{
    [self.mapView removeAnnotations:self.mapView.annotations];
    
    for (int i = 0; i < [listinArray count]; i++)
    {
        NSMutableDictionary *tempdic = [[NSMutableDictionary alloc]init];
        tempdic = [[listinArray objectAtIndex:i] mutableCopy];
        
        CLLocationCoordinate2D coord;
        
        coord = CLLocationCoordinate2DMake([[tempdic objectForKey:@"latitude"] doubleValue], [[tempdic objectForKey:@"longitude"] doubleValue]);
        
        MKPointAnnotation *LocationAnnotation = [[MKPointAnnotation alloc]init];
        LocationAnnotation.coordinate = coord;
        LocationAnnotation.title = [tempdic objectForKey:@"name"];
        LocationAnnotation.subtitle = [tempdic objectForKey:@"userName"];
        
        [self.mapView addAnnotation:LocationAnnotation];
    }
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
        annotationView.image = [UIImage imageNamed:@"big_map_pin"];
        annotationView.centerOffset = CGPointMake(0, -20); // To rectify the view's position off set due to the size of image
        
        // Setup merchant image view
        UIImageView *merchantImageView = [[UIImageView alloc] initWithFrame:CGRectMake(4, 4, 52, 52)];
        merchantImageView.layer.cornerRadius = merchantImageView.frame.size.height / 2;
        merchantImageView.clipsToBounds = YES;
        merchantImageView.image = [UIImage imageNamed:@"barterCyan"];
        
        for (NSMutableDictionary *dic in listinArray)
        {
            if ([[dic objectForKey:@"name"] isEqualToString:annotation.title] && [[dic objectForKey:@"userName"] isEqualToString:annotation.subtitle])
            {
                NSMutableArray *tempArray = [[NSMutableArray alloc]init];
                tempArray = [dic objectForKey:@"tradeItemImg"];
                
                NSMutableDictionary *tempdic = [[NSMutableDictionary alloc]init];
                tempdic = [tempArray objectAtIndex:0];
                
                merchantImageView.image = [AICommonUtils getImageFromUrl:[tempdic objectForKey:@"imgUrl"]];
                
                break;
            }
        }
        
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
        NSMutableDictionary *tempdic = [[NSMutableDictionary alloc]init];
        
        for (NSMutableDictionary *dic in listinArray)
        {
            if ([[dic objectForKey:@"name"] isEqualToString:view.annotation.title] && [[dic objectForKey:@"userName"] isEqualToString:view.annotation.subtitle])
            {
                tempdic = [dic mutableCopy];
                
                [AICommonUtils navigateToItemDetailsPageWithNavigationController:self.navigationController forDictionary:tempdic];
                
                break;
            }
        }
        
        
    }
}

-(void)mapViewDidFinishRenderingMap:(MKMapView *)mapView fullyRendered:(BOOL)fullyRendered
{
    [self dismissLoadingScreen];
}

-(void)mapViewWillStartRenderingMap:(MKMapView *)mapView
{
    [self createLoadingScreen];
}


#pragma mark - Azure Mobile Service Delegate

-(void)azureMobileServiceDidFinishGetDataForList:(id)object
{
    listinArray = [(NSMutableArray *)object mutableCopy];
    
    NSLog(@"result nearbyme: %@", listinArray);
    
    [self dismissLoadingScreen];
    
    [self addAnnotation];
}

-(void)azureMobileServiceDidFinishGetDataForSingleItem:(id)object
{
    
}

-(void)azureMobileServiceDidFailWithError:(NSError *)error
{
    [self dismissLoadingScreen];
}

@end
