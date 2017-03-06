//
//  DirectionViewController.m
//  Street_Treat
//
//  Created by Kamlesh Dubey on 2/1/17.
//  Copyright © 2017 Digillence Rolson. All rights reserved.
//

#import "DirectionViewController.h"

@interface DirectionViewController ()

@end

@implementation DirectionViewController
@synthesize mapView;

-(void)viewDidAppear:(BOOL)animated{
    
//    NSString* webName = [localisationName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    NSString* stringURL = [NSString stringWithFormat:@"http://maps.google.com/maps/geo?q=%@,Montréal,Communauté-Urbaine-de-Montréal,Québec,Canadae&output=csv&oe=utf8&sensor=false", webName];
    //NSString* webStringURL = [stringURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
   // NSURL* url = [NSURL URLWithString:webStringURL];
//    
//    NSString * urlFormatted = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/directions/json?origin=%@&destination=%@&key=AIzaSyC0PB4TaEAcTQUXegZKNrmN6FSB7iC-G0U",userSublocality,currentSublocality];
//     NSString* webStringURL = [urlFormatted stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    NSURL *url = [NSURL URLWithString:webStringURL];
//    NSLog(@"nsurl.. %@",url);
//    NSData* data = [NSData dataWithContentsOfURL:url];
//    NSArray *jsondata = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
//    
//    GMSPath *path = [GMSPath pathFromEncodedPath:[jsondata valueForKey:@"routes"][0][@"overview_polyline"][@"points"]];
//    GMSPolyline *polyline = [GMSPolyline polylineWithPath:path];
//    polyline.strokeColor = [UIColor redColor];
//    polyline.strokeWidth = 3.f;
//    polyline.map = mapView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    [delegate.defaults setObject:@"DirectionViewController" forKey:@"internetdisconnect"];
    commonclass = [[Common alloc]init];
    [commonclass addNavigationBar:self.view];
    
    UIButton *backBtn = (UIButton *)[self.view viewWithTag:1111];
    [backBtn addTarget:self action:@selector(backTapped) forControlEvents:UIControlEventTouchUpInside];
    UIButton *menubtn = (UIButton *)[self.view viewWithTag:111];
    menubtn.hidden = TRUE;
    UIButton *notificationbtn = (UIButton *)[self.view viewWithTag:222];
    notificationbtn.hidden = TRUE;
    UISearchBar * search = (UISearchBar *)[self.view viewWithTag:11111];
    search.hidden = TRUE;
    
    UIButton *current_Loc = (UIButton *)[self.view viewWithTag:444];
    current_Loc.hidden = TRUE;

    
    userLatitude = [[delegate.defaults valueForKey:@"latitude"] floatValue];
    userLongitude = [[delegate.defaults valueForKey:@"longitude"] floatValue];
    
    currentLatitude = [[delegate.defaults valueForKey:@"directionLat"] floatValue];
    currentLongitude = [[delegate.defaults valueForKey:@"directionLong"] floatValue];
    
  /*  CLLocation * LocationUser = [[CLLocation alloc]initWithLatitude:userLatitude longitude:userLongitude];

    CLGeocoder *geocoder = [[CLGeocoder alloc] init] ;
    [geocoder reverseGeocodeLocation:LocationUser
                   completionHandler:^(NSArray *placemarks, NSError *error) {
                       NSLog(@"reverseGeocodeLocation:completionHandler: Completion Handler called!");
                       
                       if (error){
                           NSLog(@"Geocode failed with error: %@", error);
                           return;
                       }
                       CLPlacemark *placemark = [placemarks objectAtIndex:0];
                       userSublocality = placemark.subLocality;
                    }];
    
    currentLatitude = [[delegate.defaults valueForKey:@"directionLat"] floatValue];
    currentLongitude = [[delegate.defaults valueForKey:@"directionLong"] floatValue];
    
    CLLocation * LocationCurrent = [[CLLocation alloc]initWithLatitude:currentLatitude longitude:currentLongitude];
    
    CLGeocoder *geocoderCurrent = [[CLGeocoder alloc] init] ;
    [geocoderCurrent reverseGeocodeLocation:LocationCurrent
                   completionHandler:^(NSArray *placemarks, NSError *error) {
                       NSLog(@"reverseGeocodeLocation:completionHandler: Completion Handler called!");
                       
                       if (error){
                           NSLog(@"Geocode failed with error: %@", error);
                           return;
                       }
                       CLPlacemark *placemark = [placemarks objectAtIndex:0];
                       currentSublocality = placemark.subLocality;
                       isresponse = YES;
                   }];*/
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:userLatitude longitude:userLongitude zoom:11];
    mapView.camera = camera;
   
    CLLocationCoordinate2D position = CLLocationCoordinate2DMake(userLatitude, userLongitude);
    GMSMarker *marker = [GMSMarker markerWithPosition:position];
    marker.icon = [UIImage imageNamed:@"Map_Pin.png"];
    marker.map = mapView;
    
    CLLocationCoordinate2D position2 = CLLocationCoordinate2DMake(currentLatitude, currentLongitude);
    GMSMarker *marker2 = [GMSMarker markerWithPosition:position2];
    marker2.icon = [UIImage imageNamed:@"Map_Pin.png"];
    marker2.map = mapView;
    
    GMSMutablePath *path = [GMSMutablePath path];
    [path addCoordinate:CLLocationCoordinate2DMake(userLatitude, userLongitude)];
    [path addCoordinate:CLLocationCoordinate2DMake(currentLatitude, currentLongitude)];
    GMSPolyline *polyline = [GMSPolyline polylineWithPath:path];
    polyline.map = mapView;
    polyline.strokeColor = [UIColor redColor];
}

-(void)backTapped{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
