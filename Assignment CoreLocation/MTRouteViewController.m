//
//  MTRouteViewController.m
//  Assignment CoreLocation
//
//  Created by Michael Tirenin on 5/22/14.
//  Copyright (c) 2014 Michael Tirenin. All rights reserved.
//

#import "MTRouteViewController.h"

@interface MTRouteViewController ()

@end

@implementation MTRouteViewController

BOOL speechPaused = NO;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    _routeMap.showsUserLocation = YES;
    MKUserLocation *userLocation = _routeMap.userLocation;
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 2000, 2000);
    [_routeMap setRegion:region animated:NO];
    _routeMap.delegate = self;
    [self getDirections];
    
    self.synthesizer = [[AVSpeechSynthesizer alloc] init];
    speechPaused = NO;
    self.synthesizer.delegate = self;
}

- (void)getDirections
{
    MKDirectionsRequest *request = [[MKDirectionsRequest alloc] init];
    
    request.source = [MKMapItem mapItemForCurrentLocation];
    request.destination = _destination;
    request.requestsAlternateRoutes = NO;
    MKDirections *directions = [[MKDirections alloc] initWithRequest:request];
    [directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error) {
        if (error) {
            // handle error
        } else {
            [self showRoute:response];
        }
    }];
}

-(void)showRoute:(MKDirectionsResponse *)response
{
    for (MKRoute *route in response.routes)
    {
        [_routeMap addOverlay:route.polyline level:MKOverlayLevelAboveRoads];
        
        for (MKRouteStep *step in route.steps)
        {
            NSLog(@"%@", step.instructions);
        }
    }
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id < MKOverlay >)overlay
{
    MKPolylineRenderer *renderer = [[MKPolylineRenderer alloc] initWithOverlay:overlay];
    renderer.strokeColor = [UIColor blueColor];
    renderer.lineWidth = 5.0;
    return renderer;
}

//- (void)zoomToPolyLine:(MKMapView *)mapView polyLine:(MKPolyline *)polyLine;
//{
//    MKPolygon* polygon = [MKPolygon polygonWithPoints:polyLine.points count:polyLine.pointCount];
//    [_routeMap setRegion:MKCoordinateRegionForMapRect([polygon boundingMapRect]) animated:YES];
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)playPauseButtonPressed:(UIBarButtonItem *)sender
{
    if (speechPaused == NO) {
        [sender setTitle:@"Pause"];
        speechPaused = YES;
    } else {
        [sender setTitle:@"Play"];
        speechPaused = NO;
    }
   AVSpeechUtterance *utterance = [[AVSpeechUtterance alloc] initWithString:@"Hello there. I didn't quite get to hooking in the step by step directions. And I didn't get the pause button finished. But it is time to check in my assignment."];
   [self.synthesizer speakUtterance:utterance];
//    [self.synthesizer speakUtterance:[AVSpeechUtterance speechUtteranceWithString:_instructions]];
}

@end
