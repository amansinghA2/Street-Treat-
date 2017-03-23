//
//  DashboardViewController.m
//  Street_Treat
//
//  Created by Kamlesh Dubey on 6/6/16.
//  Copyright (c) 2016 Digillence Rolson. All rights reserved.
//

#import "DashboardViewController.h"
#import "StaticDataViewController.h"

@interface DashboardViewController (){
    UIView *contentView;
    UPStackMenu *stack;
}


@end

@implementation DashboardViewController
@synthesize DashboardScroll,promoArr,usrNameLbl,PromoPgCtrl,PromoScroll,promoBannerDet_view,promoBannerDetclose,dasboardIndicator,dashboardArr;
@synthesize menBtn,womenBtn,kidsBtn,categoryView,tempview;
@synthesize couponScroll,ExhibitionScroll,exhibiDtlLbl,exhibitionArr;
@synthesize brandView,highStrBtn,brandedBtn,designerBtn,checkinBtn;
@synthesize collectionLbl,container,setType;
int btnwt,btnht;

@synthesize couponDetMainView,couponDtlSubview,couponValLbl,couponCloseBtn,couponDescLbl,couponSubmitBtn;

-(void)viewDidAppear:(BOOL)animated{

    [constant setNavigationController:self.navigationController tabBarController:self.tabBarController viewController:self];
    [self setUpstackMenu];
    for (UIView *view in couponScroll.subviews)  {
        if ([view isKindOfClass:[UIView class]]) {
            [view removeFromSuperview];
        }
    }
    
    [delegate.defaults setObject:@"" forKey:@"isFromBucket"];
    [delegate.defaults setValue:@"" forKey:@"navigateFromReport"];
    [delegate.defaults setValue:@"" forKey:@"navigateFromSubmitReview"];
    
    [self showLocName];
    
    //  currentLatitude = [[delegate.defaults valueForKey:@"user_latitude"] floatValue];
    //  currentLongitude = [[delegate.defaults valueForKey:@"user_longitude"] floatValue];
    userRadius = [[delegate.defaults valueForKey:@"radius"] floatValue];
    
    [delegate.defaults setObject:@"DashboardViewController" forKey:@"internetdisconnect"];
    [delegate.defaults setValue:@"notShared" forKey:@"shareStore"];
    self.rootNav = (CCKFNavDrawer *)self.navigationController;
    [self.rootNav setCCKFNavDrawerDelegate:self];
    self.tabBarController.tabBar.tintColor = [UIColor redColor];
    [self getBanners];
    
    [delegate.defaults synchronize];
    
//    if([[NSUserDefaults standardUserDefaults] boolForKey:@"navigatefromprofiletohelp"]==YES){
//        for (UIView *view in couponScroll.subviews)  {
//            if ([view isKindOfClass:[UIView class]]) {
//                [view removeFromSuperview];
//            }
//        }
//        [delegate.defaults setObject:@"DashboardViewController" forKey:@"internetdisconnect"];
//        [delegate.defaults setValue:@"notShared" forKey:@"shareStore"];
//        self.rootNav = (CCKFNavDrawer *)self.navigationController;
//        [self.rootNav setCCKFNavDrawerDelegate:self];
//        self.tabBarController.tabBar.tintColor = [UIColor redColor];
//        currentLatitude = [[delegate.defaults valueForKey:@"latitude"] floatValue];
//        currentLongitude = [[delegate.defaults valueForKey:@"longitude"] floatValue];
//        [self getBanners];
//        // [self CreatePromotionalWebview];
//        //[self getNearbyDeals];
//  
//        // [self setupExhibitions:promoArr];
//        
//        //    NSString *userLatitude1 = [delegate.defaults valueForKey:@"user_latitude"];
//        //    NSString *userLongitude1 = [delegate.defaults valueForKey:@"user_longitude"];
//        //
//        //    [delegate.defaults setValue:userLatitude1 forKey:@"user_latitude"];
//        //    [delegate.defaults setValue:userLongitude1 forKey:@"user_longitude"];
//        
//        //        float duration = 0.5;
//        //        timer = [NSTimer scheduledTimerWithTimeInterval:duration target:self selector:@selector(showLocName) userInfo:nil repeats: YES];
//        [self showLocName];
//        [delegate.defaults synchronize];
//    }else{
//        
//    }
//    userLatitude = [[delegate.defaults valueForKey:@"latitude"] floatValue];
//    userLongitude = [[delegate.defaults valueForKey:@"longitude"] floatValue];
    
//    txfSearchField.text = [delegate.defaults valueForKey:@"loc_name"];
//    txfSearchField.textColor = [UIColor whiteColor];
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
        txfSearchField.text = [delegate.defaults valueForKey:@"myloc_name"];
        txfSearchField.textColor = [UIColor whiteColor];
        currentLatitude = [[delegate.defaults valueForKey:@"latitude"] floatValue];
        currentLongitude = [[delegate.defaults valueForKey:@"longitude"] floatValue];
        [timer invalidate];
    }else{
        txfSearchField.text = [delegate.defaults valueForKey:@"loc_name"];
        currentLatitude = [[delegate.defaults valueForKey:@"user_latitude"] floatValue];
        currentLongitude = [[delegate.defaults valueForKey:@"user_longitude"] floatValue];
        txfSearchField.textColor = [UIColor whiteColor];
//        [self getNearbyDealsWithLatitude:[[delegate.defaults valueForKey:@"user_latitude"]floatValue] longitude:[[delegate.defaults valueForKey:@"user_longitude"]floatValue] radius:userRadius];
        [timer invalidate];
    }
    //NSLog(@"loc.. %@",loc);
}

-(void)viewWillAppear:(BOOL)animated{
    [self CurrentLocationIdentifier];
    
}

-(void)getParentCategories{
    if([constant isActiveInternet] == YES){
        requestType = @"GetParents";
        NSString *messageBody = [NSString stringWithFormat:@"parent_id=%@",@"1"];
        NSLog(@"body.. %@",messageBody);
        NSLog(@"commonclass.LoginURL.. %@",constant.getParentCategoriesURL);
        [constant sendRequest:self.view mutableDta:parentsData url:constant.getParentCategoriesURL msgBody:nil];
    }else{
        [constant Redirect:self.navigationController Identifier:@"InternetDisconnectViewController"];
        //[self.view makeToast:@"Check your internet connection"];
    }
}

-(void)getBanners{
    
    requestType = @"GetBanners";
    NSString *messageBody1 = [NSString stringWithFormat:@"log_id=%@&latitude=%f&longitude=%f",[delegate.defaults valueForKey:@"logid"] ,currentLatitude ,currentLongitude];
    NSLog(@"mesage body %@", messageBody1);
    [constant sendRequest:self.view mutableDta:dealsdata url:constant.promotionalBannerUrl msgBody:messageBody1];
    
}

-(void)getNearbyDealsWithLatitude:(float)storeLatitude longitude:(float)storeLongitude radius:(float)storeradius{
    if([constant isActiveInternet] == YES){
        requestType = @"GetDeals";
//            NSString *messageBody = [NSString stringWithFormat:@"log_id=%@&device_os=%@&device_token=%@",[delegate.defaults valueForKey:@"logid"],@"ios",[delegate.defaults valueForKey:@"deviceToken"]];
//            NSLog(@"messageBody.. %@",messageBody);
//        [constant sendRequest:self.view mutableDta:dealsdata url:constant.updateDeviceToken msgBody:messageBody];
        
        NSString *messageBody1 = [NSString stringWithFormat:@"log_id=%@&latitude=%f&longitude=%f&radius=%f&current_latitude=%@&current_longitude=%@&limitstart=0&limit=5&order_by=a.exclusive_discount&order_dir=DESC",[delegate.defaults valueForKey:@"logid"],storeLatitude,storeLongitude,storeradius,[delegate.defaults valueForKey:@"latitude"],[delegate.defaults valueForKey:@"longitude"]];
        NSLog(@"messageBody.. %@",messageBody1);
        NSLog(@"constant.searchListURL.. %@",constant.searchListURL);
        [constant sendRequest:self.view mutableDta:dealsdata url:constant.searchListURL msgBody:messageBody1];
    }else{
        //[self CreateNetworkEnabler];
        [constant Redirect:self.navigationController Identifier:@"InternetDisconnectViewController"];
        //[self.view makeToast:@"Check your internet connection"];
    }
}

-(void)getBuckets{
   // limit,limitstart
    if([constant isActiveInternet] == YES){
        requestType = @"buckets";
        NSString *messageBody = [NSString stringWithFormat:@"log_id=%@&orderdesc=ASC&orderby=ordering",[delegate.defaults valueForKey:@"logid"]];
        NSLog(@"body.. %@",messageBody);
        NSLog(@"commonclass.bucketsListURL.. %@",constant.bucketsListURL);
        [constant sendRequest:self.view mutableDta:parentsData url:constant.bucketsListURL msgBody:messageBody];
    }else{
        [constant Redirect:self.navigationController Identifier:@"InternetDisconnectViewController"];
       //[self.view makeToast:@"Check your internet connection"];
    }
}



- (void)sendResponse:(Common *)response data:(NSMutableArray*)data indicator:(UIActivityIndicatorView *)indicator{
    NSLog(@"%@",data);
    dispatch_sync(dispatch_get_main_queue(), ^{
        if([requestType isEqualToString:@"GetBanners"]){
            if([[data valueForKey:@"status"]intValue] == 1){
                promoArr = [data valueForKey:@"items"];
                [self setupPromotionalBanners:promoArr];
               // promoArr = [data valueForKey:@"items"];
            }
      //      if([[NSUserDefaults standardUserDefaults] boolForKey:@"navigatefromprofiletohelp"]==YES){
               [self getNearbyDealsWithLatitude:currentLatitude longitude:currentLongitude radius:[[delegate.defaults valueForKey:@"radius"] floatValue]];
                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"navigatefromprofiletohelp"];
                [[NSUserDefaults standardUserDefaults] synchronize];
//            }else{
//              [self getNearbyDealsWithLatitude:[[delegate.defaults valueForKey:@"user_latitude"]floatValue] longitude:[[delegate.defaults valueForKey:@"user_longitude"]floatValue] radius:[[delegate.defaults valueForKey:@"radius"] floatValue]];
//            }
            
        }else if([requestType isEqualToString:@"GetDeals"]){
            if([[data valueForKey:@"status"]intValue] == 1){
                if ([data valueForKey:@"items"] == (id)[NSNull null]) {
                    [self.view makeToast:@""];
                }else{
                dealsArr = [data valueForKey:@"items"];
                [self setupCoupons:dealsArr];
                _bestDlsLbl.hidden = false;
                couponScroll.hidden = false;
                _moreDealsBtn.hidden = false;
                [constant changeFrameforDashboardWRT:couponScroll ofview:brandView];
                [constant changeFrameforDashboardWRT:brandView ofview:_CheckinDtlsView];
                [constant changeFrameforDashboardWRT:_CheckinDtlsView ofview:_CollectionsLblHdr];
                [constant changeFrameforDashboardWRT:_CheckinDtlsView ofview:_collectionMoreBtn];
                [self getBuckets];
                }
            }else if([[data valueForKey:@"status"]intValue] == -1){
                [constant logoutFunction];
            }else{
                _bestDlsLbl.hidden = true;
                couponScroll.hidden = true;
                _moreDealsBtn.hidden = true;
                [constant changeFrameforDashboardWRT:categoryView ofview:brandView];
                [constant changeFrameforDashboardWRT:brandView ofview:_CheckinDtlsView];
                [constant changeFrameforDashboardWRT:_CheckinDtlsView ofview:_CollectionsLblHdr];
                [constant changeFrameforDashboardWRT:_CheckinDtlsView ofview:_collectionMoreBtn];
                [self getBuckets];
                //[self.view makeToast:@"Some problem occured"];
            }
         }else if([requestType isEqualToString:@"buckets"]){
             [bucketsArr removeAllObjects];
             if([[data valueForKey:@"status"]intValue] == 1){
                 bucketsArr = [data valueForKey:@"items"];
                 [self setupCollections:bucketsArr];
                 [self getParentCategories];
             }else if([[data valueForKey:@"status"]intValue] == -1){
                 [constant logoutFunction];
             }else{
                // [self.view makeToast:@"Some problem occured"];
                 [self getParentCategories];
             }
         }
       else if([requestType isEqualToString:@"GetParents"]){
           
            if([[data valueForKey:@"status"]intValue] == 1){
                NSMutableArray *mensArray = [[NSMutableArray alloc]init];
                NSMutableArray *womensArray = [[NSMutableArray alloc]init];
                NSMutableArray *childrenArray = [[NSMutableArray alloc]init];
                
                delegate.itemsArray = [data valueForKey:@"items"];
                for(int k=0;k<[[data valueForKey:@"items"] count];k++){
                    if([[[data valueForKey:@"items"][k] valueForKey:@"title"] isEqualToString:@"Mens"]){
                        NSString * catID = [NSString stringWithFormat:@"%@",[[data valueForKey:@"items"][k] valueForKey:@"id"]];
                        [delegate.defaults setValue:catID forKey:@"MensCategory"];
                       
                    }else if([[[data valueForKey:@"items"][k] valueForKey:@"title"] isEqualToString:@"Womens"]){
                        NSString * catID = [NSString stringWithFormat:@"%@",[[data valueForKey:@"items"][k] valueForKey:@"id"]];
                        [delegate.defaults setValue:catID forKey:@"WomensCategory"];
                    }else if([[[data valueForKey:@"items"][k] valueForKey:@"title"] isEqualToString:@"Children"]){
                        NSString * catID = [NSString stringWithFormat:@"%@",[[data valueForKey:@"items"][k] valueForKey:@"id"]];
                        [delegate.defaults setValue:catID forKey:@"ChildrenCategory"];
                    }
                    
                    if ([[[data valueForKey:@"items"][k] valueForKey:@"parent_id"] isEqualToString: @"9"]){
                        [mensArray addObject:[[data valueForKey:@"items"][k] valueForKey:@"title"]];
                        [delegate.defaults setObject:mensArray forKey:@"mensArray"];
                    }else if([[[data valueForKey:@"items"][k] valueForKey:@"parent_id"] isEqualToString: @"16"]){
                        [womensArray addObject:[[data valueForKey:@"items"][k] valueForKey:@"title"]];
                        [delegate.defaults setObject:womensArray forKey:@"womensArray"];
                    }else if([[[data valueForKey:@"items"][k] valueForKey:@"parent_id"] isEqualToString: @"25"]){
                        [childrenArray addObject:[[data valueForKey:@"items"][k] valueForKey:@"title"]];
                        [delegate.defaults setObject:childrenArray forKey:@"childrenArray"];
                    }
                }
                [delegate.defaults synchronize];
            }else if([[data valueForKey:@"status"]intValue] == -1){
                [constant logoutFunction];
            }else{
               // [self.view makeToast:@"Some problem occured"];
            }
        }
       /*else if([requestType isEqualToString:@"Dashboard"]){
            if([[data valueForKey:@"status"]intValue] == 1){
                 dashboardArr = data;
                //[self setupDashboard:data];
            }else{
                [self.view makeToast:@"Some problem occured"];
            }
        }*/
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        [indicator stopAnimating];
     });
}

-(void)setupDashboard:(NSMutableArray*)data{
    [self setupPromotionalBanners:data];
    [self setupCoupons:data];
    [self setupExhibitions:data];
    [self setupCollections:data];
    
}

-(void)setupPromotionalBanners:(NSMutableArray*)data{
  //From Service
    /* i = 0;
    promocnt = [[[data valueForKey:@"items"] valueForKey:@"PromotionalBanner"] count];
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(timerCalled) userInfo:nil repeats:YES];
    PromoScroll.contentSize = CGSizeMake(PromoScroll.frame.size.width * promocnt, PromoScroll.frame.size.height);
    for (int j = 0; j < promocnt; j++) {
        CGRect frame;
        frame.origin.x = PromoScroll.frame.size.width * j;
        frame.origin.y = 0;
        frame.size = PromoScroll.frame.size;
        UIImageView* imgView = [[UIImageView alloc] init];
        [imgView setImageWithURL:[NSURL URLWithString:[[[data valueForKey:@"items"] valueForKey:@"PromotionalBanner"][j] valueForKey:@"media_url"]] placeholderImage:[UIImage imageNamed:@"splash_iPhone.png"] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [promoArr addObject:[[[data valueForKey:@"items"] valueForKey:@"PromotionalBanner"][j] valueForKey:@"external_link"]];
        imgView.frame = frame;
        imgView.tag = j;
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Pro_BannerTapped:)];
        tapGestureRecognizer.numberOfTapsRequired = 1;
        [imgView addGestureRecognizer:tapGestureRecognizer];
        imgView.userInteractionEnabled = YES;
        
        [PromoScroll addSubview:imgView];
        PromoPgCtrl.currentPage = 0;
        PromoPgCtrl.numberOfPages = promocnt;
    }*/
    //End
    
    //Static Images
    PromoScroll.contentSize = CGSizeMake(PromoScroll.frame.size.width * promoArr.count, PromoScroll.frame.size.height);
    for (int j = 0; j < promoArr.count; j++) {
        CGRect frame;
        frame.origin.x = PromoScroll.frame.size.width * j;
        frame.origin.y = 0;
        frame.size = PromoScroll.frame.size;
        UIImageView* imgView = [[UIImageView alloc] init];
//        imgView.image = [promoArr objectAtIndex:j];
        imgView.frame = frame;
        imgView.tag = j;
        [self CreatePromotionalWebview:[data[j] valueForKey:@"url"]];
        NSString *imglink = [NSString stringWithFormat:@"%@/%@",constant.siteURL,[data[j] valueForKey:@"image"]];
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Pro_BannerTapped:)];
        tapGestureRecognizer.numberOfTapsRequired = 1;
        [imgView addGestureRecognizer:tapGestureRecognizer];
        imgView.userInteractionEnabled = YES;
        imgView.tag = j;
        [imgView setImageWithURL:[NSURL URLWithString:imglink] placeholderImage:[UIImage imageNamed:@""] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        
        [PromoScroll addSubview:imgView];
    }
    
    PromoPgCtrl.currentPage = 0;
    PromoPgCtrl.numberOfPages = promoArr.count;
    [DashboardScroll bringSubviewToFront:usrNameLbl];
    [DashboardScroll bringSubviewToFront:PromoPgCtrl];
    //end
}

-(void)CreatePromotionalWebview:(NSString *)urlString{
    promoBannerDet_view = [[UIView alloc]initWithFrame:CGRectMake(5, 50, self.view.frame.size.width-10, self.view.frame.size.height-55)];
    [promoBannerDet_view setBackgroundColor:[UIColor darkGrayColor]];
    promoDtlWebview = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, promoBannerDet_view.frame.size.width, promoBannerDet_view.frame.size.height)];
    promoDtlWebview.layer.cornerRadius = 5.0f;
    promoDtlWebview.layer.masksToBounds = YES;
    promoDtlWebview.delegate=self;
    [promoDtlWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",urlString]]]];
    [promoBannerDet_view addSubview:promoDtlWebview];
    promoBannerDet_view.layer.cornerRadius = 5.0f;
    promoBannerDetclose = [UIButton buttonWithType:UIButtonTypeCustom];
    [promoBannerDetclose setBackgroundImage:[UIImage imageNamed:@"close-button.png"] forState:UIControlStateNormal];
    promoBannerDetclose.frame = CGRectMake(promoBannerDet_view.frame.size.width - 35, 0, 30, 30);
    [promoBannerDetclose addTarget:self action:@selector(Pro_DtlDone) forControlEvents:UIControlEventTouchUpInside];
    [promoBannerDet_view addSubview:promoBannerDetclose];
    [self.view bringSubviewToFront:promoBannerDet_view];
    
    [UIView animateWithDuration:0.3/1.5 animations:^{
        promoBannerDet_view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3/2 animations:^{
            promoBannerDet_view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.5, 0.5);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3/2 animations:^{
                promoBannerDet_view.transform = CGAffineTransformIdentity;
                [self.view addSubview:promoBannerDet_view];
            }];
        }];
    }];
    
    promoBannerDet_view.hidden = true;
}


//if (promotiondata.external_link == 0) {
//    if (promotiondata.checked_in) {
//        if (promotiondata.start_time == null && promotiondata.end_time == null) {
//            Toast.makeText(context, "Seems store is closed, please visit later", Toast.LENGTH_LONG).show();
//        } else {
//            if (Constant.Getdistanceinmeters(promotiondata.distance_in_kms)) {
//                Constant.store_id = promotiondata.store_id;
//                fragmentClick.onClick(CheckedInFragment.newInstance());
//            } else {
//                Constant.store_id = promotiondata.store_id;
//                fragmentClick.onClick(StoreDeatailFragment.newInstance());
//            }
//        }
//    } else if (!promotiondata.checked_in && promotiondata.can_review) {
//        Constant.store_id = promotiondata.store_id;
//        fragmentClick.onClick(StoreDeatailFragment.newInstance());
//    } else if (!promotiondata.checked_in && !promotiondata.can_review) {
//        Constant.store_id = promotiondata.store_id;
//        fragmentClick.onClick(StoreDeatailFragment.newInstance());
//    }
//} else if (promotiondata.external_link == 1) {
//    dialogWeb(promotiondata.url);
//    
//} else if (promotiondata.external_link == 2) {
//    
//}

-(void)Pro_BannerTapped:(UIGestureRecognizer *)sender{
    
    if([[[promoArr[sender.view.tag] valueForKey:@"external_link"]stringValue] isEqualToString:@"0"]){
        
        if ([[[promoArr[sender.view.tag] valueForKey:@"checked_in"]stringValue] isEqualToString:@"1"]) {
            if ([promoArr[sender.view.tag] valueForKey:@"start_time"] == [NSNull null] && [promoArr[sender.view.tag] valueForKey:@"end_time"] == [NSNull null]) {
                [self.view makeToast:@"Seems store is closed, please visit later"];
            }else{
                
            }
        }else if([[[promoArr[sender.view.tag] valueForKey:@"checked_in"]stringValue] isEqualToString:@"0"] &&  [[[promoArr[sender.view.tag] valueForKey:@"can_review"]stringValue] isEqualToString:@"1"]){
            [delegate.defaults setInteger:[[promoArr[sender.view.tag] valueForKey:@"store_id"]intValue] forKey:@"store_ID"];
            [constant Redirect:self.navigationController Identifier:@"DetailViewController"];
        }else if([[[promoArr[sender.view.tag] valueForKey:@"checked_in"]stringValue] isEqualToString:@"0"] &&  [[[promoArr[sender.view.tag] valueForKey:@"can_review"]stringValue] isEqualToString:@"0"]) {
            [delegate.defaults setInteger:[[promoArr[sender.view.tag] valueForKey:@"store_id"]intValue] forKey:@"store_ID"];
            [constant Redirect:self.navigationController Identifier:@"DetailViewController"];
        }
    }else if([[[promoArr[sender.view.tag] valueForKey:@"external_link"]stringValue] isEqualToString:@"1"]){
        promoBannerDet_view.hidden = false;
    }else{
        
    }
    
    [delegate.defaults synchronize];
}

-(void)webViewDidStartLoad:(UIWebView *)webView{
    dasboardIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    dasboardIndicator.frame = CGRectMake(0.0, 0.0, 40.0, 40.0);
    dasboardIndicator.center = promoDtlWebview.center;
    [dasboardIndicator startAnimating];
    [promoDtlWebview addSubview:dasboardIndicator];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [dasboardIndicator stopAnimating];
}

-(void)Pro_DtlDone{
    promoBannerDet_view.hidden = true;
   // [promoBannerDet_view removeFromSuperview];
    //[couponDet_view removeFromSuperview];
}

//- (void)resetAll:(id)sender
//{
//    for (UIView *view in self.subviews) {
//        if ([view isKindOfClass:[StatusView class]]) {
//            [view removeFromSuperview];
//        }
//    }
//}

-(void)setupCoupons:(NSMutableArray*)data{
   btnwt = 85;
    NSLog(@"data.. %@",data);
    long int cpncnt = data.count;
     couponScroll.contentSize = CGSizeMake(btnwt * cpncnt, couponScroll.frame.size.height);
    
    for (int j = 0; j < cpncnt; j++) {
        cpnview = [[UIView alloc]initWithFrame:CGRectMake(85 * j, 0, 80,couponScroll.frame.size.height)];
        cpnview.tag = j;
        cpnview.layer.borderWidth = 1.0f;
        cpnview.layer.borderColor = [[UIColor View_Border] CGColor];
        cpnview.layer.backgroundColor = [[UIColor coupon_back]CGColor];
        cpnview.layer.cornerRadius = 5.0f;
        
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(couponTapped:)];
        tapGestureRecognizer.numberOfTapsRequired = 1;
        [cpnview addGestureRecognizer:tapGestureRecognizer];
        cpnview.userInteractionEnabled = YES;
        
        UILabel * disclabel = [[UILabel alloc]initWithFrame:CGRectMake(1, 2, 75, 50)];
        [disclabel setFont:[UIFont fontWithName:@"Roboto-Bold" size:16.0f]];
        //disclabel.backgroundColor = [UIColor yellowColor];
        disclabel.textColor = [UIColor TextColor_TxtFld];
        disclabel.numberOfLines = 0;
        disclabel.lineBreakMode = NSLineBreakByWordWrapping;
        disclabel.textAlignment = NSTextAlignmentCenter;
        disclabel.text = [NSString stringWithFormat:@"%@%% ST Offer",[dealsArr[j] valueForKey:@"exclusive_discount"]];
        [cpnview addSubview:disclabel];
        
        UILabel * linelabel = [[UILabel alloc]initWithFrame:CGRectMake(5, (disclabel.frame.origin.y + disclabel.frame.size.height) + 1, 70, 1)];
        linelabel.backgroundColor = [UIColor View_Border];
        [cpnview addSubview:linelabel];
        
        UILabel * typlabel = [[UILabel alloc]initWithFrame:CGRectMake(2, (linelabel.frame.origin.y + linelabel.frame.size.height)-1, cpnview.frame.size.width - 5, 30)];
        [typlabel setFont:[UIFont fontWithName:@"Roboto-Regular" size:9]];
        typlabel.textAlignment = NSTextAlignmentCenter;
         typlabel.numberOfLines = 0;
        typlabel.text = [NSString stringWithFormat:@"%@",[dealsArr[j] valueForKey:@"categories"]];
        typlabel.textColor = [UIColor darkGrayColor];
        [cpnview addSubview:typlabel];
        [couponScroll addSubview:cpnview];
    }
    
  /*  btnwt = 85;
    NSArray *cpntypArr = [[NSArray alloc]initWithObjects:@"Mens Shirts",@"Women Shirts",@"Kids Shirts",@"Loafers",@"Formals",nil];
    couponScroll.contentSize = CGSizeMake(btnwt * _dealArr.count, couponScroll.frame.size.height);
    
    for (int j = 0; j < _dealArr.count; j++) {
        cpnview = [[UIView alloc]initWithFrame:CGRectMake(85 * j, 0, 80,couponScroll.frame.size.height)];
        cpnview.tag = j;
        cpnview.layer.borderWidth = 1.0f;
        cpnview.layer.borderColor = [[UIColor View_Border] CGColor];
        cpnview.layer.backgroundColor = [[UIColor coupon_back]CGColor];
        cpnview.layer.cornerRadius = 5.0f;
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(couponTapped:)];
        tapGestureRecognizer.numberOfTapsRequired = 1;
        [cpnview addGestureRecognizer:tapGestureRecognizer];
        cpnview.userInteractionEnabled = YES;
        
        UILabel * disclabel = [[UILabel alloc]initWithFrame:CGRectMake(2, 8, 80, 50)];
        [disclabel setFont:[UIFont fontWithName:@"Roboto-Bold" size:15]];
        disclabel.numberOfLines = 0;
        disclabel.textColor = [UIColor TextColor_TxtFld];
        disclabel.textAlignment = NSTextAlignmentCenter;
        disclabel.text = [NSString stringWithFormat:@"%@",[_dealArr objectAtIndex:j]];
        [cpnview addSubview:disclabel];
        
        UILabel * linelabel = [[UILabel alloc]initWithFrame:CGRectMake(5, (disclabel.frame.origin.y + disclabel.frame.size.height), 70, 1)];
        linelabel.backgroundColor = [UIColor View_Border];
        [cpnview addSubview:linelabel];
        
        UILabel * typlabel = [[UILabel alloc]initWithFrame:CGRectMake(2, (linelabel.frame.origin.y + linelabel.frame.size.height), cpnview.frame.size.width, 20)];
        [typlabel setFont:[UIFont fontWithName:@"Roboto-Regular" size:10]];
        typlabel.textAlignment = NSTextAlignmentCenter;
        typlabel.text = [NSString stringWithFormat:@"%@",[cpntypArr objectAtIndex:j]];
        typlabel.textColor = [UIColor darkGrayColor];
        [cpnview addSubview:typlabel];
        
        [couponScroll addSubview:cpnview];
    }*/
}

-(void)couponTapped:(UIGestureRecognizer *)sender{
    [self.view bringSubviewToFront:couponDetMainView];
    couponDetMainView.hidden=false;
    dealno = sender.view.tag;
    cpnstoreID = [dealsArr[sender.view.tag] valueForKey:@"store_id"];
    [delegate.defaults setValue:cpnstoreID forKey:@"store_ID"];
    [delegate.defaults synchronize];
    couponDtlSubview.layer.cornerRadius = 5.0f;
    couponValLbl.text = [NSString stringWithFormat:@"%@%% ST Offer",[dealsArr[sender.view.tag] valueForKey:@"exclusive_discount"]];
    _cpnStoreNameLbl.text = [NSString stringWithFormat:@"Store : %@",[dealsArr[sender.view.tag] valueForKey:@"store_name"]];
    _cpnStoreCatLbl.text = [NSString stringWithFormat:@"Categories : (%@)",[dealsArr[sender.view.tag] valueForKey:@"categories"]];
    _cpnStoreAddLbl.text = [NSString stringWithFormat:@"Address : %@, %@",[dealsArr[sender.view.tag] valueForKey:@"address_1"],[dealsArr[sender.view.tag] valueForKey:@"address_2"]];
//    couponDescLbl.text = [NSString stringWithFormat:@"%@",[dealsArr valueForKey:@"long_name"][sender.view.tag]];
}

- (IBAction)couponCloseTapped:(id)sender {
    couponDetMainView.hidden = true;
}

-(void)setupExhibitions:(NSMutableArray*)data{
   /* long int exhibitioncnt = [[[data valueForKey:@"items"] valueForKey:@"Exhibitions"] count];
    ExhibitionScroll.contentSize = CGSizeMake(ExhibitionScroll.frame.size.width * exhibitioncnt, ExhibitionScroll.frame.size.height);
    for (int j = 0; j < exhibitioncnt; j++) {
        CGRect frame;
        frame.origin.x = ExhibitionScroll.frame.size.width * j;
        frame.origin.y = 0;
        frame.size = ExhibitionScroll.frame.size;
        UIImageView* imgView = [[UIImageView alloc] init];
        [imgView setImageWithURL:[NSURL URLWithString:[[[data valueForKey:@"items"] valueForKey:@"Exhibitions"][j] valueForKey:@"thumb_url"]] placeholderImage:[UIImage imageNamed:@"splash_iPhone.png"] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [exhibitionArr addObject:[[[data valueForKey:@"items"] valueForKey:@"Exhibitions"][j] valueForKey:@"title"]];
        imgView.frame = frame;
        imgView.tag = j;
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(exhibition_BannerTapped:)];
        tapGestureRecognizer.numberOfTapsRequired = 1;
        [imgView addGestureRecognizer:tapGestureRecognizer];
        imgView.userInteractionEnabled = YES;
        [ExhibitionScroll addSubview:imgView];
    }
    _exhibiNmLbl.text =[NSString stringWithFormat:@" %@",[[[data valueForKey:@"items"] valueForKey:@"Exhibitions"][0] valueForKey:@"title"]];
    exhibiDtlLbl.text =[NSString stringWithFormat:@" %@ | %@",[[[data valueForKey:@"items"] valueForKey:@"Exhibitions"][0] valueForKey:@"from_time"],[[[data valueForKey:@"items"] valueForKey:@"Exhibitions"][0] valueForKey:@"end_time"]];*/
    
    //Without Service Integration
    ExhibitionScroll.contentSize = CGSizeMake(ExhibitionScroll.frame.size.width * promoArr.count, ExhibitionScroll.frame.size.height);
    for (int j = 0; j < promoArr.count; j++) {
        CGRect frame;
        frame.origin.x = ExhibitionScroll.frame.size.width * j;
        frame.origin.y = 0;
        frame.size = ExhibitionScroll.frame.size;
        UIImageView* imgView = [[UIImageView alloc] init];
        imgView.image = [promoArr objectAtIndex:j];
        imgView.frame = frame;
        [ExhibitionScroll addSubview:imgView];
    }
    //end
}

-(void)exhibition_BannerTapped:(UIGestureRecognizer *)sender{
    //NSLog(@"sender tag.. %ld",dealno);
    NSLog(@"dashboardArr.. %@",[[[dashboardArr valueForKey:@"items"] valueForKey:@"Exhibitions"][sender.view.tag] valueForKey:@"exhibition_id"]);
    NSString * exhibition_ID = [[[dashboardArr valueForKey:@"items"] valueForKey:@"Exhibitions"][sender.view.tag] valueForKey:@"exhibition_id"];
    [delegate.defaults setValue:exhibition_ID forKey:@"exhibition_ID"];
    [delegate.defaults synchronize];
    ExhibitionDetailViewController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"ExhibitionDetailViewController"];
    [self.navigationController pushViewController:detail animated:YES];
    
}

-(void)setupCollections:(NSMutableArray*)data{
    NSLog(@"data.. %@",data);
    for(UIButton * btn in allbucketsBtnsArr){
        [btn removeFromSuperview];
    }
   //Service Integration
    float yht=(collectionLbl.frame.origin.y + collectionLbl.frame.size.height) + 5;

    for (int j = 0; j < bucketsArr.count; j++) {
        if(j%2 == 0){
            collectionsbtn = [UIButton buttonWithType:UIButtonTypeCustom];
            collectionsbtn.frame = CGRectMake(5, yht, (self.view.frame.size.width/2 - 10), 35);
            [collectionsbtn setTitle:[bucketsArr[j] valueForKey:@"title"] forState:UIControlStateNormal];
            [collectionsbtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            [collectionsbtn.titleLabel setFont:[UIFont fontWithName:@"Roboto-Regular" size:14]];
            collectionsbtn.tag = j;
            [allbucketsBtnsArr addObject:collectionsbtn];
            collectionsbtn.layer.borderWidth = 1.0f;
            collectionsbtn.layer.borderColor = [[UIColor View_Border] CGColor];
            collectionsbtn.layer.cornerRadius = 18.0f;
            [collectionsbtn addTarget:self action:@selector(collectionTapped:) forControlEvents:UIControlEventTouchUpInside];
            [DashboardScroll addSubview:collectionsbtn];
        }else{
            collectionsbtn = [UIButton buttonWithType:UIButtonTypeCustom];
            collectionsbtn.frame = CGRectMake(self.view.frame.size.width/2, yht, (self.view.frame.size.width/2 - 10), 35);
            [collectionsbtn setTitle:[bucketsArr[j] valueForKey:@"title"] forState:UIControlStateNormal];
            [collectionsbtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            collectionsbtn.tag = j;
            [allbucketsBtnsArr addObject:collectionsbtn];
            collectionsbtn.layer.borderWidth = 1.0f;
            [collectionsbtn.titleLabel setFont:[UIFont fontWithName:@"Roboto-Regular" size:14]];
            collectionsbtn.layer.borderColor = [[UIColor View_Border] CGColor];
            collectionsbtn.layer.cornerRadius = 18.0f;
            [collectionsbtn addTarget:self action:@selector(collectionTapped:) forControlEvents:UIControlEventTouchUpInside];
            [DashboardScroll addSubview:collectionsbtn];
            yht = (yht+collectionsbtn.frame.size.height)+5.0f;
        }
    }

    //End
    
  /*  //Without service integration
    float yht=collectionLbl.frame.origin.y - 15;
    for (int j = 0; j < collectionArr.count; j++) {
        if(j%2 == 0){
            collectionsbtn = [UIButton buttonWithType:UIButtonTypeCustom];
            collectionsbtn.frame = CGRectMake(5, yht, (self.view.frame.size.width/2 - 10), 35);
            [collectionsbtn setTitle:[collectionArr objectAtIndex:j] forState:UIControlStateNormal];
            [collectionsbtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            [collectionsbtn.titleLabel setFont:[UIFont fontWithName:@"Roboto-Regular" size:14]];
            collectionsbtn.tag = j;
            collectionsbtn.layer.borderWidth = 1.0f;
            collectionsbtn.layer.borderColor = [[UIColor View_Border] CGColor];
            collectionsbtn.layer.cornerRadius = 18.0f;
            [collectionsbtn addTarget:self action:@selector(collectionTapped:) forControlEvents:UIControlEventTouchUpInside];
            [DashboardScroll addSubview:collectionsbtn];
            
        }else{
            
            collectionsbtn = [UIButton buttonWithType:UIButtonTypeCustom];
            collectionsbtn.frame = CGRectMake(self.view.frame.size.width/2, yht, (self.view.frame.size.width/2 - 10), 35);
            [collectionsbtn setTitle:[collectionArr objectAtIndex:j] forState:UIControlStateNormal];
            [collectionsbtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            collectionsbtn.tag = j;
            collectionsbtn.layer.borderWidth = 1.0f;
            [collectionsbtn.titleLabel setFont:[UIFont fontWithName:@"Roboto-Regular" size:14]];
            collectionsbtn.layer.borderColor = [[UIColor View_Border] CGColor];
            collectionsbtn.layer.cornerRadius = 18.0f;
            [collectionsbtn addTarget:self action:@selector(collectionTapped:) forControlEvents:UIControlEventTouchUpInside];
            [DashboardScroll addSubview:collectionsbtn];
            yht = (yht+collectionsbtn.frame.size.height)+5.0f;
        }
    }*/
    
    DashboardScroll.contentSize = CGSizeMake(self.view.frame.size.width, yht + 50);
}

-(void)collectionTapped:(UIButton *)sender{
    [delegate.defaults setObject:@"High Street" forKey:@"verticalsCategory"];
    [delegate.defaults setObject:@"fromBucket" forKey:@"isFromBucket"];
    long int bucketID = [[bucketsArr[sender.tag] valueForKey:@"id"] intValue];
    NSString *bucketId1 = [bucketsArr[sender.tag] valueForKey:@"id"];
    [delegate.defaults setValue:bucketId1 forKey:@"category"];
    NSString * title = [[bucketsArr[sender.tag] valueForKey:@"title"] uppercaseString];
    [delegate.defaults setInteger:bucketID forKey:@"bucketID"];
    [delegate.defaults setValue:title forKey:@"bucketName"];
    [delegate.defaults setValue:@"Buckets" forKey:@"route"];
    [delegate.defaults synchronize];
    [constant Redirect:self.navigationController Identifier:@"ResultsViewController"];
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    if(touch.view.tag==1000){
        couponDetMainView.hidden = TRUE;
    }
}

-(void)allocateRequired{
    self.navigationController.navigationBarHidden =true;
    constant = [[Common alloc]init];
    delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    usrNameLbl.text = [delegate.defaults valueForKey:@"usr_name"];
    
    [constant addNavigationBar:self.view];
    promoArr = [[NSMutableArray alloc]init];
    exhibitionArr = [[NSMutableArray alloc]init];
    dashboardArr = [[NSMutableArray alloc]init];
    DashboardData = [[NSMutableData alloc]init];
    parentsData = [[NSMutableData alloc]init];
    
    dealsdata = [[NSMutableData alloc]init];
    dealsArr = [[NSMutableArray alloc]init];
    bucketsArr = [[NSMutableArray alloc]init];
    allbucketsBtnsArr = [[NSMutableArray alloc]init];
    
   
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

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    if([CLLocationManager locationServicesEnabled]){
        if([CLLocationManager authorizationStatus]==kCLAuthorizationStatusDenied){
            [self CreateLocationEnabler];
        }else{
           // [self getNearbyDeals];
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

-(void)CreateNetworkEnabler{
    networkEnablerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    //locationenablerView.backgroundColor = [UIColor Location_ServiceClr];
    networkEnablerView.backgroundColor = [UIColor whiteColor];
    UIImageView * networkEnablerImg = [[UIImageView alloc]init];
    networkEnablerImg.contentMode = UIViewContentModeScaleAspectFit;
    //locationEnablerImg.backgroundColor = [UIColor yellowColor];
    networkEnablerImg.frame = CGRectMake(0, 54, self.view.frame.size.width, self.view.frame.size.height / 1.8);
    networkEnablerImg.image = [UIImage imageNamed:@"Internet_Failure.png"];
    
    [constant addNavigationBar:networkEnablerView];
    
    UIButton *current_Loc = (UIButton *)[networkEnablerView viewWithTag:444];
    current_Loc.hidden = true;
    
    UIButton *notifications = (UIButton *)[networkEnablerView viewWithTag:222];
    notifications.hidden = true;
    
    UIButton *menu = (UIButton *)[networkEnablerView viewWithTag:111];
    menu.hidden = true;
    
    UISearchBar *searchbr = (UISearchBar *)[networkEnablerView viewWithTag:11111];
    searchbr.hidden = true;
    
    UIButton * btnEnable = [UIButton buttonWithType:UIButtonTypeCustom];
    btnEnable.frame = CGRectMake(self.view.frame.size.width / [constant.passEnablePos floatValue], (networkEnablerImg.frame.origin.y + networkEnablerImg.frame.size.height) + 30, 145, 40);
    [btnEnable setTitle:@"TRY AGAIN" forState:UIControlStateNormal];
    [btnEnable.titleLabel setFont:[UIFont fontWithName:@"Raleway-Bold" size:14]];
    [btnEnable addTarget:self action:@selector(EnableNetwork) forControlEvents:UIControlEventTouchUpInside];
    btnEnable.backgroundColor = [UIColor redColor];
    btnEnable.layer.cornerRadius = 18.0f;
    
    [networkEnablerView addSubview:btnEnable];
    [networkEnablerView addSubview:networkEnablerImg];
    
    [[[UIApplication sharedApplication] keyWindow] addSubview:networkEnablerView];
}

-(void)EnableNetwork{
    NSString *message = @"Enable Network Services";
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Network services are off"
                                                        message:message
                                                       delegate:self
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"Settings", nil];
    [alertView show];
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

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        locationenablerView.hidden = true;
         [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"App-Prefs:root=Privacy"]];
        // [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=General&path=Keyboard"]];
    }else{
        networkEnablerView.hidden = true;
    }
}

-(void)EnterManualLocation{
    
    [locationenablerView removeFromSuperview];
    
    GMSAutocompleteViewController *acController = [[GMSAutocompleteViewController alloc] init];
    acController.delegate = self;
    [self presentViewController:acController animated:YES completion:nil];
    
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    
    CLLocation* loc = [locations lastObject];
    NSString * latstring = [NSString stringWithFormat:@"%f", locationManager.location.coordinate.latitude];
    NSString * longstring = [NSString stringWithFormat:@"%f", locationManager.location.coordinate.longitude];
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init] ;
    [geocoder reverseGeocodeLocation:self->locationManager.location
                   completionHandler:^(NSArray *placemarks, NSError *error) {
                       NSLog(@"reverseGeocodeLocation:completionHandler: Completion Handler called!");
                       
                       if (error){
                           NSLog(@"Geocode failed with error: %@", error);
                           return;
                       }
                       
                       CLPlacemark *placemark = [placemarks firstObject];
                       locality = [NSString stringWithFormat:@"%@",placemark.subLocality];
                    }];
    
    [delegate.defaults setValue:latstring forKey:@"latitude"];
    [delegate.defaults setValue:longstring forKey:@"longitude"];
    
//    currentLatitude = [[delegate.defaults valueForKey:@"latitude"] floatValue];
//    currentLongitude = [[delegate.defaults valueForKey:@"longitude"] floatValue];
    
    [delegate.defaults setValue:locality forKey:@"updateloc_name"];
    [delegate.defaults setValue:@"myloc" forKey:@"locupdatefrom"];
    if (locality != nil){
    [delegate.defaults setValue:locality forKey:@"myloc_name"];
    }
    [delegate.defaults synchronize];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self allocateRequired];
    brandedBtn.hidden = TRUE;
    
    
    _ExhibitionTitleHdr.hidden = true;
    _ExhibitionMoreBtn.hidden = true;
    _ExhibitionDtlsView.hidden = true;
     ExhibitionScroll.hidden = true;
    
    [constant changeFrameforDashboardWRT:couponScroll ofview:brandView];
    [constant changeFrameforDashboardWRT:brandView ofview:_CheckinDtlsView];
    [constant changeFrameforDashboardWRT:_CheckinDtlsView ofview:_CollectionsLblHdr];
    [constant changeFrameforDashboardWRT:_CheckinDtlsView ofview:_collectionMoreBtn];
    
   
    
    //Without webservice Integration
    promoArr = [[NSMutableArray alloc]initWithObjects:[UIImage imageNamed:@"Promo1.png"],[UIImage imageNamed:@"Promo2.png"],[UIImage imageNamed:@"Promo3.png"],[UIImage imageNamed:@"Promo4.png"],nil];
    collectionArr = [[NSMutableArray alloc]initWithObjects:@"Summer Collection",@"Winter Collection",@"Rainy Collection",@"Holi Collection",@"Diwali Collection",@"Eid Collection",nil];
    ExhibitionTitleArr = [[NSMutableArray alloc]initWithObjects:@"Summer Exhibition",@"Winter Exhibition",@"Rainy Exhibition",@"Holi ,Exhibition",nil];
    _dealArr = [[NSMutableArray alloc]initWithObjects:@"Buy 2 get 1 Free",@"Buy 2 for 1000",@"Buy 3 get 1 Free",@"Buy 3 get 1 Free",@"Buy 1 for 1000",nil];
    
  // [self setupCollections:collectionArr];
  // [self setupCoupons:_dealArr];
    
    [usrNameLbl setShadowColor:[UIColor darkGrayColor]];
    [usrNameLbl setShadowOffset:CGSizeMake(0, -1)];
    [_welcomeLbl setShadowColor:[UIColor darkGrayColor]];
    [_welcomeLbl setShadowOffset:CGSizeMake(0, -1)];
    requestType = @"updateCoupon";
//    NSString *messageBody = [NSString stringWithFormat:@"log_id=%@&device_os=%@&device_token=%@",[delegate.defaults valueForKey:@"logid"],@"ios",[delegate.defaults valueForKey:@"deviceToken"]];
//    NSLog(@"messageBody.. %@",messageBody);
//    [constant sendRequest:self.view mutableDta:dealsdata url:constant.updateDeviceToken msgBody:messageBody];
    //End
    
    UIButton *back = (UIButton *)[self.view viewWithTag:1111];
    back.hidden = true;
    
    UIButton *Menu = (UIButton *)[self.view viewWithTag:111];
    [Menu addTarget:self action:@selector(MenuToggle) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *current_Loc = (UIButton *)[self.view viewWithTag:444];
    [current_Loc addTarget:self action:@selector(FindCurrentTapped) forControlEvents:UIControlEventTouchUpInside];
    
    search = (UISearchBar *)[self.view viewWithTag:11111];
    txfSearchField = [search valueForKey:@"_searchField"];
    
    [constant addTabImages:self.tabBarController.tabBar];
    
    [constant addLayer:categoryView button1:menBtn button2:womenBtn button3:kidsBtn btn1title:constant.menIcon btn2title:constant.womenIcon btn3title:constant.childrenIcon];
    
    [constant addLayer:brandView button1:highStrBtn button2:brandedBtn button3:designerBtn btn1title:constant.highStreetIcon btn2title:constant.brandedIcon btn3title:constant.designerIcon];
    
    checkinBtn.layer.cornerRadius = 18.0;
    couponSubmitBtn.layer.cornerRadius = 20.0;
    
    self.tabBarController.tabBar.tintColor = [UIColor redColor];
   
    UIButton *notifications = (UIButton *)[self.view viewWithTag:222];
    [notifications addTarget:self action:@selector(notificationsTapped) forControlEvents:UIControlEventTouchUpInside];
    PromoPgCtrl.pageIndicatorTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"emptyDot_iPhone.png"]];
    PromoPgCtrl.currentPageIndicatorTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"filledDot_iPhone.png"]];
    
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"]==NO)
    {
        HelpViewController * help = [self.storyboard instantiateViewControllerWithIdentifier:@"HelpViewController"];
        [self.navigationController pushViewController:help animated:true];
        //[self presentViewController:help animated:YES completion:nil];
    }
    constant.delegate = self;
}

-(void)FindCurrentTapped{
    
    for (UIView *view in couponScroll.subviews)  {
        if ([view isKindOfClass:[UIView class]]) {
            [view removeFromSuperview];
        }
    }
    
    currentLatitude = [[delegate.defaults valueForKey:@"latitude"]floatValue];
    currentLongitude = [[delegate.defaults valueForKey:@"longitude"]floatValue];
    [delegate.defaults setValue:[delegate.defaults valueForKey:@"latitude"] forKey:@"user_latitude"];
    [delegate.defaults setValue:[delegate.defaults valueForKey:@"longitude"] forKey:@"user_longitude"];
    
     [delegate.defaults setValue:@"myloc" forKey:@"locupdatefrom"];
     NSLog(@"%@",[delegate.defaults valueForKey:@"loc_name"]);
     txfSearchField.text = [delegate.defaults valueForKey:@"myloc_name"];
     [delegate.defaults setValue:[delegate.defaults valueForKey:@"myloc_name"] forKey:@"loc_name"];
     NSLog(@"%@",[delegate.defaults valueForKey:@"loc_name"]);
     [delegate.defaults synchronize];
     [self getNearbyDealsWithLatitude:[[delegate.defaults valueForKey:@"latitude"]floatValue] longitude:[[delegate.defaults valueForKey:@"longitude"]floatValue] radius:userRadius];
}

-(void)setUpstackMenu{
    contentView = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 60, self.view.frame.size.height + 5, 35, 35)];
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

-(void)notificationsTapped{
    NotificationsViewController * notifications = [self.storyboard instantiateViewControllerWithIdentifier:@"NotificationsViewController"];
    [self presentViewController:notifications animated:YES completion:nil];
}


-(void)CCKFNavDrawerSelection:(NSInteger)selectedSession selectedRow: (NSInteger) row {
    [constant DrawerTapped:selectedSession selectedRow: row];
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
    NSString *message = [NSString stringWithFormat:@"Item touched : %@", item.title];
    NSLog(@"index.. %lu",(unsigned long)index);
    if(index == 0){
        [delegate.defaults setValue:@"Favourites" forKey:@"route"];
        [constant Redirect:self.navigationController Identifier:@"ResultsViewController"];
    }else if(index == 1){
       [constant Redirect:self.navigationController Identifier:@"ProfileViewController"];
    }else if (index == 2){
        
    }
    [stack closeStack];
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:message message:nil delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
//    [alert show];
}

-(void)timerCalled{
    [PromoScroll setContentOffset:CGPointMake(PromoScroll.frame.size.width*i, 0.0f) animated:YES];
    i++;
    if(i > promocnt-1){
        i = 0;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scroll {
    if (!pageControlBeingUsed) {
        // Switch the indicator when more than 50% of the previous/next page is visible
        CGFloat pageWidth = PromoScroll.frame.size.width;
        int page = floor((PromoScroll.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
        PromoPgCtrl.currentPage = page;
    }
    if(scroll == ExhibitionScroll){
        CGFloat pageWidth = ExhibitionScroll.frame.size.width;
        int page = floor((ExhibitionScroll.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
        //_exhibiNmLbl.text =[NSString stringWithFormat:@" %@",[[[dashboardArr valueForKey:@"items"] valueForKey:@"Exhibitions"][page] valueForKey:@"title"]];
        _exhibiNmLbl.text =[NSString stringWithFormat:@" %@",ExhibitionTitleArr[page]];
       /* exhibiDtlLbl.text =[NSString stringWithFormat:@" %@ | %@",[[[dashboardArr valueForKey:@"items"] valueForKey:@"Exhibitions"][page] valueForKey:@"from_time"],[[[dashboardArr valueForKey:@"items"] valueForKey:@"Exhibitions"][page] valueForKey:@"end_time"]];*/
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    pageControlBeingUsed = NO;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    pageControlBeingUsed = NO;
}

-(void)backTapped{
    //    NSLog(@"count.. %lu",(unsigned long)[container subviews].count);
    //    [[[container subviews] objectAtIndex:0] removeFromSuperview];
    //    container.hidden = TRUE;
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)showVerticals{
    [delegate.defaults setObject:@"StoreType" forKey:@"resultType"];
    [delegate.defaults synchronize];
     if([constant isActiveInternet] == YES){
    ResultsViewController * result = [self.storyboard instantiateViewControllerWithIdentifier:@"ResultsViewController"];
    [self.navigationController pushViewController:result animated:YES];
    self.tabBarController.tabBar.tintColor = [UIColor lightGrayColor];
     }else{
         [constant Redirect:self.navigationController Identifier:@"InternetDisconnectViewController"];
         //[self.view makeToast:@"Check your internet connection"];
     }
}

-(void)GetHighstreetStores{
    [delegate.defaults setObject:@"High Street" forKey:@"verticalsCategory"];
     [delegate.defaults setValue:@"Verticals" forKey:@"whichsegment"];
    [delegate.defaults setValue:@"Store" forKey:@"route"];
    [delegate.defaults synchronize];
    [self showVerticals];
}

- (IBAction)highStrTapped:(id)sender {
    
    [self GetHighstreetStores];
}

- (IBAction)brandedTapped:(id)sender {
    [delegate.defaults setObject:@"Brands" forKey:@"verticalsCategory"];
    [delegate.defaults setValue:@"Verticals" forKey:@"whichsegment"];
    [delegate.defaults setValue:@"Store" forKey:@"route"];
    [delegate.defaults synchronize];
    [self showVerticals];
}

- (IBAction)designerTapped:(id)sender {
    [delegate.defaults setObject:@"Designers" forKey:@"verticalsCategory"];
    [delegate.defaults setValue:@"Verticals" forKey:@"whichsegment"];
    [delegate.defaults setValue:@"Store" forKey:@"route"];
    [delegate.defaults synchronize];
    [self showVerticals];
}

- (IBAction)checkInTapped:(id)sender {
    [delegate.defaults setObject:@"High Street" forKey:@"verticalsCategory"];
    [delegate.defaults setValue:@"CheckIn" forKey:@"resultType"];
    [delegate.defaults setValue:@"Store" forKey:@"route"];
    [delegate .defaults synchronize];
    ResultsViewController * result = [self.storyboard instantiateViewControllerWithIdentifier:@"ResultsViewController"];
    [self.navigationController pushViewController:result animated:YES];
    self.tabBarController.tabBar.tintColor = [UIColor lightGrayColor];
}

- (IBAction)moreCollectionsTapped:(id)sender {
    [self.tabBarController setSelectedIndex:1];
}

- (void)autocomplete:(Common *)response{
    GMSAutocompleteViewController *acController = [[GMSAutocompleteViewController alloc] init];
    acController.delegate = self;
    [self presentViewController:acController animated:YES completion:nil];
//    resultcontroller = [[GMSAutocompleteResultsViewController alloc] init];
//    resultcontroller.delegate = self;
//    
//    searchcontroller = [[UISearchController alloc]
//                         initWithSearchResultsController:resultcontroller];
//    searchcontroller.searchResultsUpdater = resultcontroller;
//    
//    // Put the search bar in the navigation bar.
//    [searchcontroller.searchBar sizeToFit];
//    self.navigationItem.titleView = searchcontroller.searchBar;
//    
//    // When UISearchController presents the results view, present it in
//    // this view controller, not one further up the chain.
//    self.definesPresentationContext = YES;
//    
//    // Prevent the navigation bar from being hidden when searching.
//    searchcontroller.hidesNavigationBarDuringPresentation = NO;
}

// Handle the user's selection.
- (void)viewController:(GMSAutocompleteViewController *)viewController
didAutocompleteWithPlace:(GMSPlace *)place {

    search.text = place.name;
    currentLatitude = place.coordinate.latitude;
    currentLongitude = place.coordinate.longitude;
    NSString *userLatitude1 = [NSString stringWithFormat:@"%f",place.coordinate.latitude];
    NSString *userLongitude1 = [NSString stringWithFormat:@"%f",place.coordinate.longitude];
    
    NSString *placename = place.name;
    NSLog(@"place name is... %@",placename);
    [delegate.defaults setValue:userLatitude1 forKey:@"user_latitude"];
    [delegate.defaults setValue:userLongitude1 forKey:@"user_longitude"];
    [delegate.defaults setValue:@"loc" forKey:@"locupdatefrom"];
    [delegate.defaults setValue:placename forKey:@"loc_name"];
    [delegate.defaults synchronize];
    
    userLatitude = [[delegate.defaults valueForKey:@"user_latitude"] floatValue];
    userLongitude = [[delegate.defaults valueForKey:@"user_longitude"] floatValue];
    
//    [self getNearbyDealsWithLatitude:currentLatitude longitude:currentLongitude radius:userRadius];
    
    NSLog(@"Current latitude.. %f current longitude.. %f",currentLatitude,currentLongitude);
    NSLog(@"user latitude.. %f user longitude.. %f",userLatitude,userLongitude);
    txfSearchField.text = placename;
    txfSearchField.textColor = [UIColor whiteColor];
    [self dismissViewControllerAnimated:YES completion:nil];
  
}

- (void)viewController:(GMSAutocompleteViewController *)viewController
didFailAutocompleteWithError:(NSError *)error {
    [self dismissViewControllerAnimated:YES completion:nil];
    // TODO: handle the error.
    NSLog(@"Error: %@", [error description]);
}

// User canceled the operation.
- (void)wasCancelled:(GMSAutocompleteViewController *)viewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

// Turn the network activity indicator on and off again.
- (void)didRequestAutocompletePredictions:(GMSAutocompleteViewController *)viewController {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)didUpdateAutocompletePredictions:(GMSAutocompleteViewController *)viewController {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

-(void)MenuToggle{
    [self.rootNav drawerToggle];
}

- (IBAction)menTapped:(id)sender {
    [delegate.defaults setObject:@"High Street" forKey:@"verticalsCategory"];
    [delegate.defaults setValue:@"High Street" forKey:@"whichsegment"];
    NSString * catID = [delegate.defaults valueForKey:@"MensCategory"];
    [delegate.defaults setValue:catID forKey:@"category"];
    [delegate.defaults setValue:@"Store" forKey:@"route"];
    [delegate.defaults synchronize];
    [constant showResults];
}

- (IBAction)womenTapped:(id)sender {
    [delegate.defaults setObject:@"High Street" forKey:@"verticalsCategory"];
     [delegate.defaults setValue:@"High Street" forKey:@"whichsegment"];
    NSString * catID = [delegate.defaults valueForKey:@"WomensCategory"];
    [delegate.defaults setValue:catID forKey:@"category"];
    [delegate.defaults setValue:@"Store" forKey:@"route"];
    [delegate.defaults synchronize];
    [constant showResults];
    
}

- (IBAction)kidsTapped:(id)sender {
    [delegate.defaults setObject:@"High Street" forKey:@"verticalsCategory"];
     [delegate.defaults setValue:@"High Street" forKey:@"whichsegment"];
    NSString * catID = [delegate.defaults valueForKey:@"ChildrenCategory"];
    [delegate.defaults setValue:catID forKey:@"category"];
    [delegate.defaults setValue:@"Store" forKey:@"route"];
    [delegate.defaults synchronize];
    [constant showResults];
}

- (void)tabBarController:(UITabBarController *)tabBarController
 didSelectViewController:(UIViewController *)viewController{
    [container setHidden:TRUE];
    self.tabBarController.tabBar.tintColor = [UIColor redColor];
}

- (IBAction)couponSubmitTapped:(UIButton *)sender {
    couponDetMainView.hidden = true;
  /*  NSLog(@"sender tag.. %ld",dealno);
    NSLog(@"dashboardArr.. %@",[[[dashboardArr valueForKey:@"items"] valueForKey:@"Deals"][dealno] valueForKey:@"store_id"]);
    NSString* storeID = [[[dashboardArr valueForKey:@"items"] valueForKey:@"Deals"][dealno] valueForKey:@"store_id"];*/
    
    DetailViewController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
    [self.navigationController pushViewController:detail animated:YES];
    
}

- (IBAction)moreDealsTapped:(id)sender {
    [constant Redirect:self.navigationController Identifier:@"BestDealsViewController"];
}

-(void)showExhibitions{
    //[self.view makeToast:@"Coming Soon"];
    txfSearchField = [search valueForKey:@"_searchField"];
//    ExhibitionListingViewController * result = [self.storyboard instantiateViewControllerWithIdentifier:@"ExhibitionListingViewController"];
//    [self.navigationController pushViewController:result animated:YES];
//    self.tabBarController.tabBar.tintColor = [UIColor lightGrayColor];
}

- (IBAction)moreExhibitionsTapped:(id)sender {
    [self.view makeToast:@"Coming Soon"];
    //[self showExhibitions];
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
