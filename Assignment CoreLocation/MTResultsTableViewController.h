//
//  MTResultsTableViewController.h
//  Assignment CoreLocation
//
//  Created by Michael Tirenin on 5/22/14.
//  Copyright (c) 2014 Michael Tirenin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "MTResultsTableCell.h"
#import "MTRouteViewController.h"

@interface MTResultsTableViewController : UITableViewController

@property (strong, nonatomic) NSArray *mapItems;

@end
