//
//  NearMeViewController.m
//  Street_Treat
//
//  Created by Kamlesh Dubey on 8/22/16.
//  Copyright © 2016 Digillence Rolson. All rights reserved.
//

#import "NearMeViewController.h"

@interface NearMeViewController (){
    UIView *contentView;
    UPStackMenu *stack;
}


@end

@implementation NearMeViewController
@synthesize mapView;

-(void)viewWillAppear:(BOOL)animated{
    
    self.rootNav = (CCKFNavDrawer *)self.navigationController;
    [self.rootNav setCCKFNavDrawerDelegate:self];
    self.tabBarController.tabBar.tintColor = [UIColor redColor];
    [commonclass setNavigationController:self.navigationController tabBarController:self.tabBarController];
}


-(void)showLocName{
    
    //    if ([[delegate.defaults valueForKey:@"myloc"] isEqualToString:@"locupdatefrom"]){
    //        txfSearchField.text = [delegate.defaults valueForKey:@"myloc_name"];
    //                txfSearchField.textColor = [UIColor whiteColor];
    //                [self getNearbyDealsWithLatitude:currentLatitude longitude:currentLongitude radius:userRadius];
    //                [timer invalidate];
    //    }else{
    //        txfSearchField.text = [delegate.defaults valueForKey:@"loc_name"];
    //            NSString * loc = [delegate.defaults valueForKey:@"loc_name"];
    //            if(loc.length == 0){
    //                txfSearchField.text = [delegate.defaults valueForKey:@"myloc_name"];
    //            }
    //                txfSearchField.textColor = [UIColor whiteColor];
    //                [self getNearbyDealsWithLatitude:currentLatitude longitude:currentLongitude radius:userRadius];
    //                [timer invalidate];
    //        }
    
    //    if ([[delegate.defaults valueForKey:@"myloc"] isEqualToString:@"locupdatefrom"]){
    //        searchField.text = [delegate.defaults valueForKey:@"myloc_name"];
    //    }else{
    //        searchField.text = [delegate.defaults valueForKey:@"loc_name"];
    //    }
    
    NSString * loc = [delegate.defaults valueForKey:@"loc_name"];
    if(loc.length == 0){
        searchField.text = [delegate.defaults valueForKey:@"myloc_name"];
        searchField.textColor = [UIColor whiteColor];
        //        [self getNearbyDealsWithLatitude:currentLatitude longitude:currentLongitude radius:userRadius];
        //        [timer invalidate];
    }else{
        searchField.text = [delegate.defaults valueForKey:@"loc_name"];
        searchField.textColor = [UIColor whiteColor];
        //        [self getNearbyDealsWithLatitude:currentLatitude longitude:currentLongitude radius:userRadius];
        //        [timer invalidate];
    }
    //NSLog(@"loc.. %@",loc);
}


-(void)viewDidAppear:(BOOL)animated{
    
    [self showLocName];
    if ([delegate.defaults valueForKey:@"user_latitude"] == nil){
        currentLatitude = [[delegate.defaults valueForKey:@"latitude"] floatValue];
        currentLongitude = [[delegate.defaults valueForKey:@"longitude"] floatValue];
    }else{
        currentLatitude = [[delegate.defaults valueForKey:@"user_latitude"] floatValue];
        currentLongitude = [[delegate.defaults valueForKey:@"user_longitude"] floatValue];
        
    }
    
//    userLatitude = [[delegate.defaults valueForKey:@"latitude"] floatValue];
//    userLongitude = [[delegate.defaults valueForKey:@"longitude"] floatValue];
//    currentLatitude = [[delegate.defaults valueForKey:@"user_latitude"] floatValue];
//    currentLongitude = [[delegate.defaults valueForKey:@"user_longitude"] floatValue];
    userRadius = [[delegate.defaults valueForKey:@"radius"] floatValue];
    mapView.delegate = self;
    
    [self setCircleOverlaywithlatitude:currentLatitude longitude:currentLongitude];
    [self setUpstackMenu];
}

-(void)setUpstackMenu{
    contentView = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 60, self.view.frame.size.height+5 , 35, 35)];
    [contentView setBackgroundColor:[UIColor redColor]];
    [contentView.layer setCornerRadius:18.0f];
    UIImageView *icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"plus"]];
    [icon setContentMode:UIViewContentModeScaleAspectFit];
    [icon setFrame:CGRectMake(contentView.frame.size.width/6, contentView.frame.size.height/6, 25, 25)];
    [contentView addSubview:icon];
    
    if(stack)
        [stack removeFromSuperview];
    
    stack = [[UPStackMenu alloc] initWithContentView:contentView];
    //[stack setCenter:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2 + 20)];
    [stack setDelegate:self];
    
    UPStackMenuItem *squareItem = [[UPStackMenuItem alloc] initWithImage:[UIImage imageNamed:@"Download_Excel"] highlightedImage:[UIImage imageNamed:@"Download_Excel"] title:@"View Favourites"];
    UPStackMenuItem *circleItem = [[UPStackMenuItem alloc] initWithImage:[UIImage imageNamed:@"Email_Excel"] highlightedImage:[UIImage imageNamed:@"Download_Excel"] title:@"Update Profile"];
//    UPStackMenuItem *viewItem = [[UPStackMenuItem alloc] initWithImage:[UIImage imageNamed:@"Email_Excel"] highlightedImage:[UIImage imageNamed:@"Download_Excel"] title:@"Add Reviews"];
    
    NSMutableArray *items = [[NSMutableArray alloc] initWithObjects:squareItem, circleItem, nil];
    [items enumerateObjectsUsingBlock:^(UPStackMenuItem *item, NSUInteger idx, BOOL *stop) {
        [item setTitleColor:[UIColor redColor]];
        //item.backgroundColor = [UIColor darkGrayColor];
    }];
    
    [stack setAnimationType:UPStackMenuAnimationType_progressive];
    [stack setStackPosition:UPStackMenuStackPosition_up];
    [stack setOpenAnimationDuration:.4];
    [stack setCloseAnimationDuration:.4];
    [items enumerateObjectsUsingBlock:^(UPStackMenuItem *item, NSUInteger idx, BOOL *stop) {
        [item setLabelPosition:UPStackMenuItemLabelPosition_left];
        [item setLabelPosition:UPStackMenuItemLabelPosition_left];
    }];
    
    [stack addItems:items];
    
    [self.tabBarController.view addSubview:stack];
    
    [self setStackIconClosed:YES];
}

#pragma mark - UPStackMenuDelegate
- (void)setStackIconClosed:(BOOL)closed{
    UIImageView *icon = [[contentView subviews] objectAtIndex:0];
    float angle = closed ? 0 : (M_PI * (135) / 180.0);
    [UIView animateWithDuration:0.3 animations:^{
        [icon.layer setAffineTransform:CGAffineTransformRotate(CGAffineTransformIdentity, angle)];
    }];
}

- (void)stackMenuWillOpen:(UPStackMenu *)menu{
    flyoutView = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height/1.3, self.view.frame.size.width, self.view.frame.size.height/4)];
    flyoutView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:flyoutView];
    if([[contentView subviews] count] == 0)
        return;
    [self setStackIconClosed:NO];
}

- (void)stackMenuWillClose:(UPStackMenu *)menu{
    [flyoutView removeFromSuperview];
    if([[contentView subviews] count] == 0)
        return;
    [self setStackIconClosed:YES];
}

- (void)stackMenu:(UPStackMenu *)menu didTouchItem:(UPStackMenuItem *)item atIndex:(NSUInteger)index{
//    NSString *message = [NSString stringWithFormat:@"Item touched : %@", item.title];
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:message message:nil delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
//    [alert show];
    
    if(index == 0){
        [delegate.defaults setValue:@"Favourites" forKey:@"route"];
        [commonclass Redirect:self.navigationController Identifier:@"ResultsViewController"];
    }else if(index == 1){
        [commonclass Redirect:self.navigationController Identifier:@"ProfileViewController"];
    }else if (index == 2){
        
    }
    [stack closeStack];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden =true;
    commonclass = [[Common alloc]init];
    commonclass.delegate = self;
    delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [commonclass addNavigationBar:self.view];
    nearMeData = [[NSMutableData alloc]init];
    nearMeArr = [[NSMutableArray alloc]init];
    
    UIButton *back = (UIButton *)[self.view viewWithTag:1111];
    back.hidden = true;
    UIButton *notifications = (UIButton *)[self.view viewWithTag:222];
    [notifications addTarget:self action:@selector(notificationsTapped) forControlEvents:UIControlEventTouchUpInside];
    UIButton *Menu = (UIButton *)[self.view viewWithTag:111];
    [Menu addTarget:self action:@selector(MenuToggle) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *current_Loc = (UIButton *)[self.view viewWithTag:444];
    [current_Loc addTarget:self action:@selector(FindCurrentTapped) forControlEvents:UIControlEventTouchUpInside];

    search = (UISearchBar *)[self.view viewWithTag:11111];
    searchField = [search valueForKey:@"_searchField"];
    
}

-(void)FindCurrentTapped{
    [delegate.defaults setValue:@"myloc" forKey:@"locupdatefrom"];
    searchField.text = [delegate.defaults valueForKey:@"myloc_name"];
    [delegate.defaults setValue:searchField.text forKey:@"loc_name"];
    currentLatitude = [[delegate.defaults valueForKey:@"latitude"]floatValue];
    currentLongitude = [[delegate.defaults valueForKey:@"longitude"]floatValue];
    
    [delegate.defaults setValue:[delegate.defaults valueForKey:@"latitude"] forKey:@"user_latitude"];
    [delegate.defaults setValue:[delegate.defaults valueForKey:@"longitude"] forKey:@"user_longitude"];
    [delegate.defaults synchronize];
    
    
    
   [self setCircleOverlaywithlatitude:currentLatitude longitude:currentLongitude];
}


- (void)mapView:(GMSMapView *)mapView didTapInfoWindowOfMarker:(GMSMarker *)marker {
   // NSLog(@"zindex.. %d",marker.zIndex);
    NSString * storeID = [nearMeArr[marker.zIndex] valueForKey:@"store_id"];
    [delegate.defaults setValue:storeID forKey:@"store_ID"];
    [delegate.defaults synchronize];
    [commonclass Redirect:self.navigationController Identifier:@"DetailViewController"];
    
}

-(void)notificationsTapped{
    NotificationsViewController * notifications = [self.storyboard instantiateViewControllerWithIdentifier:@"NotificationsViewController"];
    [self presentViewController:notifications animated:YES completion:nil];
}

-(void)MenuToggle{
    [self.rootNav drawerToggle];
}


-(void)CCKFNavDrawerSelection:(NSInteger)selectedSession selectedRow: (NSInteger) row {
    [commonclass DrawerTapped:selectedSession selectedRow: row];
}

-(void)setCircleOverlaywithlatitude:(float)latitude longitude:(float)longitude {
    [mapView clear];
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:latitude longitude:longitude zoom:13];
    mapView.camera = camera;
    mapView.myLocationEnabled = YES;
    
    CLLocationCoordinate2D circleCenter = CLLocationCoordinate2DMake(latitude,longitude);
    circ = [GMSCircle circleWithPosition:circleCenter radius:3000];
    
    circ.fillColor = [UIColor MapRadiusColor];
    circ.strokeColor = [UIColor clearColor];
    circ.strokeWidth = 5;
    circ.map = mapView;
    
    [self getNearbyShopswithlatitude:latitude longitude:longitude];
}

-(void)getNearbyShopswithlatitude:(float)latitude longitude:(float)longitude{
    NSString *messageBody = [NSString stringWithFormat:@"log_id=%@&latitude=%f&longitude=%f&current_latitude=%@&current_longitude=%@&radius=%f",[delegate.defaults valueForKey:@"logid"],latitude,longitude,[delegate.defaults valueForKey:@"latitude"],[delegate.defaults valueForKey:@"longitude"],userRadius];
    NSLog(@"body.. %@",messageBody);
    NSLog(@"commonclass.searchListURL.. %@",commonclass.searchListURL);
    [commonclass sendRequest:self.view mutableDta:nearMeData url:commonclass.searchListURL msgBody:messageBody];
}

- (void)sendResponse:(Common *)response data:(NSMutableArray*)data indicator:(UIActivityIndicatorView *)indicator{
    NSLog(@"data.. %@",data);
    dispatch_sync(dispatch_get_main_queue(), ^{
        if([[data valueForKey:@"status"]intValue] == 1){
            nearMeArr = [data valueForKey:@"items"];
            [self addAnnotations:nearMeArr];
        }else if([[data valueForKey:@"status"]intValue] == -1){
          
            [commonclass logoutFunction];
        }else{
            [self.view makeToast:@"No Offer added yet for the location" duration:4.0 position:CSToastPositionBottom];
        }
        [indicator stopAnimating];
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    });

}

-(void)addAnnotations:(NSMutableArray *)markers{
    for(int i=0;i<[markers count];i++){
        NSString * latstr = [markers[i] valueForKey:@"latitude"];
        NSString * longstr = [markers[i] valueForKey:@"longitude"];
        NSLog(@"Lat.. %@ Long.. %@",[markers[i] valueForKey:@"latitude"],[markers[i] valueForKey:@"longitude"]);
        NSString * discamm = [markers[i] valueForKey:@"exclusive_discount"];
        
        CLLocationCoordinate2D position = CLLocationCoordinate2DMake([latstr floatValue], [longstr floatValue]);
        
        GMSMarker *marker = [GMSMarker markerWithPosition:position];
        marker.icon = [UIImage imageNamed:@"Map_Pin.png"];
        marker.title =[NSString stringWithFormat:@"%@%%",discamm];
        marker.zIndex = i;
        marker.map = mapView;
        [mapView setSelectedMarker:marker];
    }
}

-(void)CurrentLocationIdentifier
{
    //---- For getting current gps location
    locationManager = [CLLocationManager new];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
    //------
}

- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region{
    // Show an alert or otherwise notify the user
}

- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region{
    
}

- (void)locationManager:(CLLocationManager *)manager monitoringDidFailForRegion:(CLRegion *)region withError:(NSError *)error{
    
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    NSString * latstring = [NSString stringWithFormat:@"%f", locationManager.location.coordinate.latitude];
    NSString * longstring = [NSString stringWithFormat:@"%f", locationManager.location.coordinate.longitude];
    //CLPlacemark *placemark;
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init] ;
    [geocoder reverseGeocodeLocation:self->locationManager.location
                   completionHandler:^(NSArray *placemarks, NSError *error) {
                       NSLog(@"reverseGeocodeLocation:completionHandler: Completion Handler called!");
                       
                       if (error){
                           NSLog(@"Geocode failed with error: %@", error);
                           return;
                           
                       }
                       
                       CLPlacemark *placemark = [placemarks objectAtIndex:0];
                       
                       //     NSLog(@"placemark.ISOcountryCode %@",placemark.ISOcountryCode);
                       //     NSLog(@"placemark.country %@",placemark.country);
                       //     NSLog(@"placemark.locality %@",placemark.locality );
                       //     NSLog(@"placemark.postalCode %@",placemark.postalCode);
                       //     NSLog(@"placemark.administrativeArea %@",placemark.administrativeArea);
                       //     NSLog(@"placemark.locality %@",placemark.subLocality);
                       locality = [NSString stringWithFormat:@"%@",placemark.subLocality];
                       //     NSLog(@"placemark.subLocality %@",placemark.subLocality);
                       //     NSLog(@"placemark.subThoroughfare %@",placemark.subThoroughfare);
                       
                   }];
    
    // NSLog(@"Locality.. %@",locality);
    
    [delegate.defaults setValue:latstring forKey:@"latitude"];
    [delegate.defaults setValue:longstring forKey:@"longitude"];
    
    //    if([[[defaults dictionaryRepresentation] allKeys] containsObject:@"loc_name"]){
    //        NSLog(@"mykey found");
    //    }else{
    [delegate.defaults setValue:locality forKey:@"updateloc_name"];
    [delegate.defaults setValue:@"myloc" forKey:@"locupdatefrom"];
    if (locality != nil){
    [delegate.defaults setValue:locality forKey:@"myloc_name"];
    }
    //}
    [delegate.defaults synchronize];
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    if([CLLocationManager locationServicesEnabled]){
        if([CLLocationManager authorizationStatus]==kCLAuthorizationStatusDenied){
            [self CreateLocationEnabler];
        }else{
            //            seg_string = @"High Street";
            //            [self getDatawithStoreCategory:@"High Street" latitude:userLatitude longitude:userLongitude radius:userRadius];
        }
    }else{
        [self CreateLocationEnabler];
    }
}

-(void)CreateLocationEnabler{
    locationenablerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    //locationenablerView.backgroundColor = [UIColor Location_ServiceClr];
    locationenablerView.backgroundColor = [UIColor whiteColor];
    UIImageView * locationEnablerImg = [[UIImageView alloc]init];
    locationEnablerImg.contentMode = UIViewContentModeScaleAspectFit;
    //locationEnablerImg.backgroundColor = [UIColor yellowColor];
    locationEnablerImg.frame = CGRectMake(0, 54, self.view.frame.size.width, self.view.frame.size.height / 1.8);
    locationEnablerImg.image = [UIImage imageNamed:@"Location_Service.png"];
    
    [commonclass addNavigationBar:locationenablerView];
    
    UIButton *current_Loc = (UIButton *)[locationenablerView viewWithTag:444];
    current_Loc.hidden = true;
    
    UISearchBar *searchbr = (UISearchBar *)[locationenablerView viewWithTag:11111];
    searchbr.hidden = true;
    
    UIButton * btnEnable = [UIButton buttonWithType:UIButtonTypeCustom];
    btnEnable.frame = CGRectMake(self.view.frame.size.width / [commonclass.passEnablePos floatValue], (locationEnablerImg.frame.origin.y + locationEnablerImg.frame.size.height) + 15, 145, 40);
    [btnEnable setTitle:@"ENABLE" forState:UIControlStateNormal];
    [btnEnable.titleLabel setFont:[UIFont fontWithName:@"Raleway-Bold" size:14]];
    [btnEnable addTarget:self action:@selector(EnableLocation) forControlEvents:UIControlEventTouchUpInside];
    btnEnable.backgroundColor = [UIColor redColor];
    btnEnable.layer.cornerRadius = 18.0f;
    
    UILabel * lblLine1 = [[UILabel alloc]initWithFrame:CGRectMake(8, (btnEnable.frame.origin.y + btnEnable.frame.size.height) + 15, self.view.frame.size.width / 2.3, 2)];
    lblLine1.backgroundColor = [UIColor lightGrayColor];
    [locationenablerView addSubview:lblLine1];
    
    UILabel * orLbl = [[UILabel alloc]initWithFrame:CGRectMake((lblLine1.frame.origin.x + lblLine1.frame.size.width)+3, lblLine1.frame.origin.y - 5, 15, 15)];
    orLbl.text = @"OR";
    orLbl.textColor = [UIColor lightGrayColor];
    orLbl.font = [UIFont fontWithName:@"Raleway" size:9];
    [locationenablerView addSubview:orLbl];
    
    UILabel * lblLine2 = [[UILabel alloc]initWithFrame:CGRectMake((orLbl.frame.origin.x + orLbl.frame.size.width)+3, (btnEnable.frame.origin.y + btnEnable.frame.size.height) + 15, self.view.frame.size.width / 2.3, 2)];
    lblLine2.backgroundColor = [UIColor lightGrayColor];
    [locationenablerView addSubview:lblLine2];
    
    UIButton * btnManual = [UIButton buttonWithType:UIButtonTypeCustom];
    btnManual.frame = CGRectMake(self.view.frame.size.width / [commonclass.passEnablePos floatValue], (lblLine2.frame.origin.y + lblLine2.frame.size.height) + 15, 145, 40);
    [btnManual.titleLabel setFont:[UIFont fontWithName:@"Raleway-Bold" size:14]];
    [btnManual setTitle:@"ENTER MANUALLY" forState:UIControlStateNormal];
    [btnManual addTarget:self action:@selector(EnterManualLocation) forControlEvents:UIControlEventTouchUpInside];
    btnManual.backgroundColor = [UIColor redColor];
    btnManual.layer.cornerRadius = 18.0f;
    
    [locationenablerView addSubview:btnManual];
    [locationenablerView addSubview:btnEnable];
    [locationenablerView addSubview:locationEnablerImg];
    
    // [self.view addSubview:locationenablerView];
    [[[UIApplication sharedApplication] keyWindow] addSubview:locationenablerView];
}

-(void)EnableLocation{
    NSLog(@"authorizationStatus.. %d",[CLLocationManager authorizationStatus]);
    if([CLLocationManager authorizationStatus]==kCLAuthorizationStatusDenied){
        [self requestAlwaysAuthorization];
    }
}

- (void)requestAlwaysAuthorization
{
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    
    // If the status is denied or only granted for when in use, display an alert
    if (status == kCLAuthorizationStatusAuthorizedWhenInUse || status == kCLAuthorizationStatusDenied) {
        NSString *title;
        title = (status == kCLAuthorizationStatusDenied) ? @"Location services are off" : @"Background location is not enabled";
        NSString *message = @"To use background location you must turn on 'Always' in the Location Services Settings";
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                            message:message
                                                           delegate:self
                                                  cancelButtonTitle:@"Cancel"
                                                  otherButtonTitles:@"Settings", nil];
        [alertView show];
    }
    // The user has not enabled any location services. Request background authorization.
    else if (status == kCLAuthorizationStatusNotDetermined) {
        [locationManager requestAlwaysAuthorization];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        locationenablerView.hidden = true;
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"App-Prefs:root=Privacy&path=Contacts"]];
    }
}

-(void)EnterManualLocation{
    [self.view makeToast:@"coming soon"];
}

#pragma mark - Autocomlete Methods
- (void)autocomplete:(Common *)response{
    GMSAutocompleteViewController *acController = [[GMSAutocompleteViewController alloc] init];
    acController.delegate = self;
    [self presentViewController:acController animated:YES completion:nil];
}

- (void)viewController:(GMSAutocompleteViewController *)viewController
didAutocompleteWithPlace:(GMSPlace *)place {
    
    currentLatitude = place.coordinate.latitude;
    currentLongitude = place.coordinate.longitude;
    
    NSString *userLatitude1 = [NSString stringWithFormat:@"%f",place.coordinate.latitude];
    NSString *userLongitude1 = [NSString stringWithFormat:@"%f",place.coordinate.longitude];
    
    [delegate.defaults setValue:userLatitude1 forKey:@"user_latitude"];
    [delegate.defaults setValue:userLongitude1 forKey:@"user_longitude"];
    [delegate.defaults setValue:place.name forKey:@"loc_name"];
    searchField.text = place.name;
    searchField.textColor = [UIColor whiteColor];
//    [self setCircleOverlaywithlatitude:place.coordinate.latitude longitude:place.coordinate.longitude];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewController:(GMSAutocompleteViewController *)viewController
didFailAutocompleteWithError:(NSError *)error {
    [self dismissViewControllerAnimated:YES completion:nil];
    // TODO: handle the error.
    NSLog(@"Error: %@", [error description]);
}

- (void)wasCancelled:(GMSAutocompleteViewController *)viewController {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didRequestAutocompletePredictions:(GMSAutocompleteViewController *)viewController {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)didUpdateAutocompletePredictions:(GMSAutocompleteViewController *)viewController {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

-(void)viewDidDisappear:(BOOL)animated{
    [contentView removeFromSuperview];
    [stack removeFromSuperview];
    [flyoutView removeFromSuperview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
