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
//    UIButton *back = (UIButton *)[self.view viewWithTag:1111];
//    back.hidden = true;
    self.tabBarController.tabBar.tintColor = [UIColor redColor];
}

-(void)viewDidAppear:(BOOL)animated{
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
    searchField.text = [delegate.defaults valueForKey:@"loc_name"];
    searchField.textColor = [UIColor whiteColor];
    
    userLatitude = [[delegate.defaults valueForKey:@"latitude"] floatValue];
    userLongitude = [[delegate.defaults valueForKey:@"longitude"] floatValue];
    currentLatitude = [[delegate.defaults valueForKey:@"latitude"] floatValue];
    currentLongitude = [[delegate.defaults valueForKey:@"longitude"] floatValue];
    userRadius = [[delegate.defaults valueForKey:@"radius"] floatValue];

    mapView.delegate = self;
    
    [self setCircleOverlaywithlatitude:userLatitude longitude:userLongitude];
}

-(void)FindCurrentTapped{
    [delegate.defaults setValue:@"myloc" forKey:@"locupdatefrom"];
    searchField.text = [delegate.defaults valueForKey:@"myloc_name"];
   [self setCircleOverlaywithlatitude:userLatitude longitude:userLongitude];
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

-(void)CCKFNavDrawerSelection:(NSInteger)selectionIndex{
    [self DrawerTapped:selectionIndex];
}

#pragma mark - photoShotSavedDelegate
- (void)DrawerTapped:(NSInteger)selectionIndex{
    if([[delegate.defaults valueForKey:@"drawerRoute"] isEqualToString:@"Section"]){
        NSLog(@"index.. %ld",(long)selectionIndex);
        switch (selectionIndex) {
            case 0:
            {
                SearchStoreViewController * searchStore = [self.storyboard instantiateViewControllerWithIdentifier:@"SearchStoreViewController"];
                // [self.navigationController pushViewController:searchStore animated:NO];
                //MyModalViewController *modalViewController = [[MyModalViewController alloc] init];
                [searchStore setReferencedNavigation:self.navigationController];
                searchStore.modalPresentationStyle = UIModalPresentationOverCurrentContext;
                [self.tabBarController presentViewController:searchStore animated:YES completion:nil];
            }
                break;
            case 1:
            {
                NSString * catID = [delegate.defaults valueForKey:@"MensCategory"];
                [delegate.defaults setValue:catID forKey:@"category"];
                [delegate.defaults setValue:@"Store" forKey:@"route"];
                [delegate.defaults synchronize];
                [self showResults];
            }
                break;
            case 2:
            {
                NSString * catID = [delegate.defaults valueForKey:@"WomensCategory"];
                [delegate.defaults setValue:catID forKey:@"category"];
                [delegate.defaults setValue:@"Store" forKey:@"route"];
                [delegate.defaults synchronize];
                [self showResults];
            }
                break;
            case 3:
            {
                NSString * catID = [delegate.defaults valueForKey:@"ChildrenCategory"];
                [delegate.defaults setValue:catID forKey:@"category"];
                [delegate.defaults setValue:@"Store" forKey:@"route"];
                [delegate.defaults synchronize];
                [self showResults];
            }
                break;
            case 4:
                // [self showExhibitions];
                break;
            case 5:
                setType = @"about-us";
                [self StaticContent];
                break;
            case 6:
                setType = @"News-Events";
                [self StaticContent];
                break;
            case 7:
                setType = @"Terms And Conditions";
                [self StaticContent];
                break;
            case 8:
                setType = @"faqs";
                [self StaticContent];
                break;
            case 9:
                setType = @"privacy";
                [self StaticContent];
                break;
            case 10:{
                [commonclass Redirect:self.navigationController Identifier:@"ContactViewController"];
                //                ContactViewController * contact = [self.storyboard instantiateViewControllerWithIdentifier:@"ContactViewController"];
                //                [self.navigationController pushViewController:contact animated:YES];
            }
                break;
            case 11:{
                ProfileViewController * profile = [self.storyboard instantiateViewControllerWithIdentifier:@"ProfileViewController"];
                [self.navigationController pushViewController:profile animated:YES];
                self.tabBarController.tabBar.tintColor = [UIColor lightGrayColor];
            }
                break;
            case 12:{
                //                ChangePasswordViewController * password = [self.storyboard instantiateViewControllerWithIdentifier:@"ChangePasswordViewController"];
                //                [self.navigationController pushViewController:password animated:YES];
                //                self.tabBarController.tabBar.tintColor = [UIColor lightGrayColor];
            }
                break;
            case 13:{
                HelpViewController * help = [self.storyboard instantiateViewControllerWithIdentifier:@"HelpViewController"];
                [self.navigationController pushViewController:help animated:YES];
                self.tabBarController.tabBar.tintColor = [UIColor lightGrayColor];
            }
                break;
            case 14:{
                NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
                [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
                [delegate.defaults setValue:@"19.1183" forKey:@"latitude"];
                [delegate.defaults setValue:@"73.0276" forKey:@"longitude"];
                //[delegate.defaults setValue:@"Mahape" forKey:@"loc_name"];
                [delegate.defaults setValue:@"3" forKey:@"radius"];
                ViewController * splash = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
                UINavigationController *passcodeNavigationController = [[UINavigationController alloc] initWithRootViewController:splash];
                [self presentViewController:passcodeNavigationController animated:YES completion:nil];
            }
                break;
                
            default:
                break;
        }
    }
    else{
        if(selectionIndex == 1){
            
        }
        if(selectionIndex == 2){
            
        }
        if(selectionIndex == 3){
            
        }
        if(selectionIndex == 4){
            
        }
    }
}

-(void)showResults{
    [delegate.defaults setObject:@"Category" forKey:@"resultType"];
    [delegate.defaults synchronize];
    ResultsViewController * result = [self.storyboard instantiateViewControllerWithIdentifier:@"ResultsViewController"];
    [self.navigationController pushViewController:result animated:YES];
    self.tabBarController.tabBar.tintColor = [UIColor lightGrayColor];
}

-(void)StaticContent{
    //NSLog(@"type StaticContent .. %@",setType);
    [delegate.defaults setObject:setType forKey:@"staticType"];
    [delegate.defaults synchronize];
    StaticDataViewController * info = [self.storyboard instantiateViewControllerWithIdentifier:@"StaticDataViewController"];
    [self.navigationController pushViewController:info animated:YES];
    self.tabBarController.tabBar.tintColor = [UIColor lightGrayColor];
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
    NSString *messageBody = [NSString stringWithFormat:@"log_id=%@&latitude=%f&longitude=%f&current_latitude=%f&current_longitude=%f&radius=%f",[delegate.defaults valueForKey:@"logid"],latitude,longitude,currentLatitude,currentLongitude,userRadius];
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
    [delegate.defaults setValue:locality forKey:@"myloc_name"];
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
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=Privacy&path=Contacts"]];
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
    [self dismissViewControllerAnimated:YES completion:nil];
    search.text = place.name;
    [self setCircleOverlaywithlatitude:place.coordinate.latitude longitude:place.coordinate.longitude];
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
    //[stack removeFromSuperview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
