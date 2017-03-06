//
//  ResultsViewController.m
//  Street_Treat
//
//  Created by Kamlesh Dubey on 6/10/16.
//  Copyright (c) 2016 Digillence Rolson. All rights reserved.

#import "ResultsViewController.h"

@interface ResultsViewController (){
    UIView *contentView;
    UPStackMenu *stack;
    int premCount;
}

@end

@implementation ResultsViewController
@synthesize resultView,resultTable,storeCountLbl,locationBtn,filterBtn,highstreetBtn,brandsBtn,designersBtn,exhibitionsBtn,indicatorLine,VerticalsHdrLbl;
@synthesize couponDetMainView,rootNav,setType;

@synthesize RatingsSlider,ratingsMaxLbl,DistanceSlider,distanceMaxLbl,DiscountSlider,discountMaxLbl,CategoriesSelectLbl,SelectedCategoriesLbl;

-(void)getParentCategories{
    seg_string = @"GetParents";
    if([commonclass isActiveInternet] == YES){
    [commonclass sendRequest:self.view mutableDta:extraData url:commonclass.getParentCategoriesURL msgBody:nil];
    }else{
        [commonclass Redirect:self.navigationController Identifier:@"InternetDisconnectViewController"];
        //[self.view makeToast:@"Check your internet connection"];
    }
}

-(void)updateMobile{
    seg_string = @"UpdateMobile";
    if([commonclass isActiveInternet] == YES){
    NSString *messageBody = [NSString stringWithFormat:@"log_id=%@&mobile=%@",[delegate.defaults valueForKey:@"logid"],mobileFld.text];
    NSLog(@"body.. %@",messageBody);
    NSLog(@"commonclass.searchListURL.. %@",commonclass.updateMobileURL);
    [commonclass sendRequest:self.view mutableDta:extraData url:commonclass.updateMobileURL msgBody:messageBody];
    }else{
        [commonclass Redirect:self.navigationController Identifier:@"InternetDisconnectViewController"];
        //[self.view makeToast:@"Check your internet connection"];
    }
}

-(void)viewWillAppear:(BOOL)animated{
   // j = 0;
     [delegate.defaults setValue:@"" forKey:@"navigateFromReport"];
    [delegate.defaults setObject:@"ResultsViewController" forKey:@"internetdisconnect"];
    //[self allocateRequired];
    [self setupMobileVerificationPopup];
    Popupmainview.hidden = true;
//  [resultTable setContentOffset:CGPointZero animated:YES];
//  promoArr = [[NSMutableArray alloc]initWithObjects:[UIImage imageNamed:@"Promo1.png"],[UIImage imageNamed:@"Promo2.png"],[UIImage imageNamed:@"Promo3.png"],[UIImage imageNamed:@"Promo4.png"],nil];
    self.rootNav = (CCKFNavDrawer *)self.navigationController;
    [self.rootNav setCCKFNavDrawerDelegate:self];
    self.tabBarController.tabBar.tintColor = [UIColor lightGrayColor];
//    [distAwayArr removeAllObjects];
//    [phonenoArr removeAllObjects];
//    [phoneno_StoreIDArr removeAllObjects];
    searchField = [search valueForKey:@"_searchField"];
    /* //working
    userLatitude = [[delegate.defaults valueForKey:@"latitude"] floatValue];
    userLongitude = [[delegate.defaults valueForKey:@"longitude"] floatValue];
    //end   */
    
    //changed
    
    userLatitude = [[delegate.defaults valueForKey:@"latitude"] floatValue];
    userLongitude = [[delegate.defaults valueForKey:@"longitude"] floatValue];
    //end
    
    
    //Abhijit to change this comment while checking on the device this one is for simulator
//    currentLatitude = [[delegate.defaults valueForKey:@"latitude"] floatValue];
//    currentLongitude = [[delegate.defaults valueForKey:@"longitude"] floatValue];
    //end
    
//    NSLog(@"%@",[delegate.defaults valueForKey:@"myloc"]);
//    if ([[delegate.defaults valueForKey:@"myloc"] isEqualToString:@"locupdatefrom"]){
//        searchField.text = [delegate.defaults valueForKey:@"myloc_name"];
//    }else{
//       searchField.text = [delegate.defaults valueForKey:@"loc_name"];
//    }
    
    NSLog(@"%@",[delegate.defaults valueForKey:@"loc_name"]);
//    float duration = 0.5;
//    timer = [NSTimer scheduledTimerWithTimeInterval:duration target:self selector:@selector(showLocName) userInfo:nil repeats: YES];
//    searchField.textColor = [UIColor whiteColor];

    [self showLocName];
    
    ratingsMaxLbl.text = [NSString stringWithFormat:@"0/5"];
    distanceMaxLbl.text = [NSString stringWithFormat:@"0.0/5.0 Km"];
    discountMaxLbl.text = [NSString stringWithFormat:@"1/100 %%"];
    counter = 0;
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
    [self setUpstackMenu];
    temppremiumCnt = 0;
        if([[delegate.defaults valueForKey:@"verticalsCategory"] isEqualToString:@"High Street"]){
            [commonclass addlistingSlideAnimation:indicatorLine button1:highstreetBtn];
        }else if([[delegate.defaults valueForKey:@"verticalsCategory"] isEqualToString:@"Brands"]){
             [commonclass addlistingSlideAnimation:indicatorLine button1:brandsBtn];
        }else if([[delegate.defaults valueForKey:@"verticalsCategory"] isEqualToString:@"Designers"]){
             [commonclass addlistingSlideAnimation:indicatorLine button1:designersBtn];
        }
}

-(void)setUpstackMenu{
   contentView = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 60, self.view.frame.size.height+5, 35, 35)];
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
   // stack.backgroundColor = [UIColor yellowColor];
    [stack setDelegate:self];
    
    UPStackMenuItem *squareItem = [[UPStackMenuItem alloc] initWithImage:[UIImage imageNamed:@"Download_Excel"] highlightedImage:[UIImage imageNamed:@"Download_Excel"] title:@"View Favourites"];
    UPStackMenuItem *circleItem = [[UPStackMenuItem alloc] initWithImage:[UIImage imageNamed:@"Email_Excel"] highlightedImage:[UIImage imageNamed:@"Download_Excel"] title:@"Update Profile"];
    UPStackMenuItem *viewItem = [[UPStackMenuItem alloc] initWithImage:[UIImage imageNamed:@"Email_Excel"] highlightedImage:[UIImage imageNamed:@"Download_Excel"] title:@"Add Reviews"];
    
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
    flyoutView = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height/1.2, self.view.frame.size.width, self.view.frame.size.height/4)];
    flyoutView.backgroundColor = [UIColor lightTextColor];
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
    if(index == 0){
        [delegate.defaults setValue:@"Favourites" forKey:@"route"];
        [commonclass Redirect:self.navigationController Identifier:@"ResultsViewController"];
    }else if(index == 1){
        [commonclass Redirect:self.navigationController Identifier:@"ProfileViewController"];
    }else if (index == 2){
        
    }
    [stack closeStack];
}

-(void)getDatawithStoreCategory:(NSString *)storetype latitude:(float)storelatitude longitude:(float)storeLongitude radius:(float)storeRadius{
    if([[delegate.defaults valueForKey:@"route"] isEqualToString:@"Store"]){
        if([[delegate.defaults valueForKey:@"resultType"] isEqualToString:@"Category"]){
            [self PagerBtns:FALSE];
            VerticalsHdrLbl.hidden = TRUE;
            exhibitionsBtn.hidden = TRUE;
            [self getStoresResponseByCategories:seg_string latitude:storelatitude longitude:storeLongitude radius:storeRadius];
        }else if ([[delegate.defaults valueForKey:@"resultType"] isEqualToString:@"Keyword"]){
             VerticalsHdrLbl.hidden = FALSE;
             VerticalsHdrLbl.text = @"Store Search";
            [self getStoresResponseBySearchKeyword:storelatitude longitude:storeLongitude radius:userRadius];
        }else if ([[delegate.defaults valueForKey:@"resultType"] isEqualToString:@"CheckIn"]){
            NSString * radius = @"0.25";
           // [self getst];
             VerticalsHdrLbl.hidden = TRUE;
            [self getStoresResponseByNearBy:storelatitude longitude:storeLongitude radius:[radius floatValue]];
        }else{
            [self PagerBtns:FALSE];
            VerticalsHdrLbl.hidden = TRUE;
            exhibitionsBtn.hidden = TRUE;
            [self getStoresResponseByTypes:[delegate.defaults valueForKey:@"verticalsCategory"] latitude:storelatitude longitude:storeLongitude radius:storeRadius];
            if([[delegate.defaults valueForKey:@"verticalsCategory"] isEqualToString:@"High Street"]){
               // [commonclass addlistingSlideAnimation:indicatorLine button1:highstreetBtn];
                VerticalsHdrLbl.text = @"High Street";
            }else if([[delegate.defaults valueForKey:@"verticalsCategory"] isEqualToString:@"Brands"]){
               // [commonclass addlistingSlideAnimation:indicatorLine button1:brandsBtn];
                VerticalsHdrLbl.text = @"Branded";
            }else{
               // [commonclass addlistingSlideAnimation:indicatorLine button1:designersBtn];
                VerticalsHdrLbl.text = @"Designers";
            }
        }
    }
    else if([[delegate.defaults valueForKey:@"route"] isEqualToString:@"Favourites"]){
        NSLog(@"favourites route... ");
        exhibitionsBtn.hidden = TRUE;
        UILabel * BucketNameLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 54, self.view.frame.size.width, 25)];
        BucketNameLbl.text = @" MY FAVOURITES";
        BucketNameLbl.backgroundColor = [UIColor Hdr_Color];
        BucketNameLbl.font = [UIFont fontWithName:@"Raleway-SemiBold" size:14];
        BucketNameLbl.textColor = [UIColor darkGrayColor];
        [self.view addSubview:BucketNameLbl];
        resultView.frame = CGRectOffset(resultView.frame, 0, 30);
        [self getFavourites:seg_string latitude:storelatitude longitude:storeLongitude radius:storeRadius];
    }else if([[delegate.defaults valueForKey:@"route"] isEqualToString:@"sharedStore"]){
        [self getSharedStore:seg_string latitude:userLatitude longitude:userLongitude radius:userRadius];
        // [self getFavourites:seg_string latitude:userLatitude longitude:userLongitude radius:userRadius];
    }
    else{
        //[self getResponseBuckets:@"High Street"];
        [self getResponseBuckets:seg_string latitude:storelatitude longitude:storeLongitude radius:storeRadius];
        exhibitionsBtn.hidden = TRUE;
        //resultView.backgroundColor = [UIColor orangeColor];
        UILabel * BucketNameLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 54, self.view.frame.size.width, 25)];
        BucketNameLbl.text = [NSString stringWithFormat:@" %@",[delegate.defaults valueForKey:@"bucketName"]];
        BucketNameLbl.backgroundColor = [UIColor Hdr_Color];
        BucketNameLbl.font = [UIFont fontWithName:@"Raleway-SemiBold" size:14];
        BucketNameLbl.textColor = [UIColor darkGrayColor];
        [self.view addSubview:BucketNameLbl];
        resultView.frame = CGRectOffset(resultView.frame, 0, 30);
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
  //  j = 0;
    [delegate.defaults setValue:@"" forKey:@"navigateFromReport"];
    
//    refreshControl = [[UIRefreshControl alloc] init];
//    refreshControl.backgroundColor = [UIColor purpleColor];
//    refreshControl.tintColor = [UIColor whiteColor];
//    [refreshControl addTarget:self
//                            action:@selector(getLatestLoans)
//                  forControlEvents:UIControlEventValueChanged];
    
    [self allocateRequired];
    [self CurrentLocationIdentifier];
    exhibitionsBtn.hidden = TRUE;
    distanceval = 3.0;
    segTapString = @"High Street";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
//  promoArr = [[NSMutableArray alloc]initWithObjects:[UIImage imageNamed:@"Promo1.png"],[UIImage imageNamed:@"Promo2.png"],[UIImage imageNamed:@"Promo3.png"],[UIImage imageNamed:@"Promo4.png"],nil];
    currentLatitude = [[delegate.defaults valueForKey:@"user_latitude"] floatValue];
    currentLongitude = [[delegate.defaults valueForKey:@"user_longitude"] floatValue];
    userLatitude = [[delegate.defaults valueForKey:@"user_latitude"] floatValue];
    userLongitude = [[delegate.defaults valueForKey:@"user_longitude"] floatValue];
    userRadius = [[delegate.defaults valueForKey:@"radius"] floatValue];
//    searchField = [search valueForKey:@"_searchField"];
    
   // searchField.text = [delegate.defaults valueForKey:@"loc_name"];
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(categoriesFilterTapped:)];
    CategoriesSelectLbl.userInteractionEnabled = YES;
    [CategoriesSelectLbl addGestureRecognizer:gestureRecognizer];
    
    CategoriesSelectLbl.layer.masksToBounds = true;
    CategoriesSelectLbl.layer.cornerRadius = 12;
    
    seg_string = @"High Street";
    [self getDatawithStoreCategory:@"High Street" latitude:currentLatitude longitude:currentLongitude radius:userRadius];
}

-(void)categoriesFilterTapped:(UITapGestureRecognizer *)recogniser{
    CZPickerView *picker = [[CZPickerView alloc] initWithHeaderTitle:@"Select Categories" cancelButtonTitle:@"Cancel" confirmButtonTitle:@"Done"];
    picker.delegate = self;
    picker.dataSource = self;
    picker.tag = 1;
    picker.allowMultipleSelection = YES;
    picker.needFooterView = YES;
    [picker show];
}

- (NSString *)czpickerView:(CZPickerView *)pickerView
               titleForRow:(NSInteger)row{
    return [categoriesArr[row] valueForKey:@"title"];
}

- (NSInteger)numberOfRowsInPickerView:(CZPickerView *)pickerView {
    return categoriesArr.count;
}

- (void)czpickerView:(CZPickerView *)pickerView didConfirmWithItemsAtRows:(NSArray *)rows {
        for (NSNumber *n in rows) {
            NSInteger row = [n integerValue];
            NSLog(@"%@ is chosen!", categoriesArr[row]);
            [selectedcategoriesIDArr addObject:[categoriesArr[row] valueForKey:@"id"]];
            [selectedcategoriesArr addObject:[categoriesArr[row] valueForKey:@"title"]];
        }
    NSString * filterSCategories = [selectedcategoriesArr componentsJoinedByString:@","];
    NSLog(@"filterCategoriesIDs %@",filterSCategories);
    SelectedCategoriesLbl.text = filterSCategories;
    NSLog(@"selected categories.. %@",selectedcategoriesIDArr);
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

-(void)PagerBtns:(BOOL)val{
    highstreetBtn.hidden = val;
    brandsBtn.hidden = val;
    designersBtn.hidden = val;
    exhibitionsBtn.hidden = val;
    indicatorLine.hidden = val;
}

-(void)allocateRequired{
    self.navigationController.navigationBarHidden =true;
    commonclass = [[Common alloc]init];
    commonclass.delegate = self;
    delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [commonclass addNavigationBar:self.view];
    searchData = [[NSMutableData alloc]init];
    extraData = [[NSMutableData alloc]init];
    phonenoArr = [[NSMutableArray alloc]init];
    verticalsArr = [[NSMutableArray alloc]init];
    searchResponseArr = [[NSMutableArray alloc]init];
    premiumphonenoArr = [[NSMutableArray alloc]init];
    self.navigationItem.hidesBackButton = YES;
    highstreetArr = [[NSMutableArray alloc]init];
    brandedArr = [[NSMutableArray alloc]init];
    designerArr = [[NSMutableArray alloc]init];
    exhibitionArr = [[NSMutableArray alloc]init];
    favouritesArr = [[NSMutableArray alloc]init];
    distAwayArr = [[NSMutableArray alloc]init];
    phoneno_StoreIDArr = [[NSMutableArray alloc]init];
    categoriesArr = [[NSMutableArray alloc]init];
    premiumphoneno_StoreIDArr = [[NSMutableArray alloc]init];
    categoriesData = [[NSMutableData alloc]init];
    selectedcategoriesIDArr = [[NSMutableArray alloc]init];
    selectedcategoriesArr = [[NSMutableArray alloc]init];
    premiumListArr = [[NSMutableArray alloc]init];
    premiumdistAwayArr = [[NSMutableArray alloc]init];
    
    PrevX = indicatorLine.frame.origin.x;
    PrevY = indicatorLine.frame.origin.y;
    [resultTable setSeparatorColor:[UIColor clearColor]];
    UIButton *back = (UIButton *)[self.view viewWithTag:1111];
    [back addTarget:self action:@selector(backTapped) forControlEvents:UIControlEventTouchUpInside];
    UIButton *notifications = (UIButton *)[self.view viewWithTag:222];
    [notifications addTarget:self action:@selector(notificationsTapped) forControlEvents:UIControlEventTouchUpInside];
    UIButton *Menu = (UIButton *)[self.view viewWithTag:111];
    [Menu addTarget:self action:@selector(MenuToggle) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *current_Loc = (UIButton *)[self.view viewWithTag:444];
    [current_Loc addTarget:self action:@selector(FindCurrentTapped) forControlEvents:UIControlEventTouchUpInside];
    
    search = (UISearchBar *)[self.view viewWithTag:11111];

    [locationBtn setTitle:commonclass.locationbaloonIcon forState:UIControlStateNormal];
    [filterBtn setTitle:commonclass.filtersIcon forState:UIControlStateNormal];
}

-(void)FindCurrentTapped{
    [distAwayArr removeAllObjects];
    [premiumdistAwayArr removeAllObjects];
    [delegate.defaults setValue:@"myloc" forKey:@"locupdatefrom"];
    searchField.text = [delegate.defaults valueForKey:@"myloc_name"];
    [delegate.defaults setValue:searchField.text forKey:@"loc_name"];
    searchField.textColor = [UIColor whiteColor];
    
    currentLatitude = [[delegate.defaults valueForKey:@"latitude"]floatValue];
    currentLongitude = [[delegate.defaults valueForKey:@"longitude"]floatValue];
    
    [delegate.defaults setValue:[delegate.defaults valueForKey:@"latitude"] forKey:@"user_latitude"];
    [delegate.defaults setValue:[delegate.defaults valueForKey:@"longitude"] forKey:@"user_longitude"];
    
    [self getDatawithStoreCategory:segTapString latitude:currentLatitude longitude:currentLongitude radius:userRadius];
    
    [delegate.defaults setValue:@"myloc" forKey:@"locupdatefrom"];
    
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

-(void)showResults{
    [delegate.defaults setObject:@"Category" forKey:@"resultType"];
    [delegate.defaults synchronize];
    ResultsViewController * result = [self.storyboard instantiateViewControllerWithIdentifier:@"ResultsViewController"];
    [self.navigationController pushViewController:result animated:YES];
    self.tabBarController.tabBar.tintColor = [UIColor lightGrayColor];
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
//                [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
                [delegate.defaults setValue:@"19.1183" forKey:@"latitude"];
                [delegate.defaults setValue:@"73.0276" forKey:@"longitude"];
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


-(void)StaticContent{
    //NSLog(@"type StaticContent .. %@",setType);
    [delegate.defaults setObject:setType forKey:@"staticType"];
    [delegate.defaults synchronize];
    StaticDataViewController * info = [self.storyboard instantiateViewControllerWithIdentifier:@"StaticDataViewController"];
    [self.navigationController pushViewController:info animated:YES];
    self.tabBarController.tabBar.tintColor = [UIColor lightGrayColor];
}

#pragma mark - getting response from server methods
- (void)sendResponse:(Common *)response data:(NSMutableArray*)data indicator:(UIActivityIndicatorView *)indicator{
    NSLog(@"data..%@",data);
    dispatch_sync(dispatch_get_main_queue(), ^{
        if(data != NULL){
           /* //Favourites
            if([seg_string isEqualToString:@"Favourites"]){
                if([[data valueForKey:@"status"]intValue] == 1){
                    [favouritesArr removeAllObjects];
                    favouritesArr = [data valueForKey:@"items"];
                   // NSLog(@"highstreetArr..%lu",(unsigned long)[highstreetArr count]);
                    storeCountLbl.text = [NSString stringWithFormat:@"%lu Stores",(unsigned long)[[favouritesArr valueForKey:@"items"] count]];
                }else{
                    storeCountLbl.text = [NSString stringWithFormat:@"0 Stores"];
                    [self.view makeToast:@"No Stores added yet"];
                }
                [resultTable reloadData];
            }
           else*/
            if([seg_string isEqualToString:@"GetParents"]){
                [categoriesArr removeAllObjects];
                if([[data valueForKey:@"status"]intValue] == 1){
                    categoriesArr = [data valueForKey:@"items"];
                    NSLog(@"categoriesArr..%@",categoriesArr);
//                    storeCountLbl.text = [NSString stringWithFormat:@"%lu Stores",(unsigned long)[[highstreetArr valueForKey:@"items"] count]];
                }else if([[data valueForKey:@"status"]intValue] == -1){
                    [commonclass logoutFunction];
                }else{
//                    storeCountLbl.text = [NSString stringWithFormat:@"0 Stores"];
//                    [self.view makeToast:@"No Stores added yet"];
                }
            }
              else if([seg_string isEqualToString:@"High Street"]){
                   NSLog(@"%@",data);
                   [highstreetArr removeAllObjects];
                   [premiumListArr removeAllObjects];
                if([[data valueForKey:@"status"]intValue] == 1){
                    highstreetArr = [data valueForKey:@"items"];
                    premiumListArr = [data valueForKey:@"premium_listing"];
                    premiumCnt = premiumListArr.count;
                     NSLog(@"highstreetArr..%lu",(unsigned long)[highstreetArr count]);
                    storeCountLbl.text = [NSString stringWithFormat:@"%lu Stores",(unsigned long)[[highstreetArr valueForKey:@"items"] count]];
                }else if([[data valueForKey:@"status"]intValue] == -1){
                    [commonclass logoutFunction];
                }else{
                    storeCountLbl.text = [NSString stringWithFormat:@"0 Stores"];
                    [self.view makeToast:@"No Stores added yet"];
                }
                [resultTable reloadData];
            }else if([seg_string isEqualToString:@"Brands"]){
                NSLog(@"%@",data);
                [brandedArr removeAllObjects];
                [premiumListArr removeAllObjects];
                if([[data valueForKey:@"status"]intValue] == 1){
                    brandedArr = [data valueForKey:@"items"];
                    premiumListArr = [data valueForKey:@"premium_listing"];
                    premiumCnt = premiumListArr.count;
                    //NSLog(@"brandedArr..%lu",(unsigned long)[brandedArr count]);
                    storeCountLbl.text = [NSString stringWithFormat:@"%lu Stores",(unsigned long)[[brandedArr valueForKey:@"items"] count]];
                }else if([[data valueForKey:@"status"]intValue] == -1){
                    [commonclass logoutFunction];
                }else{
                    storeCountLbl.text = [NSString stringWithFormat:@"0 Stores"];
                    [self.view makeToast:@"No Stores added yet"];
                }
                [resultTable reloadData];
            }else if([seg_string isEqualToString:@"Designers"]){
                [designerArr removeAllObjects];
                [premiumListArr removeAllObjects];
                if([[data valueForKey:@"status"]intValue] == 1){
                    designerArr = [data valueForKey:@"items"];
                    premiumListArr = [data valueForKey:@"premium_listing"];
                    premiumCnt = premiumListArr.count;
                    NSLog(@"designerArr..%lu",(unsigned long)[designerArr count]);
                    storeCountLbl.text = [NSString stringWithFormat:@"%lu Stores",(unsigned long)[[designerArr valueForKey:@"items"] count]];
                }else if([[data valueForKey:@"status"]intValue] == -1){
                    [commonclass logoutFunction];
                }else{
                    storeCountLbl.text = [NSString stringWithFormat:@"0 Stores"];
                    [self.view makeToast:@"No Stores added yet"];
                }
                [resultTable reloadData];
            }else if([seg_string isEqualToString:@"Verticals"]){
                [verticalsArr removeAllObjects];
                [premiumListArr removeAllObjects];
                if([[data valueForKey:@"status"]intValue] == 1){
                    [verticalsArr removeAllObjects];
                    verticalsArr = [data valueForKey:@"items"];
                    premiumListArr = [data valueForKey:@"premium_listing"];
                    premiumCnt = premiumListArr.count;
                    self.storeCountLbl.text = [NSString stringWithFormat:@"%lu Stores",(unsigned long)[[verticalsArr valueForKey:@"items"] count]];
                }else if([[data valueForKey:@"status"]intValue] == -1){
                    [commonclass logoutFunction];
                }else{
                    self.storeCountLbl.text = [NSString stringWithFormat:@"0 Stores"];
                    [self.view makeToast:@"No Stores added yet"];
                }
                [resultTable reloadData];
            }else if([seg_string isEqualToString:@"phone"]){
                if([[data valueForKey:@"status"]intValue] == 1){}else if([[data valueForKey:@"status"]intValue] == -1){
                    [commonclass logoutFunction];
                }else{}
              }
            else if([seg_string isEqualToString:@"UpdateMobile"]){
                if([[data valueForKey:@"status"]intValue] == 1){
                    NSString * mobile = mobileFld.text;
                    [delegate.defaults setBool:true forKey:@"updateMobile"];
                    [delegate.defaults setValue:mobile forKey:@"mobile"];
                    [delegate.defaults synchronize];
                    [self ValidateOTP];
                }else if([[data valueForKey:@"status"]intValue] == -1){
                    [commonclass logoutFunction];
                }else{
                    
                    [self.view makeToast:[data valueForKey:@"message"]];
                }
            }
            else if([seg_string isEqualToString:@"UpdateOTP"]){
                if([[data valueForKey:@"status"]intValue] == 1){
                    [delegate.defaults setBool:true forKey:@"otp_verified"];
                    Popupmainview.hidden = true;
                    [self.view makeToast:[data valueForKey:@"message"]];
                }else if([[data valueForKey:@"status"]intValue] == -1){
                    [commonclass logoutFunction];
                }else{
                    [self.view makeToast:[data valueForKey:@"message"]];
                }
            }
//            }else if([seg_string isEqualToString:@"Keywords"]){
//                if([[data valueForKey:@"status"]intValue] == 1){
//                    [highstreetArr removeAllObjects];
//                    highstreetArr = [data valueForKey:@"items"];
//                }else{
//                    [self.view makeToast:[data valueForKey:@"message"]];
//                }
//                [resultTable reloadData];
//            }
        }else{
            [self.view makeToast:@"Oops server Error!"];
        }
        
        [indicator stopAnimating];
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    });
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
//    currentLatitude = [[delegate.defaults valueForKey:@"latitude"]floatValue];
//    currentLongitude = [[delegate.defaults valueForKey:@"longitude"]floatValue];
    //    if([[[defaults dictionaryRepresentation] allKeys] containsObject:@"loc_name"]){
    //        NSLog(@"mykey found");
    //    }else{
    
    [delegate.defaults setValue:locality forKey:@"updateloc_name"];
    [delegate.defaults setValue:@"myloc" forKey:@"locupdatefrom"];
    [delegate.defaults setValue:locality forKey:@"myloc_name"];
   
    //}
    [delegate.defaults synchronize];
}


#pragma mark - sending parameters to server methods
-(void)getStoresResponseByTypes:(NSString *)storetype latitude:(float)storelatitude longitude:(float)storeLongitude radius:(float)storeRadius{
    seg_string = @"Verticals";
    NSString *messageBody;
//    if ([[delegate.defaults valueForKey:@"shareStore"] isEqualToString:@"sharedStore"]) {
//        messageBody = [NSString stringWithFormat:@"log_id=%@&latitude=%f&longitude=%f&current_latitude=%f&current_longitude=%f&radius=%f&type=%@&shared=%@",[delegate.defaults valueForKey:@"logid"],storelatitude,storeLongitude,currentLatitude,currentLongitude,storeRadius,storetype,@"1"];
//        NSLog(@"body.. %@",messageBody);
//        NSLog(@"commonclass.searchListURL.. %@",commonclass.searchListURL);
//        
//    }else{
    messageBody = [NSString stringWithFormat:@"log_id=%@&latitude=%f&longitude=%f&current_latitude=%@&current_longitude=%@&radius=%f&type=%@",[delegate.defaults valueForKey:@"logid"],storelatitude,storeLongitude,[delegate.defaults valueForKey:@"longitude"],[delegate.defaults valueForKey:@"longitude"],storeRadius,storetype];
    NSLog(@"body.. %@",messageBody);
    NSLog(@"commonclass.searchListURL.. %@",commonclass.searchListURL);
//    }
    if([commonclass isActiveInternet] == YES){
    [commonclass sendRequest:self.view mutableDta:searchData url:commonclass.searchListURL msgBody:messageBody];
    }else{
        [commonclass Redirect:self.navigationController Identifier:@"InternetDisconnectViewController"];
        //[self.view makeToast:@"Check your internet connection"];
    }
}

-(void)getStoresResponseByCategories:(NSString *)storetype latitude:(float)storelatitude longitude:(float)storeLongitude radius:(float)storeRadius{
    //current_latitude,current_longitude
    NSString *messageBody;
//    if ([[delegate.defaults valueForKey:@"shareStore"] isEqualToString:@"sharedStore"]) {
//        messageBody = [NSString stringWithFormat:@"log_id=%@&latitude=%f&longitude=%f&current_latitude=%f&current_longitude=%f&radius=%f&category_id=%@&type=%@&shared=%@",[delegate.defaults valueForKey:@"logid"],storelatitude,storeLongitude,currentLatitude,currentLongitude,storeRadius,[delegate.defaults valueForKey:@"category"],storetype,@"1"];
//        NSLog(@"body.. %@",messageBody);
//        NSLog(@"commonclass.searchListURL.. %@",commonclass.searchListURL);
//    }else{
    messageBody = [NSString stringWithFormat:@"log_id=%@&latitude=%f&longitude=%f&current_latitude=%@&current_longitude=%@&radius=%f&category_id=%@&type=%@",[delegate.defaults valueForKey:@"logid"],storelatitude,storeLongitude,[delegate.defaults valueForKey:@"latitude"],[delegate.defaults valueForKey:@"longitude"],storeRadius,[delegate.defaults valueForKey:@"category"],storetype];
    NSLog(@"body.. %@",messageBody);
    NSLog(@"commonclass.searchListURL.. %@",commonclass.searchListURL);
  //  }
    if([commonclass isActiveInternet] == YES){
    [commonclass sendRequest:self.view mutableDta:searchData url:commonclass.searchListURL msgBody:messageBody];
    }else{
        [commonclass Redirect:self.navigationController Identifier:@"InternetDisconnectViewController"];
        //[self.view makeToast:@"Check your internet connection"];
    }
}

-(void)getStoresResponseByNearBy:(float)storelatitude longitude:(float)storeLongitude radius:(float)storeRadius{
    //current_latitude,current_longitude
    NSString *messageBody;
//    if ([[delegate.defaults valueForKey:@"shareStore"] isEqualToString:@"sharedStore"]) {
//        messageBody = [NSString stringWithFormat:@"log_id=%@&latitude=%f&longitude=%f&current_latitude=%f&current_longitude=%f&radius=%f&shared=%@",[delegate.defaults valueForKey:@"logid"],storelatitude,storeLongitude,currentLatitude,currentLongitude,storeRadius,@"1"];
//        NSLog(@"body.. %@",messageBody);
//        NSLog(@"commonclass.searchListURL.. %@",commonclass.searchListURL);
//    }else{
        messageBody = [NSString stringWithFormat:@"log_id=%@&latitude=%f&longitude=%f&current_latitude=%@&current_longitude=%@&radius=%f",[delegate.defaults valueForKey:@"logid"],storelatitude,storeLongitude,[delegate.defaults valueForKey:@"latitude"],[delegate.defaults valueForKey:@"longitude"],storeRadius];
    NSLog(@"body.. %@",messageBody);
    NSLog(@"commonclass.searchListURL.. %@",commonclass.searchListURL);
   // }
    if([commonclass isActiveInternet] == YES){
    [commonclass sendRequest:self.view mutableDta:searchData url:commonclass.searchListURL msgBody:messageBody];
    }else{
        [commonclass Redirect:self.navigationController Identifier:@"InternetDisconnectViewController"];
        //[self.view makeToast:@"Check your internet connection"];
    }
}


-(void)getStoresResponseBySearchKeyword:(float)storelatitude longitude:(float)storeLongitude radius:(float)storeRadius{
    seg_string = @"High Street";
    [self PagerBtns:true];
    
    NSString *messageBody;
//    if ([[delegate.defaults valueForKey:@"shareStore"] isEqualToString:@"sharedStore"]) {
//        messageBody = [NSString stringWithFormat:@"log_id=%@&latitude=%f&longitude=%f&current_latitude=%f&current_longitude=%f&radius=%f&s=%@&shared=%@",[delegate.defaults valueForKey:@"logid"],storelatitude,storeLongitude,currentLatitude,currentLongitude,storeRadius,[delegate.defaults valueForKey:@"Search_Keyword"],@"1"];
//        NSLog(@"body.. %@",messageBody);
//        NSLog(@"commonclass.searchListURL.. %@",commonclass.searchListURL);
//    }else{
    messageBody = [NSString stringWithFormat:@"log_id=%@&latitude=%f&longitude=%f&current_latitude=%@&current_longitude=%@&radius=%f&s=%@",[delegate.defaults valueForKey:@"logid"],storelatitude,storeLongitude,[delegate.defaults valueForKey:@"latitude"],[delegate.defaults valueForKey:@"longitude"],storeRadius,[delegate.defaults valueForKey:@"Search_Keyword"]];
    NSLog(@"body.. %@",messageBody);
    NSLog(@"commonclass.searchListURL.. %@",commonclass.searchListURL);
 //  }
    if([commonclass isActiveInternet] == YES){
    [commonclass sendRequest:self.view mutableDta:searchData url:commonclass.searchListURL msgBody:messageBody];
    }else{
        [commonclass Redirect:self.navigationController Identifier:@"InternetDisconnectViewController"];
        //[self.view makeToast:@"Check your internet connection"];
    }
}

-(void)getFavourites:(NSString *)storetype latitude:(float)storelatitude longitude:(float)storeLongitude radius:(float)storeRadius{
    NSString *messageBody;
//    if ([[delegate.defaults valueForKey:@"shareStore"] isEqualToString:@"sharedStore"]) {
//        messageBody = [NSString stringWithFormat:@"log_id=%@&latitude=%f&longitude=%f&current_latitude=%f&current_longitude=%f&radius=%f&favorite=1&type=%@&shared=%@",[delegate.defaults valueForKey:@"logid"],storelatitude,storeLongitude,currentLatitude,currentLongitude,storeRadius,storetype,@"1"];
//        NSLog(@"body.. %@",messageBody);
//        NSLog(@"commonclass.searchListURL.. %@",commonclass.searchListURL);
//    }else{
        messageBody = [NSString stringWithFormat:@"log_id=%@&latitude=%f&longitude=%f&current_latitude=%@&current_longitude=%@&radius=%f&favorite=1&type=%@",[delegate.defaults valueForKey:@"logid"],storelatitude,storeLongitude,[delegate.defaults valueForKey:@"latitude"],[delegate.defaults valueForKey:@"longitude"],storeRadius,storetype];
    NSLog(@"body.. %@",messageBody);
    NSLog(@"commonclass.searchListURL.. %@",commonclass.searchListURL);
   // }
    [commonclass sendRequest:self.view mutableDta:searchData url:commonclass.searchListURL msgBody:messageBody];
    
    
}

-(void)getSharedStore:(NSString *)storetype latitude:(float)storelatitude longitude:(float)storeLongitude radius:(float)storeRadius{
    
    //    if ([[delegate.defaults valueForKey:@"shareStore"] isEqualToString:@"sharedStore"]) {
       NSString *messageBody = [NSString stringWithFormat:@"log_id=%@&latitude=%f&longitude=%f&current_latitude=%@&current_longitude=%@&radius=%f&favorite=1&type=%@&shared=%@",[delegate.defaults valueForKey:@"logid"],storelatitude,storeLongitude,[delegate.defaults valueForKey:@"latitude"],[delegate.defaults valueForKey:@"longitude"],storeRadius,storetype,@"1"];
            NSLog(@"body.. %@",messageBody);
            NSLog(@"commonclass.searchListURL.. %@",commonclass.searchListURL);
        [commonclass sendRequest:self.view mutableDta:searchData url:commonclass.searchListURL msgBody:messageBody];
    
}

-(void)getResponseBuckets:(NSString *)storetype latitude:(float)storelatitude longitude:(float)storeLongitude radius:(float)storeRadius{
    NSString *messageBody;
    if ([[delegate.defaults valueForKey:@"shareStore"] isEqualToString:@"sharedStore"]) {
        messageBody = [NSString stringWithFormat:@"log_id=%@&latitude=%f&longitude=%f&current_latitude=%@&current_longitude=%@&radius=%f&bucket_id=%@&type=%@&shared=%@",[delegate.defaults valueForKey:@"logid"],storelatitude,storeLongitude,[delegate.defaults valueForKey:@"latitude"],[delegate.defaults valueForKey:@"longitude"],storeRadius,[delegate.defaults valueForKey:@"bucketID"],storetype,@"1"];
        NSLog(@"body.. %@",messageBody);
        NSLog(@"commonclass.searchListURL.. %@",commonclass.searchListURL);
    }else{
        messageBody = [NSString stringWithFormat:@"log_id=%@&latitude=%f&longitude=%f&current_latitude=%@&current_longitude=%@&radius=%f&bucket_id=%@&type=%@",[delegate.defaults valueForKey:@"logid"],storelatitude,storeLongitude,[delegate.defaults valueForKey:@"latitude"],[delegate.defaults valueForKey:@"longitude"],storeRadius,[delegate.defaults valueForKey:@"bucketID"],storetype];
    NSLog(@"body.. %@",messageBody);
    NSLog(@"commonclass.searchListURL.. %@",commonclass.searchListURL);
    }
    if([commonclass isActiveInternet] == YES){
    [commonclass sendRequest:self.view mutableDta:searchData url:commonclass.searchListURL msgBody:messageBody];
    }else{
        [commonclass Redirect:self.navigationController Identifier:@"InternetDisconnectViewController"];
        //[self.view makeToast:@"Check your internet connection"];
    }
}

-(void)backTapped{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - tableview methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([premiumListArr count] == 0){
        premCount = 0;
    }else{
        premCount = 1;
    }
    
    if ((highstreetArr.count || brandedArr.count || designerArr.count || verticalsArr.count < 4) && premiumListArr.count > 5){
        premCount = 0;
    }
    
    if([seg_string isEqualToString:@"High Street"]){
        NSLog(@"%lu , %lu",(unsigned long)highstreetArr.count ,([premiumListArr count] / 5) + premCount);
        return ([highstreetArr count] + ([premiumListArr count] / 5) + premCount);
    }else if([seg_string isEqualToString:@"Brands"]){
        NSLog(@"count.. %lu",(unsigned long)brandedArr.count);
        return ([brandedArr count] + ([premiumListArr count] / 5) + premCount);
    }else if([seg_string isEqualToString:@"Designers"]){
        NSLog(@"%lu , %lu",(unsigned long)designerArr.count ,([premiumListArr count] / 5) + 1);
        return ([designerArr count] + ([premiumListArr count] / 5) + premCount);
    }else if([seg_string isEqualToString:@"Exhibitions"]){
        return [exhibitionArr count];
    }else if([seg_string isEqualToString:@"Verticals"]){
        NSLog(@"%lu , %lu",(unsigned long)designerArr.count ,([premiumListArr count] / 5) + 1);
        return ([verticalsArr count] + ([premiumListArr count] / 5) + premCount);
    }else{
        return 0;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if([seg_string isEqualToString:@"Exhibitions"]){
        return 195;
    }else{
        if (imgcnt == 0){
            if ([typeCell isEqualToString:@"Premium"]){
                return 220;
            }else{
                return 170;
            }
        }else{
            return 220;
        }
    }
}

//-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
//    return  UITableViewAutomaticDimension;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    if([seg_string isEqualToString:@"Exhibitions"]){
        static NSString *cellIdentifier = @"ExhibitionNormal";
        cell1 = (ExhibitionNormalCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell1 == nil) {
            cell1 = [[ExhibitionNormalCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
         [cell1 setSelectionStyle:UITableViewCellSelectionStyleNone];
         [self setExhibitionData:exhibitionArr indexpath:indexPath];
        return cell1;
    }
    else{
        NSLog(@"Premium list arr count.. %lu",(unsigned long)premiumListArr.count);
        if(indexPath.row % 5 == 0 && indexPath.row <= premiumListArr.count && premiumListArr.count != 0){
             NSLog(@"Premium Arr... %@",premiumListArr);
            static NSString *cellIdentifier = @"Premium";
           premiumcell = (PremiumListingCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (premiumcell == nil) {
                premiumcell = [[PremiumListingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            }
            typeCell = @"Premium";
            [premiumcell setSelectionStyle:UITableViewCellSelectionStyleNone];
            [self setPremiumData:premiumListArr indexpath:indexPath];
            
            return premiumcell;
        }
        else{
            static NSString *cellIdentifier = @"Normal";
           cell = (NormalListCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (cell == nil) {
                cell = [[NormalListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            }
            typeCell = @"Normal";
            
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            
//            NSLog(@"designerArr %lu",(unsigned long)highstreetArr.count);
            NSLog(@"old indexpath.row %lu",(unsigned long)indexPath.row);
//           
//           long int rows = [resultTable numberOfRowsInSection:indexPath.section];
//             NSLog(@"rows %lu",(unsigned long)rows);
//            
//            NSLog(@"row is... %lu",indexPath.row - [premiumListArr count]);
            
           
            
           // NSLog(@"new indexpath.row %lu",(unsigned long)newIndexPath.row);
            
            if([seg_string isEqualToString:@"High Street"]){
//                if(counter == highstreetArr.count){
//                    counter--;
//                }
                NSIndexPath* newIndexPath = [[NSIndexPath alloc]init];
                if (premiumListArr.count == 0 ){
                    newIndexPath = [NSIndexPath indexPathForRow:indexPath.row  inSection:indexPath.section];
                }else{
                    newIndexPath = [NSIndexPath indexPathForRow:indexPath.row - 1 inSection:indexPath.section];
                }
                NSLog(@"%@",highstreetArr);
                if (highstreetArr.count > newIndexPath.row){
                [self setData:highstreetArr indexpath:newIndexPath];
                }
            }else if([seg_string isEqualToString:@"Brands"]){
//                if(counter == brandedArr.count){
//                    counter--;
//                }
                NSIndexPath* newIndexPath = [[NSIndexPath alloc]init];
                if (premiumListArr.count == 0 ){
                    newIndexPath = [NSIndexPath indexPathForRow:indexPath.row  inSection:indexPath.section];
                }else{
                    newIndexPath = [NSIndexPath indexPathForRow:indexPath.row - 1 inSection:indexPath.section];
                }
                // NSIndexPath* newIndexPath = [NSIndexPath indexPathForRow:indexPath.row - 1 inSection:indexPath.section];
                
                if (brandedArr.count > newIndexPath.row){
                    [self setData:brandedArr indexpath:newIndexPath];
                }
                
            }else if([seg_string isEqualToString:@"Designers"]){
//                if(counter == designerArr.count){
//                    counter--;
//                }
                NSLog(@"%lu",(unsigned long)designerArr.count);
                NSIndexPath* newIndexPath = [[NSIndexPath alloc]init];
                if (premiumListArr.count == 0 ){
                    newIndexPath = [NSIndexPath indexPathForRow:indexPath.row  inSection:indexPath.section];
                }else{
                    newIndexPath = [NSIndexPath indexPathForRow:indexPath.row - 1 inSection:indexPath.section];
                }
                
                if (designerArr.count > newIndexPath.row){
                    [self setData:designerArr indexpath:newIndexPath];
                }
            }else if([seg_string isEqualToString:@"Verticals"]){
                
                NSIndexPath* newIndexPath = [[NSIndexPath alloc]init];
                if (premiumListArr.count == 0 ){
                    newIndexPath = [NSIndexPath indexPathForRow:indexPath.row  inSection:indexPath.section];
                }else{
                    newIndexPath = [NSIndexPath indexPathForRow:indexPath.row - 1 inSection:indexPath.section];
                }
                if (verticalsArr.count > newIndexPath.row){
                    [self setData:verticalsArr indexpath:newIndexPath];
                }
               //  NSIndexPath* newIndexPath = [NSIndexPath indexPathForRow:indexPath.row - 1 inSection:indexPath.section];
                
            }
            
           // counter ++;
            return cell;
        }
    }
}

-(void)setPremiumData:(NSMutableArray *)arr indexpath:(NSIndexPath *)indexpath{
    premiumcell.PremiumListingScroll.bounces = NO;
    int btnwt = self.view.frame.size.width-30;
    NSLog(@"tempcount.. %d",temppremiumCnt);
    
//    awayDist = [NSString stringWithFormat:@"%@",[arr[indexpath.row] valueForKey:@"distance_in_kms"]];
//    NSLog(@"away dist..%@",awayDist);
//    [distAwayArr addObject:awayDist];

//    if(temppremiumCnt>=4){
        int i = 5;
        if (premiumListArr.count <= i) {
            premiumcell.PremiumListingScroll.contentSize = CGSizeMake((btnwt * premiumListArr.count)+25, premiumcell.PremiumListingScroll.frame.size.height);
        }else{
            premiumcell.PremiumListingScroll.contentSize = CGSizeMake((btnwt * 5)+25, premiumcell.PremiumListingScroll.frame.size.height);
//            i = i + i;
//            while (i < premiumListArr.count) {
//                premiumcell.PremiumListingScroll.contentSize = CGSizeMake((btnwt * i - premiumListArr.count)+25, premiumcell.PremiumListingScroll.frame.size.height);
//            }
        }
//    }else{
//        premiumcell.PremiumListingScroll.contentSize = CGSizeMake((btnwt * temppremiumCnt)+25, premiumcell.PremiumListingScroll.frame.size.height);
//    }
    
//    if(premiumListArr.count>1){
//        premiumcell.PremiumListingScroll.scrollEnabled = YES;
//    }else{
//        premiumcell.PremiumListingScroll.scrollEnabled = NO;
//    }
//    premiumcell.PremiumListingScroll.userInteractionEnabled = NO;
//    NSLog(@"%d",j);
    for (int j = temppremiumCnt - 1; j < premiumCnt; ++j) {
        NSLog(@"%d",j);
        if(j < temppremiumCnt+5  && j >= 0){
            NSLog(@"j...%d",j);
            UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, premiumcell.PremiumListingScroll.frame.size.width, premiumcell.PremiumListingScroll.frame.size.height)];
            //view.backgroundColor = [UIColor PopupBackground];
            view.alpha = 0.2;
            premiumImage = [[UIImageView alloc]initWithFrame:CGRectMake((btnwt + 5) * j, 0, btnwt,premiumcell.PremiumListingScroll.frame.size.height)];
            premiumImage.tag = j;
            premiumImage.backgroundColor = [UIColor lightGrayColor];
          //premiumImage.alpha = 0.5;
            NSString *imglink = [NSString stringWithFormat:@"%@/%@",commonclass.siteURL,[premiumListArr[j] valueForKey:@"cover_pic"]];
            [premiumImage setImageWithURL:[NSURL URLWithString:imglink] placeholderImage:[UIImage imageNamed:@"splash_iPhone.png"] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
             [premiumcell.PremiumListingScroll addSubview:premiumImage];
             [premiumcell.PremiumListingScroll addSubview:view];
//            premiumImage.userInteractionEnabled = true;
//            view.userInteractionEnabled = true;
            premiumStoreNamelabel = [[UILabel alloc]initWithFrame:CGRectMake((btnwt + 10) * j, 3, 200, 25)];
            [premiumStoreNamelabel setFont:[UIFont fontWithName:@"Roboto-Bold" size:16.0f]];
            premiumStoreNamelabel.textColor = [UIColor whiteColor];
            premiumStoreNamelabel.numberOfLines = 0;
            premiumStoreNamelabel.lineBreakMode = NSLineBreakByWordWrapping;
            premiumStoreNamelabel.text = [NSString stringWithFormat:@"%@",[premiumListArr[j] valueForKey:@"store_name"]];
            
            premiumAwayDist = [NSString stringWithFormat:@"%@",[arr[j] valueForKey:@"distance_in_kms"]];
            NSLog(@"away dist..%@",awayDist);
            [premiumdistAwayArr addObject:premiumAwayDist];
            
            UILabel *addressLbl = [[UILabel alloc]initWithFrame:CGRectMake((btnwt + 10) * j, 26, 200, 25)];
            [addressLbl setFont:[UIFont fontWithName:@"Roboto" size:12.0f]];
            addressLbl.textColor = [UIColor whiteColor];
            addressLbl.numberOfLines = 0;
            addressLbl.lineBreakMode = NSLineBreakByWordWrapping;
            addressLbl.text = [NSString stringWithFormat:@"%@, %@",[premiumListArr[j] valueForKey:@"address_1"],[premiumListArr[j] valueForKey:@"address_2"]];
            
            UILabel * shopCatLbl = [[UILabel alloc]initWithFrame:CGRectMake((btnwt + 10) * j, addressLbl.frame.origin.y + 20, 200, 25)];
            [shopCatLbl setFont:[UIFont fontWithName:@"Roboto" size:12.0f]];
            shopCatLbl.textColor = [UIColor whiteColor];
            shopCatLbl.numberOfLines = 0;
            shopCatLbl.lineBreakMode = NSLineBreakByWordWrapping;
            if(([premiumListArr[j] valueForKey:@"categories"] == [NSNull null])){
            }else{
                NSString * shopforLbl = [premiumListArr[j] valueForKey:@"categories"];
                NSArray * shpArr = [shopforLbl componentsSeparatedByString:@","];
                if(shpArr.count==1){
                    shopCatLbl.text = [NSString stringWithFormat:@"%@ ",shpArr[0]];
                }else if (shpArr.count==2){
                    shopCatLbl.text = [NSString stringWithFormat:@"%@ | %@ ",shpArr[0],shpArr[1]];
                }else{
                    shopCatLbl.text = [NSString stringWithFormat:@"%@ | %@ | %@",shpArr[0],shpArr[1],shpArr[2]];
                }
            }
            
            UILabel * exclusivediscLbl = [[UILabel alloc]initWithFrame:CGRectMake((btnwt + 10) * j, shopCatLbl.frame.origin.y + 50, 200, 38)];
            [exclusivediscLbl setFont:[UIFont fontWithName:@"Roboto" size:35.0f]];
            exclusivediscLbl.textColor = [UIColor whiteColor];
            exclusivediscLbl.numberOfLines = 0;
            exclusivediscLbl.lineBreakMode = NSLineBreakByWordWrapping;
            exclusivediscLbl.text = [NSString stringWithFormat:@"%@%%",[premiumListArr[j] valueForKey:@"exclusive_discount"]];
            
            UILabel * storeOfferLbl = [[UILabel alloc]initWithFrame:CGRectMake((btnwt + 10) * j, exclusivediscLbl.frame.origin.y + 35, 200, 30)];
            [storeOfferLbl setFont:[UIFont fontWithName:@"Roboto" size:12.0f]];
            storeOfferLbl.textColor = [UIColor whiteColor];
            storeOfferLbl.numberOfLines = 0;
            storeOfferLbl.lineBreakMode = NSLineBreakByWordWrapping;
            storeOfferLbl.text = @"STORE OFFER";
            
            UIButton * PremiumCheckinBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            PremiumCheckinBtn.frame = CGRectMake((btnwt + 25) * j, storeOfferLbl.frame.origin.y + 35, 110, 30);
            PremiumCheckinBtn.layer.borderWidth = 1.0f;
            PremiumCheckinBtn.layer.borderColor = [[UIColor whiteColor] CGColor];
            PremiumCheckinBtn.layer.cornerRadius = 18.0f;
            [PremiumCheckinBtn setTitle:@"CHECKIN" forState:UIControlStateNormal];
            [PremiumCheckinBtn.titleLabel setFont:[UIFont fontWithName:@"Roboto" size:16]];
            [PremiumCheckinBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            PremiumCheckinBtn.tag = j;
            [PremiumCheckinBtn addTarget:self action:@selector(PremiumCheckinTapped:) forControlEvents:UIControlEventTouchUpInside];
            
            UIButton * PremiumCallBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            PremiumCallBtn.frame = CGRectMake((PremiumCheckinBtn.frame.origin.x + PremiumCheckinBtn.frame.size.width) + 10  , storeOfferLbl.frame.origin.y + 35, 30, 30);
            PremiumCallBtn.layer.cornerRadius = 18.0f;
            PremiumCallBtn.tag = j;
            [PremiumCallBtn setTitle:commonclass.storephoneIcon forState:UIControlStateNormal];
            [PremiumCallBtn.titleLabel setFont:[UIFont fontWithName:@"fontello" size:30]];
            [PremiumCallBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [PremiumCallBtn addTarget:self action:@selector(PremiumCallTapped:) forControlEvents:UIControlEventTouchUpInside];
    
            [premiumphonenoArr addObject:[arr[j] valueForKey:@"phone_number"]];
            [premiumphoneno_StoreIDArr addObject:[arr[j] valueForKey:@"store_id"]];
            [premiumcell.PremiumListingScroll addSubview:premiumStoreNamelabel];
            [premiumcell.PremiumListingScroll addSubview:addressLbl];
            [premiumcell.PremiumListingScroll addSubview:shopCatLbl];
            [premiumcell.PremiumListingScroll addSubview:storeOfferLbl];
            [premiumcell.PremiumListingScroll addSubview:exclusivediscLbl];
            [premiumcell.PremiumListingScroll addSubview:PremiumCheckinBtn];
         // [premiumcell.PremiumListingScroll bringSubviewToFront:PremiumCheckinBtn];
            [premiumcell.PremiumListingScroll addSubview:PremiumCallBtn];
           
        }
    }
    

    
}

-(void)PremiumCheckinTapped:(UIButton *)sender{
//    if ([time isEqualToString:@"Closed"]){
//        [self.view makeToast:@"Store is closed"];
//    }else{
        // NSLog(@"dista arr is...%@",distAwayArr);
        NSString * mobilenumber = [delegate.defaults valueForKey:@"mobile"];
        NSLog(@"mobilenumber %@",mobilenumber);
        NSLog(@"mobilenumber length %lu",(unsigned long)mobilenumber.length);
        // NSLog(@"%u",[delegate.defaults boolForKey:@"otp_verified"]);
        if ([[delegate.defaults valueForKey:@"otp_verified"]boolValue] == false){
            if([[delegate.defaults valueForKey:@"updateMobile"]boolValue] == false){
                Popupmainview.hidden = false;
                verifyView.hidden = false;
                OTPView.hidden = true;
            }else{
                Popupmainview.hidden = false;
                verifyView.hidden = true;
                OTPView.hidden = false;
                // OTPView.hidden = false;
            }
            
        }else{
            //    if(mobilenumber.length == 0){
            //    }else{
            if([premiumdistAwayArr[sender.tag] doubleValue]<0.25){
                [commonclass Redirect:self.navigationController Identifier:@"GenerateCouponsViewController"];
            }else{
                [self.view makeToast:@"You have to be in 250 meters radius to CHECK IN into the store"];
            }
        }
    //}
}

-(void)PremiumCallTapped:(UIButton *)sender{
    NSLog(@"phoneno_StoreIDArr.. %@",phoneno_StoreIDArr);
    store_ID = [premiumphoneno_StoreIDArr[sender.tag] intValue];
    NSLog(@"store_id.. %ld",store_ID);
    [self phoneResponse];
    NSString *dialNumber =[NSString stringWithFormat:@"telprompt://%@",[premiumphonenoArr objectAtIndex:sender.tag]];
    NSLog(@"number..%@",dialNumber);
    UIApplication *app = [UIApplication sharedApplication];
    NSString *dialThis = [NSString stringWithFormat:@"%@", dialNumber];
    NSURL *url = [NSURL URLWithString:dialThis];
    [app openURL:url];
}

-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView
                    withVelocity:(CGPoint)velocity
             targetContentOffset:(inout CGPoint *)targetContentOffset{
    
    if (velocity.y > 0){
        temppremiumCnt = temppremiumCnt + 4;
    }
    if (velocity.y < 0){
       temppremiumCnt = temppremiumCnt - 4;
    }
}



-(void)setExhibitionData:(NSMutableArray *)arr indexpath:(NSIndexPath *)indexpath{
    NSLog(@"name.. %@",[arr[indexpath.row] valueForKey:@"title"]);
    cell1.storeNameLbl.text = [NSString stringWithFormat:@"%@",[arr[indexpath.row] valueForKey:@"title"]];
    
    NSString * startdatetemp = [arr[indexpath.row] valueForKey:@"from_time"];
    NSString * enddatetemp = [arr[indexpath.row] valueForKey:@"end_time"];

    NSArray *datearr=[commonclass setDate:startdatetemp seconddate:enddatetemp];
    cell1.storeDateLbl.text = [NSString stringWithFormat:@"%@%@",datearr[0],datearr[1]];
    
    imgcnt = [[arr[indexpath.row] valueForKey:@"exhibitions_images"] count] ;
    NSLog(@"img count.. %ld",imgcnt);
    
    for (int j = 0; j < imgcnt; j++) {
        NSString * imglink = [[arr[indexpath.row] valueForKey:@"exhibitions_images"][j] valueForKey:@"images"];
        storeimgview = [[UIImageView alloc]initWithFrame:CGRectMake(70 * j, 0, 65,cell1.storeGalleryView.frame.size.height)];
        storeimgview.tag = j;
        storeimgview.layer.borderWidth = 1.0f;
        storeimgview.layer.borderColor = [[UIColor View_Border] CGColor];
        storeimgview.layer.backgroundColor = [[UIColor coupon_back]CGColor];
        storeimgview.layer.cornerRadius = 5.0f;
        [storeimgview setImageWithURL:[NSURL URLWithString:imglink] placeholderImage:[UIImage imageNamed:@"splash_iPhone.png"] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [cell1.storeGalleryView addSubview:storeimgview];
    }
   
    cell1.storeAwayIconLbl.text = commonclass.storeawayIcon;
    cell1.storecheckInBtn.layer.cornerRadius = 15.0f;
    cell1.storecheckInBtn.layer.borderWidth = 1.0f;
    cell1.storecheckInBtn.layer.borderColor = [[UIColor TextColor_TxtFld] CGColor];
    [cell1.storePhoneBtn setTitle:commonclass.storephoneIcon forState:UIControlStateNormal];
    cell1.storePhoneBtn.tag = indexpath.row;
    [cell1.storePhoneBtn addTarget:self action:@selector(phoneTapped:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)setData:(NSMutableArray *)arr indexpath:(NSIndexPath *)indexpath{
    //NSLog(@"arr..%@",arr[indexpath.row]);
         [phoneno_StoreIDArr addObject:[arr[indexpath.row] valueForKey:@"store_id"]];
    //[delegate.defaults setObject:store_ID forKey:@"store_id"];
    NSLog(@"%@",[delegate.defaults valueForKey:@"store_id"]);
    cell.storeNameLbl.text = [NSString stringWithFormat:@"%@",[arr[indexpath.row] valueForKey:@"store_name"]];
    cell.storeAddLbl.text = [NSString stringWithFormat:@"%@, %@",[arr[indexpath.row] valueForKey:@"address_1"],[arr[indexpath.row] valueForKey:@"address_2"]];
    
    if([[arr[indexpath.row] valueForKey:@"rating"] intValue] == 0){
        cell.storeStarsLbl.text = commonclass.emptystarIcon;
        cell.storeRatingLbl.text = @"0";
    }else{
        cell.storeStarsLbl.text = commonclass.starIcon;
        cell.storeRatingLbl.text = [NSString stringWithFormat:@"%.1f",[[arr[indexpath.row] valueForKey:@"rating"] floatValue]];
    }
    cell.storeValidCpnCodeLbl.text = [NSString stringWithFormat:@"%@ Accepted Coupon Code | %@ Checkins | %@ Reviews  ",[arr[indexpath.row] valueForKey:@"accepted_coupons"],[arr[indexpath.row] valueForKey:@"no_of_checkins"],[arr[indexpath.row] valueForKey:@"no_of_votes"]];
    
    if([arr[indexpath.row] valueForKey:@"start_time"] == [NSNull null] && [arr[indexpath.row] valueForKey:@"end_time"] == [NSNull null]){
        cell.storeTimeLbl.backgroundColor = [UIColor redColor];
        time = @"Closed";
        cell.storeTimeLbl.textAlignment = NSTextAlignmentCenter;
    }else{
        cell.storeTimeLbl.backgroundColor = [UIColor greenColor];
        NSString * startTime = [commonclass calculateTimeinAMPM:[arr[indexpath.row] valueForKey:@"start_time"]];
        NSString * endTime = [commonclass calculateTimeinAMPM:[arr[indexpath.row] valueForKey:@"end_time"]];
        time = [NSString stringWithFormat:@"%@-%@",startTime,endTime];
    }
    cell.storeTimeLbl.text = time;
    
    if(([arr[indexpath.row] valueForKey:@"categories"] == [NSNull null])){
    }else{
    NSString * shopforLbl = [arr[indexpath.row] valueForKey:@"categories"];
    NSArray * shpArr = [shopforLbl componentsSeparatedByString:@","];
    if(shpArr.count==1){
        cell.storeShopForLbl.text = [NSString stringWithFormat:@"%@ ",shpArr[0]];
    }else if (shpArr.count==2){
        cell.storeShopForLbl.text = [NSString stringWithFormat:@"%@ | %@ ",shpArr[0],shpArr[1]];
    }else{
        cell.storeShopForLbl.text = [NSString stringWithFormat:@"%@ | %@ | %@",shpArr[0],shpArr[1],shpArr[2]];
    }
    }
    
    for(UIImageView * view in [cell.storeGalleryView subviews]){
        [view removeFromSuperview];
    }
    
    if([arr[indexpath.row] valueForKey:@"images"] != [NSNull null]){
        imgcnt = [[arr[indexpath.row] valueForKey:@"images"] count];
        for (int j = 0; j < imgcnt; j++) {
            NSString * imglink = [NSString stringWithFormat:@"%@/%@",commonclass.siteURL,[arr[indexpath.row] valueForKey:@"images"][j]];
            storeimgview = [[UIImageView alloc]initWithFrame:CGRectMake(70 * j, 0, 65,cell.storeGalleryView.frame.size.height)];
            storeimgview.tag = j;
            storeimgview.layer.borderWidth = 1.0f;
            storeimgview.layer.borderColor = [[UIColor View_Border] CGColor];
            storeimgview.layer.backgroundColor = [[UIColor coupon_back]CGColor];
            storeimgview.layer.cornerRadius = 5.0f;
            storeimgview.clipsToBounds = YES;
            [storeimgview setImageWithURL:[NSURL URLWithString:imglink] placeholderImage:[UIImage imageNamed:@"splash_iPhone.png"] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            [cell.storeGalleryView addSubview:storeimgview];
        }
    }else{
       // CGRect newFrame = CGRectMake(cell.storeGalleryView.frame.origin.x, cell.storeGalleryView.frame.origin.y, 200, 0);
        
       // cell.storeGalleryView.frame = newFrame;
        
        //[UIView animateWithDuration:.1 animations:^{
//            CGRect rect=cell.storeGalleryView.frame;
//            rect.origin.x=cell.storeGalleryView.superview.frame.size.width;
//            cell.storeGalleryView.frame=rect;
//       // } completion:^(BOOL finished) {
//            [self reArrangeSuperView:cell.storeGalleryView.superview withDeletedViewFrame:cell.storeGalleryView.frame];
//            [cell.storeGalleryView removeFromSuperview];
//       // }];
        
    }
    
    cell.storeAwayIconLbl.text = commonclass.storeawayIcon;
    cell.storeAwayIconLbl.tag = indexpath.row;
    cell.storeAwayIconLbl.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(MoveToMapTapped:)];
    [cell.storeAwayIconLbl addGestureRecognizer:gestureRecognizer];
    
    NSLog(@"distance.. %@",[arr[indexpath.row] valueForKey:@"distance_in_kms"]);
    NSLog(@"%@",arr[indexpath.row]);
    awayDist = [NSString stringWithFormat:@"%@",[arr[indexpath.row] valueForKey:@"distance_in_kms"]];
    NSLog(@"away dist..%@",awayDist);
    [distAwayArr addObject:awayDist];
    cell.storeAwayLbl.text = [NSString stringWithFormat:@"%.2f Kms away  ",[awayDist doubleValue]];
    cell.storeDiscLbl.text = [NSString stringWithFormat:@"%@%%",[arr[indexpath.row] valueForKey:@"exclusive_discount"]];
   
    cell.storecheckInBtn.layer.cornerRadius = 15.0f;
    cell.storecheckInBtn.layer.borderWidth = 1.0f;
    cell.storecheckInBtn.tag = indexpath.row;
    cell.storecheckInBtn.layer.borderColor = [[UIColor TextColor_TxtFld] CGColor];
    [cell.storecheckInBtn addTarget:self action:@selector(CheckinTapped:) forControlEvents:UIControlEventTouchUpInside];

    [cell.storePhoneBtn setTitle:commonclass.storephoneIcon forState:UIControlStateNormal];
    cell.storePhoneBtn.tag = indexpath.row;
    [phonenoArr addObject:[arr[indexpath.row] valueForKey:@"phone_number"]];
    [cell.storePhoneBtn addTarget:self action:@selector(phoneTapped:) forControlEvents:UIControlEventTouchUpInside];
    
   // }
/*//    NSLog(@"arr..%@",arr[indexpath.row]);
//  NSLog(@"store images..%@",[[arr[indexpath.row] valueForKey:@"store_images"][indexpath.row] valueForKey:@"images"]);//images
    
    //[self setupStoreGallery:arr indexpath:indexpath];
   
 
    
//    if(!([arr[indexpath.row] valueForKey:@"store_images"] == NULL)){
//    }else{
 
    //}
    
    
//    if(!([arr[indexpath.row] valueForKey:@"start_time"] == NULL)){
//    }else{
    NSString * starttimetemp = [arr[indexpath.row] valueForKey:@"start_time"];
    NSString * endtimetemp = [arr[indexpath.row] valueForKey:@"end_time"];
    NSArray *timearr=[commonclass setTime:starttimetemp secondtime:endtimetemp];
    cell.storeTimeLbl.text = [NSString stringWithFormat:@"%@ | %@",timearr[0],timearr[1]];
    //}
 
   */
}

//Adding Delete Tap Gesture
-(void)addGestureToSubViews{
    for(UIView *view in view.subviews){
        UITapGestureRecognizer *gesture=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(deleteAction:)];
        [view addGestureRecognizer:gesture];
    }
}


-(IBAction)deleteAction:(UITapGestureRecognizer *)sender{
    UIView *view=sender.view;
    
    [UIView animateWithDuration:.3 animations:^{
        CGRect rect=view.frame;
        rect.origin.x=view.superview.frame.size.width;
        view.frame=rect;
    } completion:^(BOOL finished) {
        [self reArrangeSuperView:view.superview withDeletedViewFrame:view.frame];
        [view removeFromSuperview];
        
    }];
    
}

-(void)reArrangeSuperView:(UIView *)superView withDeletedViewFrame:(CGRect)frame{
    
    for(UIView *view in superView.subviews){
        CGRect rect=view.frame;
        
        if(rect.origin.y>frame.origin.y){
            rect.origin.y=frame.origin.y ;
        }
        
      //  [UIView animateWithDuration:.3 animations:^{
            view.frame=rect ;
      //  }];
        
    }
}

-(void)MoveToMapTapped:(UIGestureRecognizer*)recognizer{
    NSLog(@"recognizer.. %ld",recognizer.view.tag);
        NSArray * arr;
        if([seg_string isEqualToString:@"High Street"]){
            arr = [highstreetArr objectAtIndex:recognizer.view.tag];
        }else if([seg_string isEqualToString:@"Brands"]){
           arr = [brandedArr objectAtIndex:recognizer.view.tag];
        }else if([seg_string isEqualToString:@"Designers"]){
           arr = [designerArr objectAtIndex:recognizer.view.tag];
        }else if([seg_string isEqualToString:@"Verticals"]){
            arr = [verticalsArr objectAtIndex:recognizer.view.tag];
        }
    NSLog(@"arr %@",arr);
    NSString * directionLat = [arr valueForKey:@"latitude"];
    NSString * directionLong = [arr valueForKey:@"longitude"];
    
    [delegate.defaults setValue:directionLat forKey:@"directionLat"];
    [delegate.defaults setValue:directionLong forKey:@"directionLong"];
    [delegate.defaults synchronize];
    [commonclass Redirect:self.navigationController Identifier:@"DirectionViewController"];
}

-(void)CheckinTapped:(UIButton*)sender{
//  NSLog(@"brands Arr.. %@",brandedArr[sender.tag]);
    if ([time isEqualToString:@"Closed"]){
        [self.view makeToast:@"Store is closed"];
    }else{
// NSLog(@"dista arr is...%@",distAwayArr);
    NSString * mobilenumber = [delegate.defaults valueForKey:@"mobile"];
    NSLog(@"mobilenumber %@",mobilenumber);
    NSLog(@"mobilenumber length %lu",(unsigned long)mobilenumber.length);
   // NSLog(@"%u",[delegate.defaults boolForKey:@"otp_verified"]);
    if ([[delegate.defaults valueForKey:@"otp_verified"]boolValue] == false){
        if([[delegate.defaults valueForKey:@"updateMobile"]boolValue] == false){
            Popupmainview.hidden = false;
            verifyView.hidden = false;
            OTPView.hidden = true;
        }else{
            Popupmainview.hidden = false;
            verifyView.hidden = true;
            OTPView.hidden = false;
           // OTPView.hidden = false;
        }
        
    }else{
//    if(mobilenumber.length == 0){
//    }else{
        if([distAwayArr[sender.tag] doubleValue]<0.25){
            [commonclass Redirect:self.navigationController Identifier:@"GenerateCouponsViewController"];
        }else{
            [self.view makeToast:@"You have to be in 250 meters radius to CHECK IN into the store"];
        }
   }
   }
}

-(void)phoneTapped:(UIButton*)sender{
    NSLog(@"phoneno_StoreIDArr.. %@",phoneno_StoreIDArr);
    store_ID = [phoneno_StoreIDArr[sender.tag] intValue];
    NSLog(@"store_id.. %ld",store_ID);
    [self phoneResponse];
    NSString *dialNumber =[NSString stringWithFormat:@"telprompt://%@",[phonenoArr objectAtIndex:sender.tag]];
    NSLog(@"number..%@",dialNumber);
    UIApplication *app = [UIApplication sharedApplication];
    NSString *dialThis = [NSString stringWithFormat:@"%@", dialNumber];
    NSURL *url = [NSURL URLWithString:dialThis];
    [app openURL:url];
}

-(void)phoneResponse{
    seg_string = @"phone";
    if([commonclass isActiveInternet] == YES){
    NSString *messageBody = [NSString stringWithFormat:@"log_id=%@&store_id=%ld",[delegate.defaults valueForKey:@"logid"],store_ID];
    NSLog(@"body.. %@",messageBody);
    NSLog(@"commonclass.searchListURL.. %@",commonclass.callStoreURL);
    [commonclass sendRequest:self.view mutableDta:extraData url:commonclass.callStoreURL msgBody:messageBody];
    }else{
        [commonclass Redirect:self.navigationController Identifier:@"InternetDisconnectViewController"];
        //[self.view makeToast:@"Check your internet connection"];
    }
}

-(void)setupStoreGallery:(NSMutableArray*)data indexpath:(NSIndexPath*)indexpath{
    
}

-(void)couponTapped:(UIGestureRecognizer *)sender{
//    [self.view bringSubviewToFront:couponDetMainView];
//    couponDetMainView.hidden=false;
//    couponDtlSubview.layer.cornerRadius = 5.0f;
//    couponValLbl.text = [NSString stringWithFormat:@"%@%%",[[[dashboardArr valueForKey:@"items"] valueForKey:@"Coupon"][sender.view.tag] valueForKey:@"value"]];
//    couponDescLbl.text = [NSString stringWithFormat:@"%@%%",[[[dashboardArr valueForKey:@"items"] valueForKey:@"Coupon"][sender.view.tag] valueForKey:@"description"]];
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * storeNo;
    if([seg_string isEqualToString:@"High Street"]){
        if (premiumListArr.count == 0){
        if ([[highstreetArr[indexPath.row] valueForKey:@"checked_in"]boolValue] == true){
            [commonclass Redirect:self.navigationController Identifier:@"GenerateCouponsViewController"];
        }else{
            [commonclass Redirect:self.navigationController Identifier:@"DetailViewController"];
        }
        storeNo = [highstreetArr[indexPath.row] valueForKey:@"store_id"];
        }else{
            if ([[highstreetArr[indexPath.row - 1] valueForKey:@"checked_in"]boolValue] == true){
                [commonclass Redirect:self.navigationController Identifier:@"GenerateCouponsViewController"];
            }else{
                [commonclass Redirect:self.navigationController Identifier:@"DetailViewController"];
            }
            storeNo = [highstreetArr[indexPath.row - 1] valueForKey:@"store_id"];
        }
    }else if([seg_string isEqualToString:@"Brands"]){
//        if ([[brandedArr[indexPath.row - 1] valueForKey:@"checked_in"]boolValue] == true) {
//            [commonclass Redirect:self.navigationController Identifier:@"GenerateCouponsViewController"];
//        }else{
//            [commonclass Redirect:self.navigationController Identifier:@"DetailViewController"];
//        }
//        storeNo = [brandedArr[indexPath.row - 1] valueForKey:@"store_id"];
        if (premiumListArr.count == 0){
            if ([[brandedArr[indexPath.row] valueForKey:@"checked_in"]boolValue] == true){
                [commonclass Redirect:self.navigationController Identifier:@"GenerateCouponsViewController"];
            }else{
                [commonclass Redirect:self.navigationController Identifier:@"DetailViewController"];
            }
            storeNo = [brandedArr[indexPath.row] valueForKey:@"store_id"];
        }else{
            if ([[brandedArr[indexPath.row - 1] valueForKey:@"checked_in"]boolValue] == true){
                [commonclass Redirect:self.navigationController Identifier:@"GenerateCouponsViewController"];
            }else{
                [commonclass Redirect:self.navigationController Identifier:@"DetailViewController"];
            }
            storeNo = [brandedArr[indexPath.row - 1] valueForKey:@"store_id"];
        }
    }else if([seg_string isEqualToString:@"Designers"]){
   //     if ([[designerArr[indexPath.row - 1] valueForKey:@"checked_in"]boolValue] == true) {
//            [commonclass Redirect:self.navigationController Identifier:@"GenerateCouponsViewController"];
//        }else{
//            [commonclass Redirect:self.navigationController Identifier:@"DetailViewController"];
//        }
//        storeNo = [designerArr[indexPath.row - 1] valueForKey:@"store_id"];
        if (premiumListArr.count == 0){
            if ([[designerArr[indexPath.row] valueForKey:@"checked_in"]boolValue] == true){
                [commonclass Redirect:self.navigationController Identifier:@"GenerateCouponsViewController"];
            }else{
                [commonclass Redirect:self.navigationController Identifier:@"DetailViewController"];
            }
            storeNo = [designerArr[indexPath.row] valueForKey:@"store_id"];
        }else{
            if ([[designerArr[indexPath.row - 1] valueForKey:@"checked_in"]boolValue] == true){
                [commonclass Redirect:self.navigationController Identifier:@"GenerateCouponsViewController"];
            }else{
                [commonclass Redirect:self.navigationController Identifier:@"DetailViewController"];
            }
            storeNo = [designerArr[indexPath.row - 1] valueForKey:@"store_id"];
        }
    }else if([seg_string isEqualToString:@"Verticals"]){
        if (premiumListArr.count == 0){
            if ([[verticalsArr[indexPath.row] valueForKey:@"checked_in"]boolValue] == true){
                [commonclass Redirect:self.navigationController Identifier:@"GenerateCouponsViewController"];
            }else{
                [commonclass Redirect:self.navigationController Identifier:@"DetailViewController"];
            }
            storeNo = [verticalsArr[indexPath.row] valueForKey:@"store_id"];
        }else{
            if ([[verticalsArr[indexPath.row - 1] valueForKey:@"checked_in"]boolValue] == true){
                [commonclass Redirect:self.navigationController Identifier:@"GenerateCouponsViewController"];
            }else{
                [commonclass Redirect:self.navigationController Identifier:@"DetailViewController"];
            }
            storeNo = [verticalsArr[indexPath.row - 1] valueForKey:@"store_id"];
        }
    }
   
    [delegate.defaults setValue:storeNo forKey:@"store_ID"];
    [delegate.defaults synchronize];
}

- (void)tabBarController:(UITabBarController *)tabBarController
 didSelectViewController:(UIViewController *)viewController{
    self.tabBarController.tabBar.tintColor = [UIColor redColor];
}

- (IBAction)locationBtnTapped:(id)sender {
    [self.tabBarController setSelectedIndex:2];
}

- (IBAction)filterBtnTapped:(id)sender {
    [selectedcategoriesIDArr removeAllObjects];
    [selectedcategoriesArr removeAllObjects];
    [self.view bringSubviewToFront:couponDetMainView];
    couponDetMainView.hidden = false;
    [self getParentCategories];
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    if(touch.view.tag==1000){
        couponDetMainView.hidden = TRUE;
    }
}

- (IBAction)couponCloseTapped:(id)sender {
    couponDetMainView.hidden = true;
}

- (IBAction)highstreetTapped:(id)sender {
     [delegate.defaults setObject:@"High Street" forKey:@"verticalsCategory"];
    [distAwayArr removeAllObjects];
    [premiumdistAwayArr removeAllObjects];
    segTapString = @"High Street";
    temppremiumCnt = 0;
    counter = 0;
    [resultTable setContentOffset:CGPointZero animated:YES];
    seg_string = @"High Street";
    verticalset = @"High Street";
   [commonclass addlistingSlideAnimation:indicatorLine button1:highstreetBtn];
    if([[delegate.defaults valueForKey:@"route"] isEqualToString:@"Store"]){
        if([[delegate.defaults valueForKey:@"resultType"] isEqualToString:@"StoreType"]){
           
            [delegate.defaults synchronize];
            [self getDatawithStoreCategory:seg_string latitude:currentLatitude longitude:currentLongitude radius:userRadius];
        }else{
            [self getDatawithStoreCategory:seg_string latitude:currentLatitude longitude:currentLongitude radius:userRadius];
        }
    }else if([[delegate.defaults valueForKey:@"route"] isEqualToString:@"Favourites"]){
        [self getFavourites:seg_string latitude:currentLatitude longitude:currentLongitude radius:userRadius];
    }else if([[delegate.defaults valueForKey:@"resultType"] isEqualToString:@"StoreType"]){
         NSLog(@"type is... %@",[delegate.defaults valueForKey:@"resultType"]);
       // [self getFavourites:seg_string latitude:userLatitude longitude:userLongitude radius:userRadius];
    }else if([[delegate.defaults valueForKey:@"route"] isEqualToString:@"sharedStore"]){
        [self getSharedStore:seg_string latitude:currentLatitude longitude:currentLongitude radius:userRadius];
        // [self getFavourites:seg_string latitude:userLatitude longitude:userLongitude radius:userRadius];
    }else{
        [self getResponseBuckets:seg_string latitude:currentLatitude longitude:currentLongitude radius:userRadius];
    }
//    [delegate.defaults setObject:@"High Street" forKey:@"verticalsCategory"];
//    [delegate.defaults synchronize];
    //[resultTable reloadData];
}

- (IBAction)brandsTapped:(id)sender {
    [delegate.defaults setObject:@"Brands" forKey:@"verticalsCategory"];
    [distAwayArr removeAllObjects];
    [premiumdistAwayArr removeAllObjects];
    temppremiumCnt = 0;
    counter = 0;
    segTapString = @"Brands";
    [resultTable setContentOffset:CGPointZero animated:YES];
    seg_string = @"Brands";
    verticalset = @"Brands";
    NSLog(@"seg_string..%@",seg_string);
    [commonclass addlistingSlideAnimation:indicatorLine button1:brandsBtn];
    
    if([[delegate.defaults valueForKey:@"route"] isEqualToString:@"Store"]){
        if([[delegate.defaults valueForKey:@"resultType"] isEqualToString:@"StoreType"]){
            NSLog(@"type is... %@",[delegate.defaults valueForKey:@"resultType"]);
           
            [delegate.defaults synchronize];
            [self getDatawithStoreCategory:seg_string latitude:currentLatitude longitude:currentLongitude radius:userRadius];
        }else{
            [self getDatawithStoreCategory:seg_string latitude:currentLatitude longitude:currentLongitude radius:userRadius];
        }
    }else if([[delegate.defaults valueForKey:@"route"] isEqualToString:@"Favourites"]){
        [self getFavourites:seg_string latitude:currentLatitude longitude:currentLongitude radius:userRadius];
    }else if([[delegate.defaults valueForKey:@"route"] isEqualToString:@"sharedStore"]){
        [self getSharedStore:seg_string latitude:currentLatitude longitude:currentLongitude radius:userRadius];
        // [self getFavourites:seg_string latitude:userLatitude longitude:userLongitude radius:userRadius];
    }else{
        [self getResponseBuckets:seg_string latitude:currentLatitude longitude:currentLongitude radius:userRadius];
    }
//    [delegate.defaults setObject:@"Brands" forKey:@"verticalsCategory"];
//    //[delegate.defaults setValue:@"Store" forKey:@"route"];
//    [delegate.defaults synchronize];
//    [resultTable reloadData];
}

- (IBAction)designersTapped:(id)sender {
    [delegate.defaults setObject:@"Designers" forKey:@"verticalsCategory"];
    [distAwayArr removeAllObjects];
    [premiumdistAwayArr removeAllObjects];
    temppremiumCnt = 0;
    counter = 0;
    segTapString =  @"Designers";
    [resultTable setContentOffset:CGPointZero animated:YES];
    seg_string = @"Designers";
    verticalset = @"Designers";
    [commonclass addlistingSlideAnimation:indicatorLine button1:designersBtn];
    if([[delegate.defaults valueForKey:@"route"] isEqualToString:@"Store"]){
        if([[delegate.defaults valueForKey:@"resultType"] isEqualToString:@"StoreType"]){
            [delegate.defaults synchronize];
            [self getDatawithStoreCategory:seg_string latitude:currentLatitude longitude:currentLongitude radius:userRadius];
        }else{
            [self getDatawithStoreCategory:seg_string latitude:currentLatitude longitude:currentLongitude radius:userRadius];
        }
    }else if([[delegate.defaults valueForKey:@"route"] isEqualToString:@"Favourites"]){
       [self getFavourites:seg_string latitude:currentLatitude longitude:currentLongitude radius:userRadius];
    }else if([[delegate.defaults valueForKey:@"route"] isEqualToString:@"sharedStore"]){
        [self getSharedStore:seg_string latitude:currentLatitude longitude:currentLongitude radius:userRadius];
        // [self getFavourites:seg_string latitude:userLatitude longitude:userLongitude radius:userRadius];
    }else{
        [self getResponseBuckets:seg_string latitude:currentLatitude longitude:currentLongitude radius:userRadius];
    }
//    [delegate.defaults setObject:@"Designers" forKey:@"verticalsCategory"];
//    //[delegate.defaults setValue:@"Store" forKey:@"route"];
//    [delegate.defaults synchronize];
    //[resultTable reloadData];
}

- (IBAction)exhibitionsTapped:(id)sender {
    seg_string = @"Exhibitions";
    [commonclass addlistingSlideAnimation:indicatorLine button1:exhibitionsBtn];
    [resultTable reloadData];
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
    currentLatitude = place.coordinate.latitude;
    currentLongitude = place.coordinate.longitude;
    NSString *userLatitude1 = [NSString stringWithFormat:@"%f",place.coordinate.latitude];
    NSString *userLongitude1 = [NSString stringWithFormat:@"%f",place.coordinate.longitude];
    // NSString * placename = place.name;
//    [delegate.defaults setValue:placename forKey:@"loc_name"];
//    [delegate.defaults synchronize];
    [delegate.defaults setValue:userLatitude1 forKey:@"user_latitude"];
    [delegate.defaults setValue:userLongitude1 forKey:@"user_longitude"];
    [delegate.defaults setValue:@"loc" forKey:@"locupdatefrom"];
    [delegate.defaults setValue:search.text forKey:@"loc_name"];
    
    userLatitude = [[delegate.defaults valueForKey:@"user_latitude"]floatValue];
    userLongitude = [[delegate.defaults valueForKey:@"user_longitude"]floatValue];
    
    searchField.text = place.name;
    searchField.textColor = [UIColor whiteColor];
   // if([[delegate.defaults valueForKey:@"resultType"] isEqualToString:@"Category"]){
    [self getDatawithStoreCategory:seg_string latitude:currentLatitude longitude:currentLongitude radius:userRadius];
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

#pragma mark - discarded Methods
-(void)getResponse:(NSString *)type{
    if([commonclass isActiveInternet] == YES){
    NSString *messageBody = [NSString stringWithFormat:@"log_id=%@&latitude=%@&longitude=%@&radius=%@&category_id=%@&type=%@",[delegate.defaults valueForKey:@"logid"],[delegate.defaults valueForKey:@"latitude"],[delegate.defaults valueForKey:@"longitude"],[delegate.defaults valueForKey:@"radius"],[delegate.defaults valueForKey:@"category"],type];
    NSLog(@"body.. %@",messageBody);
    NSLog(@"commonclass.searchListURL.. %@",commonclass.searchListURL);
    [commonclass sendRequest:self.view mutableDta:searchData url:commonclass.searchListURL msgBody:messageBody];
    }else{
        [commonclass Redirect:self.navigationController Identifier:@"InternetDisconnectViewController"];
        //[self.view makeToast:@"Check your internet connection"];
    }
}

-(void)getStoreTypeResponse:(NSString *)type{
    seg_string = @"Verticals";
    if([commonclass isActiveInternet] == YES){
    NSString *messageBody = [NSString stringWithFormat:@"log_id=%@&latitude=%@&longitude=%@&radius=%@&type=%@",[delegate.defaults valueForKey:@"logid"],[delegate.defaults valueForKey:@"latitude"],[delegate.defaults valueForKey:@"longitude"],[delegate.defaults valueForKey:@"radius"],type];
    NSLog(@"body.. %@",messageBody);
    NSLog(@"commonclass.searchListURL.. %@",commonclass.searchListURL);
    [commonclass sendRequest:self.view mutableDta:searchData url:commonclass.searchListURL msgBody:messageBody];
    }else{
        [commonclass Redirect:self.navigationController Identifier:@"InternetDisconnectViewController"];
        //[self.view makeToast:@"Check your internet connection"];
    }
}

-(void)setupMobileVerificationPopup{
    Popupmainview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    Popupmainview.backgroundColor = [UIColor PopupBackground];
    Popupmainview.tag = 2000;
    UIView * verificationDtlssubView = [[UIView alloc]initWithFrame:CGRectMake(10, self.view.frame.size.height/4, self.view.frame.size.width - 20, self.view.frame.size.height/2.5)];
    verificationDtlssubView.backgroundColor = [UIColor whiteColor];
    verificationDtlssubView.layer.cornerRadius = 10.0f;
    
    UILabel * verificationHdr = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, verificationDtlssubView.frame.size.width, verificationDtlssubView.frame.size.height / 5)];
    
    verificationHdr.backgroundColor = [UIColor redColor];
    CAShapeLayer * maskLayer = [CAShapeLayer layer];
    maskLayer.path = [UIBezierPath bezierPathWithRoundedRect: verificationHdr.bounds byRoundingCorners: UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii: (CGSize){10.0, 10.}].CGPath;
    
    verificationHdr.layer.mask = maskLayer;
    verificationHdr.font = [UIFont fontWithName:@"Raleway-Bold" size:18.0];
    verificationHdr.textColor = [UIColor whiteColor];
    verificationHdr.textAlignment = NSTextAlignmentCenter;
    verificationHdr.text = @"Verify Your Mobile";
    [verificationDtlssubView addSubview:verificationHdr];
    
    verifyView = [[UIView alloc]initWithFrame:CGRectMake(verificationHdr.frame.origin.x + 5, verificationDtlssubView.frame.size.height / 3, verificationHdr.frame.size.width - 10, 70)];
    
    UILabel * slctBucketLbl = [[UILabel alloc]initWithFrame:CGRectMake(verificationHdr.frame.origin.x + 5, 0, verificationHdr.frame.size.width - 20, 30)];
    slctBucketLbl.text = @"Enter your Mobile number";
    slctBucketLbl.font = [UIFont fontWithName:@"Raleway-Bold" size:12.0];
    slctBucketLbl.textColor = [UIColor darkGrayColor];
    [verifyView addSubview:slctBucketLbl];
    
    mobileFld = [[UITextField alloc] initWithFrame:CGRectMake(verificationHdr.frame.origin.x + 5, (slctBucketLbl.frame.origin.y+slctBucketLbl.frame.size.height) + 5, verificationHdr.frame.size.width - 20, 30)];
    mobileFld.textColor = [UIColor darkGrayColor];
    mobileFld.placeholder = @"Mobile Number * ";
    mobileFld.keyboardType = UIKeyboardTypeEmailAddress;
    mobileFld.delegate = self;
    mobileFld.font = [UIFont fontWithName:@"Roboto-Regular" size:13.0];
    mobileFld.returnKeyType = UIReturnKeyNext;
    mobileFld.borderStyle = UITextBorderStyleRoundedRect;
    [verifyView addSubview:mobileFld];
    
    OTPView = [[UIView alloc]initWithFrame:CGRectMake(verificationHdr.frame.origin.x + 5, verificationDtlssubView.frame.size.height / 3, verificationHdr.frame.size.width - 10, 85)];
    
    UILabel * slctOtpLbl = [[UILabel alloc]initWithFrame:CGRectMake(verificationHdr.frame.origin.x + 5, 0, verificationHdr.frame.size.width - 20, 30)];
    slctOtpLbl.text = @"Enter your OTP";
    slctOtpLbl.font = [UIFont fontWithName:@"Raleway-Bold" size:12.0];
    slctOtpLbl.textColor = [UIColor darkGrayColor];
    [OTPView addSubview:slctOtpLbl];
    
    otpFld = [[UITextField alloc] initWithFrame:CGRectMake(verificationHdr.frame.origin.x + 5, (slctBucketLbl.frame.origin.y+slctBucketLbl.frame.size.height) + 5, verificationHdr.frame.size.width - 10, 30)];
    otpFld.textColor = [UIColor darkGrayColor];
    otpFld.placeholder = @"OTP * ";
    otpFld.keyboardType = UIKeyboardTypeEmailAddress;
    otpFld.delegate = self;
    otpFld.font = [UIFont fontWithName:@"Roboto-Regular" size:13.0];
    otpFld.returnKeyType = UIReturnKeyNext;
    otpFld.borderStyle = UITextBorderStyleRoundedRect;
    [OTPView addSubview:otpFld];
    
    UILabel * lbl = [[UILabel alloc]initWithFrame:CGRectMake(otpFld.frame.size.width - 165, (otpFld.frame.origin.y+otpFld.frame.size.height) + 2, 110, 15)];
    lbl.text = @"OTP not recieved ?";
    lbl.font = [UIFont fontWithName:@"Roboto-Regular" size:13.0];
    [OTPView addSubview:lbl];
    
    UIButton * resendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    resendBtn.frame = CGRectMake((lbl.frame.origin.x + lbl.frame.size.width), lbl.frame.origin.y, 65, 15);
    //resendBtn.titleLabel.textColor = [UIColor redColor];
    [resendBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [resendBtn setTitle:@"Resend" forState:UIControlStateNormal];
    resendBtn.titleLabel.font = [UIFont fontWithName:@"Roboto-Regular" size:14.0];
    [resendBtn addTarget:self action:@selector(resendOTPTapped) forControlEvents:UIControlEventTouchUpInside];
    [OTPView addSubview:resendBtn];
    
    UIButton * changebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    changebtn.frame = CGRectMake(0, verificationDtlssubView.frame.size.height - 50, verificationDtlssubView.frame.size.width/2, 50);
    changebtn.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    changebtn.layer.borderWidth = 1.0f;
    changebtn.backgroundColor = [UIColor redColor];
    [changebtn setTitle:@"CANCEL" forState:UIControlStateNormal];
    [changebtn addTarget:self action:@selector(cancelSubscribeTapped) forControlEvents:UIControlEventTouchUpInside];
    [verificationDtlssubView addSubview:changebtn];
    
    UIButton * proceedbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    proceedbtn.frame = CGRectMake((changebtn.frame.origin.x + changebtn.frame.size.width), verificationDtlssubView.frame.size.height - 50, verificationDtlssubView.frame.size.width/2, 50);
    proceedbtn.backgroundColor = [UIColor redColor];
    proceedbtn.layer.borderWidth = 1.0f;
    proceedbtn.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    [proceedbtn setTitle:@"VERIFY" forState:UIControlStateNormal];
    [proceedbtn addTarget:self action:@selector(SubscribeTapped) forControlEvents:UIControlEventTouchUpInside];
    [verificationDtlssubView addSubview:proceedbtn];
    
    [verificationDtlssubView addSubview:OTPView];
    [verificationDtlssubView addSubview:verifyView];
    [Popupmainview addSubview:verificationDtlssubView];
    [self.view addSubview:Popupmainview];
}

-(void)resendOTPTapped{
    [self resendOTP];
}


-(void)resendOTP {
    NSString *messageBody = [NSString stringWithFormat:@"mobile=%@",[delegate.defaults valueForKey:@"mobile"]];
    [commonclass sendRequest:self.view mutableDta:extraData url:commonclass.generateOTPURL msgBody:messageBody];
}

-(void)cancelSubscribeTapped{
    Popupmainview.hidden = true;
}

-(void)ValidateOTP{
    [UIView animateWithDuration:0.7f
                     animations:^ {
                         CGRect frame = OTPView.frame;
                         frame.origin.x = 0;
                         OTPView.frame = frame;
                         OTPView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
                         verifyView.hidden = true;
                         OTPView.hidden = false;
                     }
                     completion:^(BOOL finished) {
                         [UIView beginAnimations:nil context:nil];
                         [UIView setAnimationDuration:5.3];
                         [UIView commitAnimations];
                     }];
    }

-(void)GetOTP{
    seg_string = @"UpdateOTP";
    if([commonclass isActiveInternet] == YES){
    NSString *messageBody = [NSString stringWithFormat:@"mobile=%@&otp=%@",[delegate.defaults valueForKey:@"mobile"],otpFld.text];
    [commonclass sendRequest:self.view mutableDta:extraData url:commonclass.otpURL msgBody:messageBody];
    }else{
        [commonclass Redirect:self.navigationController Identifier:@"InternetDisconnectViewController"];
        //[self.view makeToast:@"Check your internet connection"];
    }
}

-(void)SubscribeTapped{
 // NSString * mobilenumber = [delegate.defaults valueForKey:@"mobile"];
    if([[delegate.defaults valueForKey:@"updateMobile"]boolValue] == false){
        [self updateMobile];
    }else{
        [self GetOTP];
    }
}

-(void)viewDidDisappear:(BOOL)animated{
    [contentView removeFromSuperview];
    [stack removeFromSuperview];
    [flyoutView removeFromSuperview];
//    [delegate.defaults setObject:@"0" forKey:@"verticalsCategory"];
//    [delegate.defaults synchronize];
    
}

- (IBAction)RatingsChanged:(id)sender {
    float increment = 1.0;
    float newValue = RatingsSlider.value /increment;
    RatingsSlider.value = floor(newValue) * increment;
    ratingsVal = RatingsSlider.value;
    ratingsMaxLbl.text = [NSString stringWithFormat:@"%.0f/5",RatingsSlider.value];
}

- (IBAction)DistanceChanged:(id)sender {
    float increment = 0.5;
    float newValue = DistanceSlider.value /increment;
    DistanceSlider.value = floor(newValue) * increment;
    distanceval = DistanceSlider.value;
    distanceMaxLbl.text = [NSString stringWithFormat:@"%.1f/5.0 Km",DistanceSlider.value];
}

- (IBAction)DiscountChanged:(id)sender {
    float increment = 1.0;
    float newValue = DiscountSlider.value /increment;
    DiscountSlider.value = floor(newValue) * increment;
    discountval = DiscountSlider.value;
    discountMaxLbl.text = [NSString stringWithFormat:@"%.1f/100 %%",DiscountSlider.value];
}

- (IBAction)filterSubmitTapped:(id)sender {
    NSString * filterCategoriesIDs = [selectedcategoriesIDArr componentsJoinedByString:@","];
    NSLog(@"filterCategoriesIDs %@",filterCategoriesIDs);
   //seg_string = @"High Street";
    couponDetMainView.hidden = TRUE;
    NSString *messageBody;
    if(filterCategoriesIDs.length == 0){
        messageBody = [NSString stringWithFormat:@"log_id=%@&latitude=%f&longitude=%f&current_latitude=%f&current_longitude=%f&radius=%f&category_id=%@&type=%@&rating_min=0&rating_max=%f&discount_min=0&discount_max=%f",[delegate.defaults valueForKey:@"logid"],userLatitude,userLongitude,currentLatitude,currentLongitude,distanceval,[delegate.defaults valueForKey:@"category"],segTapString,ratingsVal,distanceval];
    }else{
        messageBody = [NSString stringWithFormat:@"log_id=%@&latitude=%f&longitude=%f&current_latitude=%f&current_longitude=%f&radius=%f&category_id=%@&type=%@&rating_min=0&rating_max=%f&discount_min=0&discount_max=%f",[delegate.defaults valueForKey:@"logid"],userLatitude,userLongitude,currentLatitude,currentLongitude,distanceval,filterCategoriesIDs,segTapString,ratingsVal,discountval];
    }
    if([commonclass isActiveInternet] == YES){
    NSLog(@"body.. %@",messageBody);
    NSLog(@"commonclass.searchListURL.. %@",commonclass.searchListURL);
    [commonclass sendRequest:self.view mutableDta:searchData url:commonclass.searchListURL msgBody:messageBody];
    }else{
        [commonclass Redirect:self.navigationController Identifier:@"InternetDisconnectViewController"];
        //[self.view makeToast:@"Check your internet connection"];
    }
}

- (void)keyboardDidShow:(NSNotification *)notification
{
//       if(iskeyboardPresent == YES && iskeyboardAppeared == NO){
//    iskeyboardAppeared = YES;
//    LoginScroll.contentSize = CGSizeMake(LoginScroll.frame.size.width, LoginScroll.frame.size.height + 200);
//    //    }
//    LoginScroll.scrollEnabled = YES;
}

-(void)keyboardDidHide:(NSNotification *)notification
{
//     if(iskeyboardPresent == YES && iskeyboardAppeared == NO){
//    iskeyboardAppeared = NO;
//    LoginScroll.contentSize = CGSizeMake(LoginScroll.frame.size.width, LoginScroll.frame.size.height);
//    //    }
//    LoginScroll.scrollEnabled = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
