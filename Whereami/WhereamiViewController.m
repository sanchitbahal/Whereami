#import "WhereamiViewController.h"
#import "BNRMapPoint.h"

@implementation WhereamiViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        locationManager.distanceFilter = 50;
//        [locationManager startUpdatingHeading];
    }
    
    return self;
}

- (void)viewDidLoad
{
    worldView.showsUserLocation = YES;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *userLocation = [locations lastObject];
    NSLog(@"New Location: %@", userLocation);
    
    NSTimeInterval timeInterval = [userLocation.timestamp timeIntervalSinceNow];
    if (timeInterval < -180) return;
    
    [self foundLocation:userLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"Could not find location: %@", error);
}

- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading
{
    NSLog(@"New Heading: %@", newHeading);
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    [self foundLocation:userLocation.location];
}

- (void)findLocation
{
    [locationManager startUpdatingLocation];
    [activityIndicator startAnimating];
    locationTitleField.hidden = YES;
}

- (void)foundLocation:(CLLocation *)loc
{
    CLLocationCoordinate2D centerCoordinate = loc.coordinate;
    
    BNRMapPoint *mapPoint = [[BNRMapPoint alloc] initWithCoordinate:centerCoordinate title:locationTitleField.text];
    [worldView addAnnotation:mapPoint];
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(centerCoordinate, 250, 250);
    [worldView setRegion:region animated:YES];
    
    locationTitleField.text = @"";
    [activityIndicator stopAnimating];
    locationTitleField.hidden = NO;
    [locationManager stopUpdatingLocation];
}

- (IBAction)mapTypeChanged:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 0)
        worldView.mapType = MKMapTypeStandard;
    else if (sender.selectedSegmentIndex == 1)
        worldView.mapType = MKMapTypeSatellite;
    else
        worldView.mapType = MKMapTypeHybrid;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self findLocation];
    [textField resignFirstResponder];
    return YES;
}

- (void)dealloc
{
    locationManager.delegate = nil;
}

@end
