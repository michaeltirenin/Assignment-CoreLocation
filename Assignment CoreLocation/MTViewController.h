//
//  MTViewController.h
//  Assignment CoreLocation
//
//  Created by Michael Tirenin on 5/21/14.
//  Copyright (c) 2014 Michael Tirenin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "MTResultsTableViewController.h"

//can also import using this syntax
//@import MapKit;
//@import CoreLocation;

@interface MTViewController : UIViewController <CLLocationManagerDelegate, UISearchDisplayDelegate, UISearchBarDelegate, MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) MKLocalSearchResponse *response;

- (IBAction)changeMapType:(UIBarButtonItem *)sender;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *detailsButton;

@end
