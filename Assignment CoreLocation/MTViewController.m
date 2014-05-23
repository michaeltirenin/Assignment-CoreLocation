//
//  MTViewController.m
//  Assignment CoreLocation
//
//  Created by Michael Tirenin on 5/21/14.
//  Copyright (c) 2014 Michael Tirenin. All rights reserved.

//47.623747, -122.336037 Code Fellows location

#import "MTViewController.h"

@interface MTViewController ()

@end

@implementation MTViewController

- (void)setResponse:(MKLocalSearchResponse *)response
{
    if (_response != response) {
        _response = response;
        
        // without this, search results are not updated immediately
        [self.searchDisplayController.searchResultsTableView reloadData];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    _mapView.showsUserLocation = YES;
//    _mapView.delegate = self;

    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.distanceFilter = 100; // comment out to test
    self.locationManager.desiredAccuracy = 5;
    
    [self.locationManager startUpdatingLocation];
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    _mapView.centerCoordinate = userLocation.coordinate;
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    NSLog(@"%@", locations.lastObject);
    CLLocation *location = locations.lastObject;
    CLLocationCoordinate2D coordinate = location.coordinate;
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate, 500, 500);
    
    [self.mapView setRegion:region animated:YES];
}

#pragma mark - UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    MKLocalSearchRequest *request = [MKLocalSearchRequest new];
    
    [request setRegion:self.mapView.region];
    [request setNaturalLanguageQuery:searchBar.text];
    
    MKLocalSearch *search = [[MKLocalSearch alloc] initWithRequest:request];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES]; // starts spinner in status bar
    
    [search startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error) {
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO]; // stops/hides spinner in status bar
        
        if (error) {
            NSLog(@"%@", [error localizedDescription]);
            return;
        }
        
        if (!response.mapItems.count) {
            NSLog(@"No results found.");
            return;
        }
        
        self.response = response;
        
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.response.mapItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"identifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    
    MKMapItem *item = self.response.mapItems[indexPath.row];
    cell.textLabel.text = item.name;
    cell.detailTextLabel.text = item.placemark.addressDictionary[@"Street"];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.searchDisplayController setActive:NO animated:YES];
    [self.mapView addAnnotation:[self.response.mapItems[indexPath.row]placemark]];
    _detailsButton.enabled = YES; // enables the "Search Details" button

}

// toggles between standard and satellite
- (IBAction)changeMapType:(UIBarButtonItem *)sender
{
    if (_mapView.mapType == MKMapTypeStandard)
        _mapView.mapType = MKMapTypeSatellite;
    else
        _mapView.mapType = MKMapTypeStandard;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    MTResultsTableViewController *destination = [segue destinationViewController];
    destination.mapItems = self.response.mapItems;
}
@end
