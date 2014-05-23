//
//  MTRouteViewController.h
//  Assignment CoreLocation
//
//  Created by Michael Tirenin on 5/22/14.
//  Copyright (c) 2014 Michael Tirenin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <AVFoundation/AVFoundation.h>

@interface MTRouteViewController : UIViewController <MKMapViewDelegate, AVSpeechSynthesizerDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *routeMap;
@property (strong, nonatomic) MKMapItem *destination;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *playPauseButton;
@property (strong, nonatomic) AVSpeechSynthesizer *synthesizer;

//- (void)zoomToPolyLine:(MKMapView *)mapView polyLine:(MKPolyline *)polyLine;

@end
