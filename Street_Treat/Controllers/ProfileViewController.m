//
//  ProfileViewController.m
//  Street_Treat
//
//  Created by Kamlesh Dubey on 6/21/16.
//  Copyright (c) 2016 Digillence Rolson. All rights reserved.
//

#import "ProfileViewController.h"



@interface ProfileViewController ()

@end

@implementation ProfileViewController
@synthesize lastTxtField ,agetTxtField , birthDateField,profile_Pic,shareBtn,per_infoeditBtn,nmeeditBtn,col_EditBtn,style_EditBtn,apprel_EditBtn;
@synthesize nmeLbl,genderLbl,ageLbl,mobileLbl,emailLbl,per_InfoMainView,per_infoInnerView,clr_PopupView,style_PopupMainview,style_PopupInnerView,mobiletxtFld,emailTxtFld,colorPrefScroll,stylePrefScroll;
@synthesize colorArr,clrBtnsCollection,style_prefArr,apparel_Arr,userapparel_Arr,nametxtFld;
@synthesize shirtTxtFld,tShirtTxtFld,pantsTxtFld,shoesTxtFld,editScroll;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self allocateRequired];
    [self.view bringSubviewToFront:style_PopupMainview];
    agetTxtField.delegate = self;
  //  [self setUpTextFieldDatePicker];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];

    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar.items = @[[[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelNumberPad)],
                            [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],[[UIBarButtonItem alloc]initWithTitle:@"Next" style:UIBarButtonItemStyleDone target:self action:@selector(jumpToNext)],[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                            [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
    [numberToolbar sizeToFit];
    pantsTxtFld.inputAccessoryView = numberToolbar;
    agetTxtField.inputAccessoryView = numberToolbar;
    
    UIToolbar* numberToolbarTxtFlds = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    numberToolbarTxtFlds.barStyle = UIBarStyleBlackTranslucent;
    numberToolbarTxtFlds.items = @[[[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelNumberPad)],
                                   [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                                   [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
    [numberToolbarTxtFlds sizeToFit];
    shoesTxtFld.inputAccessoryView = numberToolbarTxtFlds;
}

-(void)dismissKeyboard
{
    [agetTxtField resignFirstResponder];
}

-(void)cancelNumberPad{
    [self.view endEditing:YES];
}

-(void)jumpToNext{
    [shoesTxtFld becomeFirstResponder];
}

-(void)doneWithNumberPad{
    [self.view endEditing:YES];
}

//-(void)HelpViewControllerDidTapButton:(HelpViewController *)controller{
//    [self dismissViewControllerAnimated:YES completion:^{
//        
//       
//        
//    }];
//}

-(void)viewWillAppear:(BOOL)animated{
  //[self setPersonalPopup];
    [self GetProfile];
    [delegate.defaults setObject:@"ProfileViewController" forKey:@"internetdisconnect"];
    self.rootNav = (CCKFNavDrawer *)self.navigationController;
    [self.rootNav setCCKFNavDrawerDelegate:self];
    
    tagListView = [[AMTagListView alloc] initWithFrame:CGRectMake(20, 40, style_PopupInnerView.frame.size.width-40, style_PopupInnerView.frame.size.height)];
   // [style_PopupInnerView addSubview:tagListView];
    [tagListView setTapHandler:^(AMTagView *view) {
        [view setTagColor:[UIColor darkGrayColor]];
    }];
    
    [apparelSizesViews removeAllObjects];
    
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
    
    [constant addNavigationBar:locationenablerView];
    
    UIButton *current_Loc = (UIButton *)[locationenablerView viewWithTag:444];
    current_Loc.hidden = true;
    
    UISearchBar *searchbr = (UISearchBar *)[locationenablerView viewWithTag:11111];
    searchbr.hidden = true;
    
    UIButton * btnEnable = [UIButton buttonWithType:UIButtonTypeCustom];
    btnEnable.frame = CGRectMake(self.view.frame.size.width / [constant.passEnablePos floatValue], (locationEnablerImg.frame.origin.y + locationEnablerImg.frame.size.height) + 15, 145, 40);
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
    btnManual.frame = CGRectMake(self.view.frame.size.width / [constant.passEnablePos floatValue], (lblLine2.frame.origin.y + lblLine2.frame.size.height) + 15, 145, 40);
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

- (void)keyboardDidShow:(NSNotification *)notification
{
    editScroll.contentSize = CGSizeMake(editScroll.frame.size.width, editScroll.frame.size.height + 200);
}

-(void)keyboardDidHide:(NSNotification *)notification
{
    editScroll.contentSize = CGSizeMake(editScroll.frame.size.width, editScroll.frame.size.height);
}


-(void)allocateRequired{
    profileImageData = [[NSMutableData alloc]init];
    self.navigationItem.hidesBackButton = YES;
    delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    constant = [[Common alloc]init];
    constant.delegate = self;
    [constant addNavigationBar:self.view];
    [constant roundedImage:profile_Pic];
    [shareBtn setTitle:constant.shareIcon forState:UIControlStateNormal];
    [nmeeditBtn setTitle:constant.editIcon forState:UIControlStateNormal];
    [per_infoeditBtn setTitle:constant.editIcon forState:UIControlStateNormal];
    [col_EditBtn setTitle:constant.editIcon forState:UIControlStateNormal];
    [style_EditBtn setTitle:constant.editIcon forState:UIControlStateNormal];
    [apprel_EditBtn setTitle:constant.editIcon forState:UIControlStateNormal];
    
    getProfileData = [[NSMutableData alloc]init];
    colorArr = [[NSMutableArray alloc]init];
    style_prefArr = [[NSMutableArray alloc]init];
    apparel_Arr = [[NSMutableArray alloc]init];
    apparelSizesViews = [[NSMutableArray alloc]init];
    
    selectedColorsArr = [[NSMutableArray alloc]init];
    selectedStylesArr = [[NSMutableArray alloc]init];
    
    userapparel_Arr = [[NSMutableArray alloc]init];
    AllcolorArr = [[NSArray alloc]initWithObjects:@"RED",@"GREEN",@"BLUE",@"YELLOW",@"ORANGE",@"PURPLE",@"PINK",@"BROWN",@"BLACK",@"WHITE",nil];
    AllstylesArr = [[NSArray alloc]initWithObjects:@"INDIAN WEAR",@"WESTERN WEAR",@"SUBTLE WEAR" , @"FUNKY WEAR",@"FORMAL WEAR",@"CASUAL WEAR", nil];
    AllShirtsArr = [[NSArray alloc]initWithObjects:@"XS",@"S",@"M",@"L",@"XL",@"XXL",@"XXXL",@"XXXXL",nil];
    
    UIButton *back = (UIButton *)[self.view viewWithTag:1111];
    [back addTarget:self action:@selector(backTapped) forControlEvents:UIControlEventTouchUpInside];
    UISearchBar * search = (UISearchBar *)[self.view viewWithTag:11111];
    search.hidden = TRUE;
    
    UIButton *current_Loc = (UIButton *)[self.view viewWithTag:444];
    current_Loc.hidden = TRUE;

    UIButton *Menu = (UIButton *)[self.view viewWithTag:111];
    [Menu addTarget:self action:@selector(MenuToggle) forControlEvents:UIControlEventTouchUpInside];
    UIButton *notifications = (UIButton *)[self.view viewWithTag:222];
    [notifications addTarget:self action:@selector(notificationsTapped) forControlEvents:UIControlEventTouchUpInside];
    
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"navigatefromhelp"]==YES)
    {
        notifications.frame = CGRectMake(Menu.frame.origin.x,Menu.frame.origin.y + 5, 25, 25);
        Menu.hidden = true;
    }else{
        Menu.hidden = false;
    }
    
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
                setType = @"about-us";
                [self StaticContent];
                break;
            case 5:
                setType = @"News-Events";
                [self StaticContent];
                break;
            case 6:
                setType = @"Terms And Conditions";
                [self StaticContent];
                break;
            case 7:
                setType = @"faqs";
                [self StaticContent];
                break;
            case 8:
                setType = @"privacy";
                [self StaticContent];
                break;
            case 9:{
                [constant Redirect:self.navigationController Identifier:@"ContactViewController"];
                //                ContactViewController * contact = [self.storyboard instantiateViewControllerWithIdentifier:@"ContactViewController"];
                //                [self.navigationController pushViewController:contact animated:YES];
            }
                break;
            case 10:{
                ProfileViewController * profile = [self.storyboard instantiateViewControllerWithIdentifier:@"ProfileViewController"];
                [self.navigationController pushViewController:profile animated:YES];
                self.tabBarController.tabBar.tintColor = [UIColor lightGrayColor];
            }
                break;
            case 11:{
                HelpViewController * help = [self.storyboard instantiateViewControllerWithIdentifier:@"HelpViewController"];
                [self.navigationController pushViewController:help animated:YES];
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
                NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
                //      [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
                //  [delegate.defaults setValue:@"19.1183" forKey:@"latitude"];
                // [delegate.defaults setValue:@"73.0276" forKey:@"longitude"];
                //[delegate.defaults setValue:@"Mahape" forKey:@"loc_name"];
                [delegate.defaults setValue:@"3" forKey:@"radius"];
                ViewController * splash = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
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

-(void)GetProfile{
    requestType = @"Get_Profile";
     if([constant isActiveInternet] == YES){
    NSString *messageBody = [NSString stringWithFormat:@"log_id=%@",[delegate.defaults valueForKey:@"logid"]];
    NSLog(@"body.. %@",messageBody);
    NSLog(@"constant.getProfileURL.. %@",constant.getProfileURL);
    [constant sendRequest:self.view mutableDta:getProfileData url:constant.getProfileURL msgBody:messageBody];
     }else{
         [constant Redirect:self.navigationController Identifier:@"InternetDisconnectViewController"];
         //[self.view makeToast:@"Check your internet connection"];
     }
}

-(void)backTapped{
    
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"navigatefromhelp"]==YES)
    {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"navigatefromprofiletohelp"];
        [self dismissViewControllerAnimated:YES completion:nil];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"navigatefromhelp"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }else{
        // skipBtn.hidden = TRUE;
        [self.navigationController popViewControllerAnimated:YES];
    }

   
}

- (void)sendResponse:(Common *)response data:(NSMutableArray*)data indicator:(UIActivityIndicatorView *)indicator{
    
    dispatch_sync(dispatch_get_main_queue(), ^{
        if(data != NULL){
            if([requestType isEqualToString:@"Get_Profile"]){
                if([[data valueForKey:@"status"]intValue] == 1){
                    NSLog(@"data..%@",data);
                    [colorArr removeAllObjects];
                    [style_prefArr removeAllObjects];
                    [apparel_Arr removeAllObjects];
                    [userapparel_Arr removeAllObjects];
                    usrProfileArr = data;
                    [self setUserdata];
                    [self setPersonalPopup];
                    
                    NSArray *keys = [[data valueForKey:@"items"] allKeys];
                    NSArray *values = [[data valueForKey:@"items"] allValues];
                    NSLog(@"Keys are.. %@",keys);
                 // NSLog(@"values are.. %@",values);
                    
                    if([keys containsObject:@"COLOR"] || [keys containsObject:@"STYLE_PREF"]){
                        for(int i =0;i<keys.count;i++){
                            if([keys[i] isEqualToString:@"COLOR"]){
                                [colorArr addObject:values[i]];
                            }else if ([keys[i] isEqualToString:@"STYLE_PREF"]){
                                [style_prefArr addObject:values[i]];
                            }else if([keys[i] isEqualToString:@"userprofile"]){
                                
                            }else if ([keys[i] isEqualToString:@"APPAREL_SIZE"]) {
                                //[apparel_Arr addObject:values[i]];
                                //[userapparel_Arr addObject:keys[i]];
                            }else{
                               [apparel_Arr addObject:values[i]];
                               [userapparel_Arr addObject:keys[i]];
                            }
                        }
                        if(colorArr.count>0){
                            NSLog(@"%@",colorArr);
                            [self setMyColors:colorArr];
                        }
                        if (style_prefArr.count>0){
                            NSLog(@"%@",style_prefArr);
                            [self setMyStyleTags:style_prefArr];
                        }
                        if (apparel_Arr.count>0){
                            [self setMyApparels:apparel_Arr];
                        }
                        NSLog(@"colorArr count.. %lu",(unsigned long)colorArr.count);
                        NSLog(@"style_prefArr count.. %lu",(unsigned long)style_prefArr.count);
                    }else{
                        NSLog(@"not contains.. ");
                    }
                    
                }else if([[data valueForKey:@"status"]intValue] == -1){
                    [constant logoutFunction];
                }
            }else if([requestType isEqualToString:@"Set_Profile"]){
                 NSLog(@"data.. %@",data);
                if([[data valueForKey:@"status"]intValue] == 1){
                    
                    if([[NSUserDefaults standardUserDefaults] boolForKey:@"navigatefromhelp"]==YES)
                    {
                        ViewController *splash = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
                        UINavigationController *passcodeNavigationController = [[UINavigationController alloc] initWithRootViewController:splash];
                        [self presentViewController:passcodeNavigationController animated:YES completion:nil];
                        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"navigatefromhelp"];
                        [[NSUserDefaults standardUserDefaults] synchronize];
                    }else{
                        
                    }
                    [self GetProfile];
                }else if([[data valueForKey:@"status"]intValue] == -1){
                    [constant logoutFunction];
                }else{
                    [self.view makeToast:@"Invalid Value"];
                }
               
            }else if ([requestType isEqualToString:@"uploadImage"]){
                if ([[data valueForKey:@"status"]intValue] == 1){
                    NSLog(@"Data..%@",data);
                        [self.view makeToast:@"Image uploaded"];
                }else if([[data valueForKey:@"status"]intValue] == -1){
                    [constant logoutFunction];
                }
            }
            [indicator stopAnimating];
            [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        }else{
            [indicator stopAnimating];
            [[UIApplication sharedApplication] endIgnoringInteractionEvents];
            [self GetProfile];
        }
       
    });
}

-(void)setUserdata{
    nmeLbl.text = [[[usrProfileArr valueForKey:@"items"] valueForKey:@"userprofile"] valueForKey:@"name"];
    [[NSUserDefaults standardUserDefaults] setValue:nmeLbl.text forKey:@"usr_name"];
   // [delegate.defaults setValue:nmeLbl.text forKey:@"usr_name"];
    [delegate.defaults synchronize];
    NSURL * picurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",constant.siteURL ,[[[usrProfileArr valueForKey:@"items"] valueForKey:@"userprofile" ] valueForKey:@"profile_pic"]]];
    NSLog(@"%@",picurl);
    [profile_Pic setImageWithURL:picurl placeholderImage:[UIImage imageNamed:@"Promo3.png"] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    
    profile_Pic.userInteractionEnabled = YES;
    UITapGestureRecognizer *pgr = [[UITapGestureRecognizer alloc]
                                     initWithTarget:self action:@selector(handleTouch:)];
    pgr.delegate = self;
    [profile_Pic addGestureRecognizer:pgr];

    genderLbl.text = [[[usrProfileArr valueForKey:@"items"] valueForKey:@"userprofile"] valueForKey:@"gender"];
    NSString * birthdateStr = [[[usrProfileArr valueForKey:@"items"] valueForKey:@"userprofile"] valueForKey:@"birthdate"];
    int years = [constant calculateBirthdate:birthdateStr];
    ageLbl.text = [NSString stringWithFormat:@"%d",years];
    mobileLbl.text = [[[usrProfileArr valueForKey:@"items"] valueForKey:@"userprofile"] valueForKey:@"mobile"];
    emailLbl.text = [[[usrProfileArr valueForKey:@"items"] valueForKey:@"userprofile"] valueForKey:@"email"];
    name =  [[[usrProfileArr valueForKey:@"items"] valueForKey:@"userprofile"] valueForKey:@"name"];
    age = [[[usrProfileArr valueForKey:@"items"] valueForKey:@"userprofile"] valueForKey:@"birthdate"];
    lastname = [[[usrProfileArr valueForKey:@"items"] valueForKey:@"userprofile"] valueForKey:@"last_name"];
}

- (void)handleTouch:(UIPinchGestureRecognizer *)pinchGestureRecognizer
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Set your avatar" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Choose existing photo", @"Take new photo", nil];
    [actionSheet showInView:self.view];
    
}

// actionSheet to "change avatar button"
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        
        NSLog(@"The %@ library button was tapped.", [actionSheet buttonTitleAtIndex:buttonIndex]);
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:picker animated:YES completion:NULL];
        
    }
    
    else if (buttonIndex == 1) {
        
        NSLog(@"The %@ camera button was tapped.", [actionSheet buttonTitleAtIndex:buttonIndex]);
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:picker animated:YES completion:NULL];
        
    }
    
}

-(void)setMyColors:(NSMutableArray*)data{
    NSLog(@"%@",data);
    [selectedColorsArr removeAllObjects];
    NSArray * tempclrarr = [[NSArray alloc]init];
    //[tempclrarr removeAllObjects];
    tempclrarr = data[0];
    btnwt = 85;
    colorPrefScroll.contentSize = CGSizeMake(btnwt * tempclrarr.count, colorPrefScroll.frame.size.height);
   //  UILabel * clrnamelabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 0, 75, 15)];
     for (int j = 0; j < tempclrarr.count; j++) {
       UIView *clrView = [[UIView alloc]initWithFrame:CGRectMake(85 * j, 0, 80,colorPrefScroll.frame.size.height)];
         clrView.tag = j;
        clrView.backgroundColor = [UIColor whiteColor];
        UILabel * clrlabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 0, 75, 15)];
        clrlabel.backgroundColor = [constant getUIColorObjectFromHexString:[tempclrarr[j] valueForKey:@"code"] alpha:1];
     //   clrlabel.textColor = [UIColor darkGrayColor];
     //   clrlabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 0, 75, 15)];
        [clrlabel setFont:[UIFont fontWithName:@"Roboto-Regular" size:10]];
        clrlabel.textColor = [UIColor blackColor];
        clrlabel.text = [NSString stringWithFormat:@"%@",[tempclrarr[j] valueForKey:@"value"]];
//                  if ([clrlabel.text isEqualToString:@"RED"]) {
//                      clrlabel.textColor = [UIColor redColor];
//                  }else if([clrlabel.text isEqualToString:@"BLUE"]){
//                      clrlabel.textColor = [UIColor blueColor];
//                  }else if([clrlabel.text isEqualToString:@"GREEN"]){
//                      clrlabel.textColor = [UIColor greenColor];
//                  }else{
//                      clrlabel.textColor = [UIColor yellowColor];
//                  }
        clrlabel.textAlignment = UITextAlignmentCenter;
        [selectedColorsArr addObject:[tempclrarr[j] valueForKey:@"value"]];
       
        [clrView addSubview:clrlabel];
        [colorPrefScroll addSubview:clrView];
    }
   
    
    /*[constant resizeToFitSubviews:_colorView];
     [constant changeFrameWRT:_colorView ofview:_styleView];*/
}

-(void)setMyStyleTags:(NSMutableArray*)data{
    [selectedStylesArr removeAllObjects];
    //tempstylerarr;
     NSArray * tempstylerarr  = [[NSArray alloc]init];
     tempstylerarr = data[0];
//    for(UIView * view in stylePrefScroll.subviews){
//        if ([view isKindOfClass:[UIView class]]){
//            [view removeFromSuperview];
//        }
//    }
    btnwt = 85;
    stylePrefScroll.contentSize = CGSizeMake(btnwt * tempstylerarr.count, stylePrefScroll.frame.size.height);
    
    for (int j = 0; j < tempstylerarr.count; j++) {
        UIView *clrView = [[UIView alloc]initWithFrame:CGRectMake(85 * j, 0, 80,stylePrefScroll.frame.size.height)];
        clrView.backgroundColor = [UIColor lightGrayColor];
        clrView.tag = j;
        
        UILabel * clrnamelabel = [[UILabel alloc]initWithFrame:CGRectMake(2, 0, 80, 15)];
        [clrnamelabel setFont:[UIFont fontWithName:@"Roboto-Regular" size:9]];
        clrnamelabel.text = [NSString stringWithFormat:@"%@",tempstylerarr[j]];
        [selectedStylesArr addObject:tempstylerarr[j]];
        clrnamelabel.textColor = [UIColor darkGrayColor];
        [clrView addSubview:clrnamelabel];
        
        [stylePrefScroll addSubview:clrView];
    }
    
//    [constant resizeToFitSubviews:_styleView];
 //   [constant changeFrameWRT:_styleView ofview:_apparelView];
}

-(void)setMyApparels:(NSMutableArray*)data{
    int xpos = 10,ypos = 25,temp = 1;
//    UIView *viewToRemove = [self.view viewWithTag:221];
//    [viewToRemove removeFromSuperview];
    for(UIView * view in apparelSizesViews){
        if ([view isKindOfClass:[UIView class]]){
         [view removeFromSuperview];
        }
    }
    
    for(int i =0;i<userapparel_Arr.count;i++){
        if(![userapparel_Arr[i] isEqualToString:@"userprofile"]){
           UIView * apaarelTypeView = [[UIView alloc]initWithFrame:CGRectMake(xpos, ypos, self.view.frame.size.width/2.15, 20)];
            [apparelSizesViews addObject:apaarelTypeView];
            apaarelTypeView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
            apaarelTypeView.layer.borderWidth = 1;
            UILabel * typename = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 50, 20)];
            typename.text = [NSString stringWithFormat:@"%@",userapparel_Arr[i]];
            
            [typename setFont:[UIFont fontWithName:@"Roboto-Bold" size:12]];
            typename.textColor = [UIColor darkGrayColor];
            [apaarelTypeView addSubview:typename];

            UILabel * valname = [[UILabel alloc]initWithFrame:CGRectMake(apaarelTypeView.frame.size.width/1.5, 0, 30, 20)];
            NSArray *temparr = apparel_Arr[i];
            NSLog(@"temp arr[0]..%@",temparr[0]);
            valname.text = [NSString stringWithFormat:@"%@",temparr[0]];
            if([userapparel_Arr[i] isEqualToString:@"SHIRT"]){
                shirtTxtFld.text = temparr[0];
            }else if([userapparel_Arr[i] isEqualToString:@"T SHIRT"]){
                tShirtTxtFld.text = temparr[0];
            }else if([userapparel_Arr[i] isEqualToString:@"PANTS"]){
                pantsTxtFld.text = temparr[0];
            }else if([userapparel_Arr[i] isEqualToString:@"SHOES"]){
                shoesTxtFld.text = temparr[0];
            }
            [valname setFont:[UIFont fontWithName:@"Roboto-Regular" size:12]];
            valname.textColor = [UIColor darkGrayColor];
            [apaarelTypeView addSubview:valname];
            
            [_apparelView addSubview:apaarelTypeView];
            xpos = (apaarelTypeView.frame.origin.x + apaarelTypeView.frame.size.width) + 5;
            if(i%2 == 0){temp++;}
            if(xpos>_apparelView.frame.size.width){xpos = 10;ypos = (25*temp)+2;}
        }
        
    }
    [constant resizeToFitSubviews:_apparelView];
}

- (IBAction)changePassTapped:(id)sender {
    [delegate.defaults setValue:@"FromProfile" forKey:@"passroute"];
    [delegate.defaults synchronize];

    ChangePasswordViewController * change = [self.storyboard instantiateViewControllerWithIdentifier:@"ChangePasswordViewController"];
    [self.navigationController pushViewController:change animated:YES];
    self.tabBarController.tabBar.tintColor = [UIColor lightGrayColor];
    
}

- (IBAction)nme_infoEditTapped:(id)sender{
    per_InfoMainView.hidden = false;
}

-(void)setPersonalPopup{
    // Login feilds
    
    nametxtFld = [[RPFloatingPlaceholderTextField alloc]initWithFrame:CGRectMake(15,45, per_infoInnerView.frame.size.width - 30, 25)];
    nametxtFld.delegate=self;
    nametxtFld.placeholder = @"First Name";
    //nametxtFld.text = @"ASD";
    [constant addfeild:per_infoInnerView textfeild:nametxtFld];
    
    lastTxtField = [[RPFloatingPlaceholderTextField alloc]initWithFrame:CGRectMake(15,(nametxtFld.frame.origin.y + nametxtFld.frame.size.height) + 20, per_infoInnerView.frame.size.width - 30, 25)];
    lastTxtField.delegate=self;
    lastTxtField.placeholder = @"Last Name";
    //nametxtFld.text = @"ASD";
    [constant addfeild:per_infoInnerView textfeild:lastTxtField];
    
    mobiletxtFld = [[RPFloatingPlaceholderTextField alloc]initWithFrame:CGRectMake(15,(lastTxtField.frame.origin.y + lastTxtField.frame.size.height) + 20, per_infoInnerView.frame.size.width - 30, 25)];
    mobiletxtFld.delegate=self;
    mobiletxtFld.placeholder = @"Mobile";
    [constant addfeild:per_infoInnerView textfeild:mobiletxtFld];
    
    emailTxtFld = [[RPFloatingPlaceholderTextField alloc]initWithFrame:CGRectMake(15,(mobiletxtFld.frame.origin.y + mobiletxtFld.frame.size.height) + 20 , per_infoInnerView.frame.size.width - 30, 25)];
    emailTxtFld.delegate=self;
    emailTxtFld.placeholder = @"Email";
    [constant addfeild:per_infoInnerView textfeild:emailTxtFld];
    emailTxtFld.enabled = false;
    
    agetTxtField = [[RPFloatingPlaceholderTextField alloc]initWithFrame:CGRectMake(15,(emailTxtFld.frame.origin.y + emailTxtFld.frame.size.height) + 20 , per_infoInnerView.frame.size.width - 30, 25)];
    agetTxtField.delegate=self;
    agetTxtField.placeholder = @"Birth Date";
    [constant addfeild:per_infoInnerView textfeild:agetTxtField];
    
//    birthDateField = [[RPFloatingPlaceholderTextField alloc]initWithFrame:CGRectMake(15,(agetTxtField.frame.origin.y + agetTxtField.frame.size.height) + 20 , per_infoInnerView.frame.size.width - 30, 25)];
//    birthDateField.delegate=self;
//    birthDateField.placeholder = @"EMAIL";
//    [constant addfeild:per_infoInnerView textfeild:birthDateField];

    nametxtFld.text = [[[usrProfileArr valueForKey:@"items"] valueForKey:@"userprofile"] valueForKey:@"name"];
    mobiletxtFld.text = [[[usrProfileArr valueForKey:@"items"] valueForKey:@"userprofile"] valueForKey:@"mobile"];
    if(mobiletxtFld.text.length == 0){
        mobiletxtFld.enabled = TRUE;
    }else{
        mobiletxtFld.enabled = FALSE;
    }
    emailTxtFld.text = [[[usrProfileArr valueForKey:@"items"] valueForKey:@"userprofile"] valueForKey:@"email"];
    //end
}

-(void)setUpTextFieldDatePicker
{
    UIDatePicker *datePicker = [[UIDatePicker alloc]init];
    datePicker.datePickerMode = UIDatePickerModeTime;
    [datePicker setDate:[NSDate date]];
    [datePicker addTarget:self action:@selector(updateTextField:) forControlEvents:UIControlEventValueChanged];
    [self.agetTxtField setInputView:datePicker];
}

-(void)updateTextField:(id)sender
{
    UIDatePicker *picker = (UIDatePicker*)self.agetTxtField.inputView;
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [outputFormatter stringFromDate:picker.date];
    
    self.agetTxtField.text = [NSString stringWithFormat:@"%@",dateString];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if(textField == shirtTxtFld){
        CZPickerView *picker = [[CZPickerView alloc] initWithHeaderTitle:@"Select Shirt Size" cancelButtonTitle:@"Cancel" confirmButtonTitle:@"Done"];
        picker.delegate = self;
        picker.dataSource = self;
        picker.tag = 3;
        picker.needFooterView = YES;
        [picker show];
        
    }else if (textField == tShirtTxtFld){
        CZPickerView *picker = [[CZPickerView alloc] initWithHeaderTitle:@"Select T-Shirt Size" cancelButtonTitle:@"Cancel" confirmButtonTitle:@"Done"];
        picker.delegate = self;
        picker.dataSource = self;
        picker.tag = 4;
        picker.needFooterView = YES;
        [picker show];
        
    }else if (textField == agetTxtField){
        UIDatePicker *datePicker = [[UIDatePicker alloc] init];
        datePicker.datePickerMode = UIDatePickerModeDate;
        [datePicker addTarget:self action:@selector(updateTextField:) forControlEvents:UIControlEventValueChanged];
        datePicker.maximumDate = [NSDate date];
        self.agetTxtField.inputView = datePicker;
    }
    
}

-(void)datePickerValueChanged:(UIDatePicker *)sender{
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField == pantsTxtFld){
        
    }else if (textField == shoesTxtFld){
        
    }else if (textField == nametxtFld){
        
    }
    
}

- (IBAction)per_infoEditTapped:(id)sender {
    [self.view endEditing:YES];
    per_InfoMainView.hidden = false;
}

- (IBAction)clrSelectDone:(id)sender {
    [self.view endEditing:YES];
    clr_PopupView.hidden = true;
    per_InfoMainView.hidden = true;
    style_PopupMainview.hidden = true;
}

- (IBAction)clr_OkTapped:(id)sender {
    [self.view endEditing:YES];
    clr_PopupView.hidden = true;
    per_InfoMainView.hidden = true;
    style_PopupMainview.hidden = true;
    name =   nametxtFld.text;
    age =  agetTxtField.text;
    lastname = lastTxtField.text;
    [self.view makeToast:@"Tap on Save button to update changes"];
}

-(IBAction)col_EditTapped:(id)sender {
    [selectedColorsArr removeAllObjects];
    //clr_PopupView.hidden = false;
    CZPickerView *picker = [[CZPickerView alloc] initWithHeaderTitle:@"Select Colors" cancelButtonTitle:@"Cancel" confirmButtonTitle:@"Done"];
    picker.delegate = self;
    picker.dataSource = self;
    picker.tag = 1;
    picker.allowMultipleSelection = YES;
    picker.needFooterView = YES;
    [picker show];
}

- (IBAction)style_EditTapped:(id)sender {
    [selectedStylesArr removeAllObjects];
    
    CZPickerView *picker = [[CZPickerView alloc] initWithHeaderTitle:@"Select Styles" cancelButtonTitle:@"Cancel" confirmButtonTitle:@"Done"];
    picker.delegate = self;
    picker.dataSource = self;
    picker.tag = 2;
    picker.allowMultipleSelection = YES;
    picker.needFooterView = YES;
    [picker show];
}

- (IBAction)apprel_EditTapped:(id)sender {
    [self.view bringSubviewToFront:style_PopupMainview];
    style_PopupMainview.hidden = false;
}

- (IBAction)MyCouponsTapped:(id)sender {
//    [delegate.defaults setValue:@"mycoupons" forKey:@"BestDeals"];
//    [delegate.defaults synchronize];
//    [constant Redirect:self.navigationController Identifier:@"BestDealsViewController"];
   // MyCouponsViewController.h
    [constant Redirect:self.navigationController Identifier:@"MyCouponsViewController"];
}

- (IBAction)favouritesTapped:(id)sender {
    [delegate.defaults setValue:@"Favourites" forKey:@"route"];
    [delegate.defaults synchronize];
    ResultsViewController * result = [self.storyboard instantiateViewControllerWithIdentifier:@"ResultsViewController"];
    [self.navigationController pushViewController:result animated:YES];
}

- (IBAction)sharedTapped:(id)sender {
    [delegate.defaults setValue:@"sharedStore" forKey:@"route"];
    ResultsViewController *result = [self.storyboard instantiateViewControllerWithIdentifier:@"ResultsViewController"];
    [self.navigationController pushViewController:result animated:YES];
    self.tabBarController.tabBar.tintColor = [UIColor lightGrayColor];
}

- (IBAction)myReviewsTapped:(id)sender {
    [delegate.defaults setValue:@"2" forKey:@"Store_ID"];
    [delegate.defaults synchronize];
    [constant Redirect:self.navigationController Identifier:@"ViewReviewsViewController"];
}

- (IBAction)shareProfileTapped:(id)sender {
    NSString *textToShare = @"Street Treat";
    NSURL *myWebsite = [NSURL URLWithString:@"http://www.streettreat.in"];
    
    NSArray *objectsToShare = @[textToShare, myWebsite];
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:objectsToShare applicationActivities:nil];
    NSArray *excludeActivities = @[
                                   UIActivityTypePrint,
                                   UIActivityTypeSaveToCameraRoll,
                                   UIActivityTypeAssignToContact,
                                   UIActivityTypeAddToReadingList,
                                   UIActivityTypePostToFlickr,
                                   UIActivityTypePostToVimeo,
                                   UIActivityTypeAirDrop,
                                   UIActivityTypeCopyToPasteboard
                                   ];
    activityVC.excludedActivityTypes = excludeActivities;
    activityVC.completionWithItemsHandler = ^(NSString *activityType, BOOL completed, NSArray *returnedItems, NSError *activityError) {
    };
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [self presentViewController:activityVC animated:YES completion:^{
        }];
    }];
    
    UIPopoverPresentationController *presentationController =
    [activityVC popoverPresentationController];
    
    presentationController.sourceView = self.view;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.view endEditing:YES];
    return YES;
}

- (NSString *)czpickerView:(CZPickerView *)pickerView
               titleForRow:(NSInteger)row{
    if(pickerView.tag == 1){
        return AllcolorArr[row];
    }else if(pickerView.tag == 2){
        return AllstylesArr[row];
    }else if (pickerView.tag == 3){
        return AllShirtsArr[row];
    }else if (pickerView.tag == 4){
        return AllShirtsArr[row];
    }else{
        return @"ASD";
    }
}

- (NSInteger)numberOfRowsInPickerView:(CZPickerView *)pickerView {
    if(pickerView.tag == 1){
    return AllcolorArr.count;
    }else if(pickerView.tag == 2){
        return AllstylesArr.count;
    }else if(pickerView.tag == 3){
        return AllShirtsArr.count;
    }else if(pickerView.tag == 4){
        return AllShirtsArr.count;
    }else{
        return 1;
    }
}

- (void)czpickerView:(CZPickerView *)pickerView didConfirmWithItemsAtRows:(NSArray *)rows {
    if(pickerView.tag == 1){
        for (NSNumber *n in rows) {
            NSInteger row = [n integerValue];
            NSLog(@"%@ is chosen!", AllcolorArr[row]);
             [selectedColorsArr addObject:AllcolorArr[row]];
           NSLog(@"%@",selectedColorsArr);
            [self.view makeToast:@"Click on Save button to make changes"];
        }
    }else if(pickerView.tag == 2){
        for (NSNumber *n in rows) {
            NSInteger row = [n integerValue];
            NSLog(@"%@ is chosen!", AllstylesArr[row]);
            [selectedStylesArr addObject:AllstylesArr[row]];
           NSLog(@"%@",selectedStylesArr);
            [self.view makeToast:@"Click on Save button to make changes"];
        }
    }
    
   // [self sendprofileParameters];
}

-(void)czpickerView:(CZPickerView *)pickerView didConfirmWithItemAtRow:(NSInteger)row{
    if(pickerView.tag == 3){
        shirtTxtFld.text = AllShirtsArr[row];
    }else if(pickerView.tag == 4){
        tShirtTxtFld.text = AllShirtsArr[row];
    }else{
        NSLog(@"size..");
    }
}

-(void)sendprofileParameters{
    NSString * tempbody;
    NSMutableArray * selTempClrsArr = [[NSMutableArray alloc]init];
    NSLog(@"%lu",(unsigned long)selectedColorsArr.count);
    for(int i=0;i<selectedColorsArr.count;i++){
        tempbody = [NSString stringWithFormat:@"COLOR[%d]=%@",i,selectedColorsArr[i]];
        [selTempClrsArr addObject:tempbody];
    }
    tempclrs = [selTempClrsArr componentsJoinedByString:@"&"];
    NSLog(@"selTempClrsArr.. %@",tempclrs);
    
    NSString * tempbodystyles;
    NSMutableArray *selTempstyArr = [[NSMutableArray alloc]init];
    for(int i=0;i<selectedStylesArr.count;i++){
        tempbodystyles = [NSString stringWithFormat:@"STYLE_PREF[%d]=%@",i,selectedStylesArr[i]];
        [selTempstyArr addObject:tempbodystyles];
    }
    tempStyles = [selTempstyArr componentsJoinedByString:@"&"];
    NSLog(@"selTempStylesArr.. %@",tempStyles);
    
    if(shirtTxtFld.text.length>0){
        apparelstr =[NSString stringWithFormat:@"SHIRT=%@",shirtTxtFld.text];
    }
    
    if (tShirtTxtFld.text.length>0){
        apparelstr =[NSString stringWithFormat:@"SHIRT=%@&T_SHIRT=%@",shirtTxtFld.text,tShirtTxtFld.text];
    }
    
    if (pantsTxtFld.text.length>0){
        apparelstr =[NSString stringWithFormat:@"SHIRT=%@&T_SHIRT=%@&PANTS=%@",shirtTxtFld.text,tShirtTxtFld.text,pantsTxtFld.text];
    }
    
    if (shoesTxtFld.text.length>0){
        apparelstr =[NSString stringWithFormat:@"SHIRT=%@&T_SHIRT=%@&PANTS=%@&SHOES=%@",shirtTxtFld.text,tShirtTxtFld.text,pantsTxtFld.text,shoesTxtFld.text];
    }
    
    NSLog(@"apparelstr %@",apparelstr);
}

- (void)czpickerViewDidClickCancelButton:(CZPickerView *)pickerView {
    [self.navigationController setNavigationBarHidden:YES];
    NSLog(@"Canceled.");
}

- (void)czpickerViewWillDisplay:(CZPickerView *)pickerView {
    NSLog(@"Picker will display.");
    [self.view endEditing:YES];
}

- (void)czpickerViewDidDisplay:(CZPickerView *)pickerView {
    NSLog(@"Picker did display.");
}

- (void)czpickerViewWillDismiss:(CZPickerView *)pickerView {
    NSLog(@"Picker will dismiss.");
}

- (void)czpickerViewDidDismiss:(CZPickerView *)pickerView {
    NSLog(@"Picker did dismiss.");
}

- (IBAction)saveProfileTapped:(id)sender {
    [self sendprofileParameters];
    requestType = @"Set_Profile";
    NSLog(@"%@",tempclrs);
    NSLog(@"%@",tempStyles);
    NSLog(@"%@",selectedColorsArr);
    NSLog(@"%@",selectedStylesArr);
    if([constant isActiveInternet] == YES){
    NSLog(@"aplrelstr %@",apparelstr);
    NSString *messageBody = [NSString stringWithFormat:@"log_id=%@&name=%@&birthdate=%@&last_name=%@&%@&%@&%@",[delegate.defaults valueForKey:@"logid"],name,age,lastname,tempclrs,tempStyles,apparelstr];
    NSLog(@"body.. %@",messageBody);
    NSLog(@"constant.setProfileURL.. %@",constant.setProfileURL);
    [constant sendRequest:self.view mutableDta:getProfileData url:constant.setProfileURL msgBody:messageBody];
    
 }else{
     [constant Redirect:self.navigationController Identifier:@"InternetDisconnectViewController"];
     //[self.view makeToast:@"Check your internet connection"];
 }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Not used
-(void)setDefaultPopupColors{
    //Set Colours in Popup
    NSString * clrvalstring = [NSString stringWithFormat:@"%@",[colorArr valueForKey:@"ref1"]];
    NSArray *tempclrvalarr = [clrvalstring componentsSeparatedByString:@","];
    for(int i =0;i<tempclrvalarr.count;i++){
        [clrBtnsCollection[i] setHidden:NO];
        [clrBtnsCollection[i] setBackgroundColor:[constant getUIColorObjectFromHexString:[NSString stringWithFormat:@"%@",tempclrvalarr[i]] alpha:1]];
    }
    //end
}

-(void)setDeafaultPopupTags:(NSMutableArray*)data{
    //Set style Preference default tags
    NSString * styleprefstring = [NSString stringWithFormat:@"%@",[style_prefArr valueForKey:@"values"]];
    NSArray *tempstyleprefarr = [styleprefstring componentsSeparatedByString:@","];
    for(int i =0;i<tempstyleprefarr.count;i++){
        [tagListView addTag:[NSString stringWithFormat:@"%@",tempstyleprefarr[i]]];
    }
    //end
    
    //Set style Preference my selected tags
    for(int i =0;i<[[[[data valueForKey:@"items"] valueForKey:@"user_data"] valueForKey:@"STYLE_PREF"] count];i++){
        NSString * tempStyle = [[[data valueForKey:@"items"] valueForKey:@"user_data"] valueForKey:@"STYLE_PREF"][i];
        // NSLog(@"style.. %@",tempStyle);
        if([[tagListView.tags objectAtIndex:i].tagText isEqualToString:tempStyle]){
            [[tagListView.tags objectAtIndex:i] setTagColor:[UIColor yellowColor]];
        }else{
            
        }
    }
    //end
    
}

# pragma mark - Image picker controller delegate methods

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.profile_Pic.image = chosenImage;
    UIImage *image = [self resizeImage:self.profile_Pic.image];
    NSData *compressedData = UIImageJPEGRepresentation(image, 0.5);
    //UIImageJPEGRepresentation(self.profile_Pic.image, 0.5);
        // Set image to avatar
    requestType = @"uploadImage";
    
    NSString *str = [compressedData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
   // NSString *str = [self encodeToBase64String:str];
    NSLog(@"%@",str);
     if([constant isActiveInternet] == YES){
    NSString *messageBody = [NSString stringWithFormat:@"log_id=%@&image=%@&image_type=%@",[delegate.defaults valueForKey:@"logid"],str,@"profile_pic"];
    NSLog(@"messageBody.. %@",messageBody);
    [constant sendRequest:self.view mutableDta:profileImageData url:constant.userProfImageURL msgBody:messageBody];
    [picker dismissViewControllerAnimated:YES completion:NULL];
     }else{
         [constant Redirect:self.navigationController Identifier:@"InternetDisconnectViewController"];
         //[self.view makeToast:@"Check your internet connection"];
     }
}


-(UIImage *)resizeImage:(UIImage *)image
{
    float actualHeight = image.size.height;
    float actualWidth = image.size.width;
    float maxHeight = 300.0;
    float maxWidth = 400.0;
    float imgRatio = actualWidth/actualHeight;
    float maxRatio = maxWidth/maxHeight;
    float compressionQuality = 0.5;//50 percent compression
    
    if (actualHeight > maxHeight || actualWidth > maxWidth)
    {
        if(imgRatio < maxRatio)
        {
            //adjust width according to maxHeight
            imgRatio = maxHeight / actualHeight;
            actualWidth = imgRatio * actualWidth;
            actualHeight = maxHeight;
        }
        else if(imgRatio > maxRatio)
        {
            //adjust height according to maxWidth
            imgRatio = maxWidth / actualWidth;
            actualHeight = imgRatio * actualHeight;
            actualWidth = maxWidth;
        }
        else
        {
            actualHeight = maxHeight;
            actualWidth = maxWidth;
        }
    }
    
    CGRect rect = CGRectMake(0.0, 0.0, actualWidth, actualHeight);
    UIGraphicsBeginImageContext(rect.size);
    [image drawInRect:rect];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    NSData *imageData = UIImageJPEGRepresentation(img, compressionQuality);
    UIGraphicsEndImageContext();
    
    return [UIImage imageWithData:imageData];
    
}

- (NSString *)encodeToBase64String:(UIImage *)image {
    return [UIImagePNGRepresentation(image) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}

- (UIImage *)decodeBase64ToImage:(NSString *)strEncodeData {
    NSData *data = [[NSData alloc]initWithBase64EncodedString:strEncodeData options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return [UIImage imageWithData:data];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
}
                  
- (IBAction)sizesOKTapped:(id)sender {
    NSInteger c = [pantsTxtFld.text integerValue];
    NSInteger d = [shoesTxtFld.text integerValue];
    if (c < 24 || c > 60) {
        [self.view makeToast:@"Pants size is invalid"];
        pantsTxtFld.text = @"";
    }else if(d < 5 || d > 14){
        [self.view makeToast:@"Shoes size is invalid"];
        shoesTxtFld.text = @"";
    }else{
     //  style_PopupMainview.hidden = true;
     // [self sendprofileParameters];
     // [self GetProfile];
        
    }
    [self.view makeToast:@"Click on Save button to make changes"];
}

@end
