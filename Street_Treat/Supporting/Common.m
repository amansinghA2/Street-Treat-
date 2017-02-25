//
//  Common.m
//  Street_Treat
//
//  Created by Kamlesh Dubey on 5/12/16.
//  Copyright (c) 2016 Digillence Rolson. All rights reserved.
//

#import "Common.h"
#import "ViewController.h"

@interface Common ()

@end

@implementation Common
@synthesize delegate;
@synthesize rootNav,siteURL,LoginURL,RegisterURL,uniqueFldURL,forgotpasswordURL,staticDataURL,contactURL,getProfileURL,dashboardURL,searchListURL,feedbackURL,reportErrorURL,viewFeedbacksURL,exhibition_listURL,verticalsURL,storeDetailURL,bucketsListURL,otpURL,exhibition_detailURL,loginFBURL,newsEventsURL,termsconditionsURL,generatenewotpURL,verifyOTPURL,changePasswordURL,FAQsURL,privacypolicyURL,CheckinsURL,getOffersURL,generateCouponsURL,AddfavouritesURL,shareStoreURL,bucketsDeatilURL,callStoreURL,changePassfromProfileURL,getParentCategoriesURL,getMastersURL,addReviewsforStoreURL,getstoreDetailsURL,setProfileURL,myCouponsURL,updateMobileURL,userProfImageURL;

@synthesize Fbicon,gPlusicon,forgotIcon,telIcon,faxIcon,mailIcon,menIcon,womenIcon,childrenIcon,highStreetIcon,brandedIcon,designerIcon,shareIcon,editIcon,coloreditIcon,locationbaloonIcon,filtersIcon,starIcon,radiofilledIcon,radioemptyIcon,twostarIcon,threestarIcon,fourstarIcon,fivestarIcon,checkboxemptyIcon,checkboxfilledIcon,allreviewsIcon,positivereviewsIcon,negativereviewsIcon,backIcon,notificationIcon,menuIcon,indicatorBlankIcon,indicatorFilledIcon,homeIcon,collectionIcon,nearmeIcon,storeawayIcon,storephoneIcon,addtofavouritesIcon,cameraIcon,amenitiesACIcon,amenitiesLiftIcon,amenitiesCarParkingIcon,amenitiesCreditCardIcon,emptystarIcon,addedtofavouritesIcon;

@synthesize cpnfnt,usryPos,passyPos,cpnDtlfnt,storetitlefnt,regSubmitPos,forgotPassPos,passSubmitPos,passEnablePos;

#pragma mark - Initailize Methods
- (id)init {
    self = [super init];
    if (self) {
        self.rootNav = (CCKFNavDrawer *)self.navigationController;
        [self.rootNav setCCKFNavDrawerDelegate:self];
        maindelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
        
        //common icons
        
        //header icons
        backIcon = @"\ue059";
        notificationIcon = @"\ue062";
        menuIcon = @"\ue060";
        //footer icons
        homeIcon = @"\ue046";
        collectionIcon = @"\ue026";
        nearmeIcon = @"\ue063";
        
        //end
        
        //Login Page Icons
        Fbicon = @"\ue038";
        gPlusicon = @"\ue040";
        //end
        
        //Forgot password page, change password page icons
        forgotIcon = @"\ue039";
        //end
        
        emptystarIcon = @"\ue087";
        
        //dashboard icons
        menIcon = @"\ue053";
        womenIcon = @"\ue083";
        childrenIcon = @"\ue025";
        highStreetIcon = @"\ue045";
        brandedIcon = @"\ue021";
        designerIcon = @"\ue031";
        //end
        
       //store Listing icons
        locationbaloonIcon = @"\ue050";
        filtersIcon = @"\ue075";
        starIcon = @"\ue066";
        storeawayIcon = @"\ue051";
        storephoneIcon = @"\ue067";
        //end
        
        //Checkin Page icons
        twostarIcon = @"\ue002";
        threestarIcon = @"\ue004";
        fourstarIcon = @"\ue006";
        fivestarIcon = @"\ue008";
        cameraIcon = @"\ue022";
        shareIcon = @"\ue076";
        addtofavouritesIcon = @"\ue049";
        addedtofavouritesIcon = @"\ue086";
        //end
        
        //Amenities Icons
        amenitiesACIcon = @"\ue011";
        amenitiesLiftIcon = @"\ue019";
        amenitiesCreditCardIcon = @"\ue015";
        amenitiesCarParkingIcon = @"\ue020";

        //Report Error Icons
        checkboxfilledIcon = @"\ue024";
        checkboxemptyIcon = @"\ue023";
        //end
        
        //Edit Profile Icons
         editIcon = @"\ue085";
        //end
        
        //Submit Reviews Icon
        radiofilledIcon = @"\ue073";
        radioemptyIcon = @"\ue080";
        //end
        
        
        
        
        telIcon = @"\ue027";
        faxIcon = @"\ue037";
        mailIcon = @"\ue035";
        
        
        
        
                
//        shareIcon = @"\ue050";
//        addtofavouritesIcon = @"\ue034";
       
        coloreditIcon = @"\ue822";
        
        
        
        
        
//        checkboxfilledIcon = @"\uf061";
//        checkboxemptyIcon = @"\uf062";
        
        allreviewsIcon = @"\ue010";
        positivereviewsIcon = @"\ue048";
        negativereviewsIcon = @"\ue032";
        
        
        
        //to be removed
        indicatorBlankIcon = @"\ue800";
        indicatorFilledIcon = @"\ue80f";
        //end
        
        //Previous
        //NSString * masterUrl = @"http://services.streettreat.in/index.php?option=com_konnect&task=";
        
       //Current
        siteURL = @"http://www.webtest.streettreat.in";
        NSString * masterUrl = @"http://www.webtest.streettreat.in/index.php?option=com_konnect&task=";
        
        getMastersURL = [NSString stringWithFormat:@"%@getMasterData",masterUrl];
        
        LoginURL = [NSString stringWithFormat:@"%@loginUser",masterUrl];
        getParentCategoriesURL = [NSString stringWithFormat:@"%@getPCategoriesy",masterUrl];
        
        RegisterURL = [NSString stringWithFormat:@"%@createUser",masterUrl];
        uniqueFldURL = [NSString stringWithFormat:@"%@checkUniqueness",masterUrl];
        forgotpasswordURL = [NSString stringWithFormat:@"%@forgotPasswordByMobile",masterUrl];
        verifyOTPURL = [NSString stringWithFormat:@"%@verifyForgotPasswordOTP",masterUrl];
        changePasswordURL = [NSString stringWithFormat:@"%@changePassword",masterUrl];
        changePassfromProfileURL = [NSString stringWithFormat:@"%@customer.changePasswordForLogedInUser",masterUrl];
        
        FAQsURL = @"http://www.web.streettreat.in/faq-s?tmpl=component";
        privacypolicyURL = @"http://www.web.streettreat.in/privacy-policy?tmpl=component";
        newsEventsURL = @"http://www.web.streettreat.in/news-events?tmpl=component";
        termsconditionsURL = @"http://www.web.streettreat.in/terms-and-conditions?tmpl=component";
        
        staticDataURL = [NSString stringWithFormat:@"%@connect.getArticleContent",masterUrl];
        contactURL = [NSString stringWithFormat:@"%@connect.getContactInformation",masterUrl];
        otpURL = [NSString stringWithFormat:@"%@verifyOTP",masterUrl];
        generatenewotpURL = [NSString stringWithFormat:@"%@generateOTP",masterUrl];
        
        getProfileURL = [NSString stringWithFormat:@"%@customer.getUserProfile",masterUrl];
        
        dashboardURL = [NSString stringWithFormat:@"%@getDashboard",masterUrl];
        storeDetailURL = [NSString stringWithFormat:@"%@getStore",masterUrl];
        getstoreDetailsURL = [NSString stringWithFormat:@"%@customer.getStoreDetails",masterUrl];
        setProfileURL = [NSString stringWithFormat:@"%@customer.setUserFields",masterUrl];
        
        bucketsListURL = [NSString stringWithFormat:@"%@customer.getBucketLists",masterUrl];
        bucketsDeatilURL = [NSString stringWithFormat:@"%@customer.getBucketDetails",masterUrl];
        
        searchListURL = [NSString stringWithFormat:@"%@customer.getStoreListing",masterUrl];
        userProfImageURL = [NSString stringWithFormat:@"%@customer.uploadUserProfileFiles",masterUrl];
        CheckinsURL = [NSString stringWithFormat:@"%@customer.checkInUser",masterUrl];
        getOffersURL = [NSString stringWithFormat:@"%@customer.getCoupons",masterUrl];
        viewFeedbacksURL = [NSString stringWithFormat:@"%@customer.viewReviews",masterUrl];
        reportErrorURL = [NSString stringWithFormat:@"%@customer.setReporting",masterUrl];
        generateCouponsURL = [NSString stringWithFormat:@"%@customer.generateCouponFromDeal",masterUrl];
        AddfavouritesURL = [NSString stringWithFormat:@"%@customer.addToFavorites",masterUrl];
        shareStoreURL = [NSString stringWithFormat:@"%@customer.shareStore",masterUrl];
        callStoreURL = [NSString stringWithFormat:@"%@customer.callStore",masterUrl];
        addReviewsforStoreURL = [NSString stringWithFormat:@"%@customer.addReview",masterUrl];
       
        
        verticalsURL = [NSString stringWithFormat:@"%@getVerticals",masterUrl];
        exhibition_listURL = [NSString stringWithFormat:@"%@getExhibitionListing",masterUrl];
        exhibition_detailURL = [NSString stringWithFormat:@"%@getExhibitionDetails",masterUrl];
        myCouponsURL = [NSString stringWithFormat:@"%@customer.getMyCoupons",masterUrl];
        
        feedbackURL = [NSString stringWithFormat:@"%@setFeedback",masterUrl];
        
        updateMobileURL = [NSString stringWithFormat:@"%@customer.updateMobileNumberNGenerateOTP",masterUrl];
        
        
        
        
        
        loginFBURL = [NSString stringWithFormat:@"%@socialLogin",masterUrl];
        
        
        
        
        ht = 0;
        ht = [[UIScreen mainScreen] bounds].size.height;
        
        if(ht == 480){
            usryPos = @"50";
            passyPos = @"50";
            cpnDtlfnt = @"55";
            storetitlefnt = @"14";
            regSubmitPos = @"4";
            forgotPassPos =@"1.8";
            passSubmitPos =@"5.5";
            passEnablePos = @"3.2";
        }else if (ht == 568){
            cpnfnt = @"25";
            usryPos = @"25";
            passyPos = @"45";
            cpnDtlfnt = @"55";
            storetitlefnt = @"15";
            regSubmitPos = @"4";
            forgotPassPos =@"1.8";
            passSubmitPos =@"5.5";
            passEnablePos = @"3.5";
        }else if(ht == 667){
            cpnfnt = @"32";
            usryPos = @"30";
            passyPos = @"50";
            cpnDtlfnt = @"65";
            storetitlefnt = @"18";
            regSubmitPos = @"3.5";
            forgotPassPos =@"1.9";
            passSubmitPos =@"4.5";
            passEnablePos = @"3.5";
        }else if(ht == 736){
            cpnfnt = @"35";
            usryPos = @"35";
            passyPos = @"50";
            cpnDtlfnt = @"65";
            storetitlefnt = @"18";
            regSubmitPos = @"3.5";
            forgotPassPos =@"1.9";
            passSubmitPos =@"4";
            passEnablePos = @"3.5";
        }else if(ht == 1024){
            cpnfnt = @"35";
            usryPos = @"35";
            passyPos = @"50";
            cpnDtlfnt = @"65";
            storetitlefnt = @"18";
            regSubmitPos = @"3.5";
            forgotPassPos =@"1.9";
            passSubmitPos =@"4";
            passEnablePos = @"3.5";
        }

    }
    
    return self;
    
}

-(void)AddLoader:(UIView *)Mainview{
    loaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    loaderView.backgroundColor = [UIColor redColor];
    NSURL *url1 = [[NSBundle mainBundle] URLForResource:@"Loader" withExtension:@"gif"];
    NSData *data1 = [NSData dataWithContentsOfURL:url1];
    FLAnimatedImage *image = [FLAnimatedImage animatedImageWithGIFData:data1];
    FLAnimatedImageView * imageView = [[FLAnimatedImageView alloc] init];
    imageView.animatedImage = image;
    imageView.frame = CGRectMake(0.0, 0.0, 80.0, 80.0);
    imageView.center=self.view.center;
    [loaderView addSubview:imageView];
    [Mainview addSubview:loaderView];
}

-(void)RemoveLoader:(UIView *)Mainview{
    [loaderView removeFromSuperview];
}

-(BOOL)isActiveInternet{
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable) {
        NSLog(@"There IS NO internet connection");
        return false;
    } else {
        NSLog(@"There IS internet connection");
        return true;
    }
}


#pragma mark - Navigation and Tabbar Methods
-(void)addNavigationBar:(UIView *)MainView{
    UIView *myview = [[UIView alloc]initWithFrame:CGRectMake(5, 5, self.view.frame.size.width - 10, 44)];
    myview.backgroundColor = [UIColor redColor];
    myview.layer.cornerRadius = 20.0f;
    myview.layer.borderWidth = 0.5f;
    myview.layer.borderColor = [[UIColor blackColor] CGColor];
    UIButton * backbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backbtn.frame = CGRectMake(myview.frame.origin.x+5, myview.frame.origin.y+3, 35, 35);
    backbtn.tag = 1111;
    [backbtn setTitle:backIcon forState:UIControlStateNormal];
    [backbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backbtn.titleLabel setFont:[UIFont fontWithName:@"fontello" size:22]];
    
    UISearchBar *search = [[UISearchBar alloc] init];
    search.frame = CGRectMake((backbtn.frame.origin.x + backbtn.frame.size.width)-15, 0, 200,myview.frame.size.height);
    //search.backgroundColor = [UIColor yellowColor];
    search.delegate = self;
    search.tag = 11111;
    search.placeholder = @"Find your Location";
    [[UILabel appearanceWhenContainedIn:[UISearchBar class], nil] setTextColor:[UIColor whiteColor]];
    // Change the search bar placeholder text color
    //[searchField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [search setImage:[UIImage imageNamed:@"search_icon.png"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    txfSearchField = [search valueForKey:@"_searchField"];
    txfSearchField.backgroundColor = [UIColor redColor];
    [txfSearchField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    txfSearchField.clearButtonMode = UITextFieldViewModeNever;
    
    search.barTintColor = [UIColor redColor];
    search.delegate = self;
    [myview addSubview:search];
    
    UIButton * MenuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    MenuBtn.frame = CGRectMake(myview.frame.size.width - 50, myview.frame.origin.y+2, 30, 30);
    [MenuBtn setTitle:menuIcon forState:UIControlStateNormal];
    [MenuBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    MenuBtn.tag = 111;
    [MenuBtn.titleLabel setFont:[UIFont fontWithName:@"fontello" size:30]];
    
    UIButton * currentLocBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    currentLocBtn.frame = CGRectMake(MenuBtn.frame.origin.x - 80, myview.frame.origin.y+2, 30, 30);
    [currentLocBtn setImage:[UIImage imageNamed:@"Current_Loc.png"] forState:UIControlStateNormal];
    [currentLocBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    currentLocBtn.tag = 444;
    
    UIButton * notificationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    notificationBtn.frame = CGRectMake(MenuBtn.frame.origin.x - 40, myview.frame.origin.y+5, 25, 25);
    [notificationBtn setTitle:notificationIcon forState:UIControlStateNormal];
    notificationBtn.tag = 222;
    [notificationBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [notificationBtn.titleLabel setFont:[UIFont fontWithName:@"fontello" size:25]];
    
    [myview addSubview:currentLocBtn];
    [myview addSubview:MenuBtn];
    [myview addSubview:notificationBtn];
    [myview addSubview:backbtn];
    [MainView addSubview:myview];
    
    [MainView bringSubviewToFront:myview];
    MainView.clipsToBounds = NO;
    
//    [MainView setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
//    MainView.shadowImage = [UIImage new];
//    MainView.translucent = YES;
}

-(void)addTabImages:(UITabBar *)Maintab{
    [[Maintab.items objectAtIndex:0] setTitleTextAttributes:@{
                                                              NSFontAttributeName:[UIFont fontWithName:@"fontello" size:38.0f]
                                                              } forState:UIControlStateNormal];
    [[Maintab.items objectAtIndex:0] setTitle:homeIcon];
    [[Maintab.items objectAtIndex:1] setTitleTextAttributes:@{
                                                              NSFontAttributeName:[UIFont fontWithName:@"fontello" size:68.0f]
                                                              } forState:UIControlStateNormal];
    [[Maintab.items objectAtIndex:1] setTitle:collectionIcon];
    [[Maintab.items objectAtIndex:2] setTitleTextAttributes:@{
                                                              NSFontAttributeName:[UIFont fontWithName:@"fontello" size:42.0f]
                                                              } forState:UIControlStateNormal];
    [[Maintab.items objectAtIndex:2] setTitle:nearmeIcon];
}

-(void)Redirect:(UINavigationController *)Navigation Identifier:(NSString *)Identifier{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    UIViewController * controller = [storyboard instantiateViewControllerWithIdentifier:[NSString stringWithFormat:@"%@",Identifier]];
    [Navigation pushViewController:controller animated:YES];
}

-(void)PresentViewController:(UIViewController *)controller Identifier:(NSString *)Identifier{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    controller = [storyboard instantiateViewControllerWithIdentifier:[NSString stringWithFormat:@"%@",Identifier]];
    [self presentViewController:controller animated:YES completion:nil];
}

-(void)notificationsTapped{
    NotificationsViewController * notifications = [self.storyboard instantiateViewControllerWithIdentifier:@"NotificationsViewController"];
    [self presentViewController:notifications animated:YES completion:nil];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self.view endEditing:YES];
    [txfSearchField resignFirstResponder];
    txfSearchField.text = Nil;
}

#pragma mark - Connection Methods
-(void)sendRequest:(UIView *)MainView mutableDta:(NSMutableData *)mutableDta url:(NSString *)url msgBody:(NSString *)msgBody{
    [MainView endEditing:YES];
    if(!indicator){
    indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    indicator.color = [UIColor lightGrayColor];
    indicator.center=self.view.center;
    [MainView addSubview:indicator];
     }
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    [indicator startAnimating];
    [mutableDta setLength:0];
    NSURL *linkurl = [NSURL URLWithString:url];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:linkurl];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[msgBody length]];
    [request setHTTPMethod:@"POST"];
    [request addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:[msgBody dataUsingEncoding:NSUTF8StringEncoding]];
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    [NSURLConnection sendAsynchronousRequest:request
     
                                       queue:queue
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error){
                               if (error) {
                                   NSLog(@"error:%@", error.localizedDescription);
                               }
                               // dispatch_async(dispatch_get_main_queue(), ^{
                               
                               [mutableDta appendData:data];
                               NSLog(@"%@",mutableDta);
                               //[indicator removeFromSuperview];
                               [self DataResponse:mutableDta];
                               
                               //});
                           }];
}

-(void)DataResponse:(NSData *)data{
    NSMutableArray *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSLog(@"%@",result);
    [delegate sendResponse:self data:result indicator:indicator];
}

#pragma mark - Login Controller Methods
-(void)roundedImage:(UIImageView *)img{
    img.layer.cornerRadius = img.frame.size.height/2;
    img.clipsToBounds = YES;
}

-(int)calculateBirthdate:(NSString *)fromdate{
    NSDate *todayDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    int time = [todayDate timeIntervalSinceDate:[dateFormatter dateFromString:fromdate]];
    int allDays = (((time/60)/60)/24);
    int days = allDays%365;
    int years = (allDays-days)/365;
    //NSLog(@"You live since %i years and %i days",years,days);
    return years;
}

-(NSString *)calculateTimeinAMPM:(NSString *)fromString{
    NSDateFormatter *dateFormatter3 = [[NSDateFormatter alloc] init];
    [dateFormatter3 setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter3 setDateFormat:@"HH:mm:ss"];
    NSDate *date1 = [dateFormatter3 dateFromString:fromString];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"hh:mm a"];
    NSString * time = [formatter stringFromDate:date1];
    return time;
}

-(void)genderBtn:(UIButton *)btn corners:(UIRectCorner)corners{
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:btn.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(15.0, 15.0)];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.view.bounds;
    maskLayer.path  = maskPath.CGPath;
    btn.layer.mask = maskLayer;
}

-(void)addfeild:(UIView *)MainView textfeild:(RPFloatingPlaceholderTextField *)fld{
    [fld setFont:[UIFont fontWithName:@"Raleway" size:13]];
    fld.floatingLabelActiveTextColor = [UIColor lightGrayColor];
    [fld setTextColor:[UIColor TextColor_TxtFld]];//253,58,107
    [MainView addSubview:fld];
    
    UIView *feildUnderline = [UIView new];
    feildUnderline.backgroundColor = [UIColor lightGrayColor];
    feildUnderline.layer.cornerRadius = 5.0f;
    feildUnderline.frame = CGRectMake(fld.frame.origin.x, fld.frame.origin.y + fld.frame.size.height + 2 , fld.frame.size.width, 1);
    [MainView addSubview:feildUnderline];
}

-(void)addSlideAnimation:(UILabel *)line firstView:(UIView *)firstView secondView:(UIView *)secondView button1:(UIButton *)btn1 button2:(UIButton *)btn2 newX:(float)newX newY:(float)newY{
    // btn1.titleLabel.textColor = [UIColor TextColor_TxtFld];
    [btn1 setTitleColor:[UIColor TextColor_TxtFld] forState:UIControlStateNormal];
    btn2.titleLabel.textColor = [UIColor whiteColor];
    [UIView transitionWithView:line
                      duration:0.5f
                       options:UIViewAnimationCurveEaseInOut
                    animations:^(void) {
                        //hdr_Underline.center = CGPointMake(newX, newY);
                        line.frame = CGRectMake(newX, newY,btn1.frame.size.width , 2);
                    }
                    completion:^(BOOL finished) {
                        // Do nothing
                    }];
    secondView.hidden = TRUE;
    firstView.hidden = FALSE;
}

-(void)addlistingSlideAnimation:(UILabel *)line button1:(UIButton *)btn1{
    [UIView transitionWithView:line
                      duration:0.5f
                       options:UIViewAnimationCurveEaseInOut
                    animations:^(void) {
                        //hdr_Underline.center = CGPointMake(newX, newY);
                        line.frame = CGRectMake(btn1.frame.origin.x, line.frame.origin.y,btn1.frame.size.width , 3);
                    }
                    completion:^(BOOL finished) {
                        // Do nothing
                    }];

}

#pragma mark - Dashboard Methods
-(void)addLayer:(UIView *)MainView button1:(UIButton *)btn1 button2:(UIButton *)btn2 button3:(UIButton *)btn3 btn1title:(NSString *)btn1title btn2title:(NSString *)btn2title btn3title:(NSString *)btn3title{
    CALayer *ViewLayer = [MainView layer];
    [ViewLayer setMasksToBounds:NO ];
    [ViewLayer setShadowColor:[[UIColor lightGrayColor] CGColor]];
    [ViewLayer setShadowOpacity:1.0 ];
    [ViewLayer setShadowRadius:6.0 ];
    [ViewLayer setShadowOffset:CGSizeMake( 0 , 0 )];
    //[ViewLayer setShouldRasterize:YES];
    [ViewLayer setCornerRadius:5.0];
    [ViewLayer setBorderColor:[UIColor lightGrayColor].CGColor];
    [ViewLayer setBorderWidth:1.0];
    [ViewLayer setShadowPath:[UIBezierPath bezierPathWithRect:MainView.bounds].CGPath];
    
    [btn1 setTitle:btn1title forState:UIControlStateNormal];
    [btn2 setTitle:btn2title forState:UIControlStateNormal];
    [btn3 setTitle:btn3title forState:UIControlStateNormal];
    
    btn1.layer.cornerRadius = 5.0;
    btn3.layer.cornerRadius = 5.0;
    
}

#pragma mark - Color from Hex Methods
- (unsigned int)intFromHexString:(NSString *)hexStr
{
    unsigned int hexInt = 0;
    
    // Create scanner
    NSScanner *scanner = [NSScanner scannerWithString:hexStr];
    
    // Tell scanner to skip the # character
    [scanner setCharactersToBeSkipped:[NSCharacterSet characterSetWithCharactersInString:@"#"]];
    
    // Scan hex value
    [scanner scanHexInt:&hexInt];
    
    return hexInt;
}

- (UIColor *)getUIColorObjectFromHexString:(NSString *)hexStr alpha:(CGFloat)alpha
{
    // Convert hex string to an integer
    unsigned int hexint = [self intFromHexString:hexStr];
    
    // Create color object, specifying alpha as well
    UIColor *color =
    [UIColor colorWithRed:((CGFloat) ((hexint & 0xFF0000) >> 16))/255
                    green:((CGFloat) ((hexint & 0xFF00) >> 8))/255
                     blue:((CGFloat) (hexint & 0xFF))/255
                    alpha:alpha];
    
    return color;
}

-(void)resizeToFitSubviews:(UIView *)mainView
{
    float w = 0;
    float h = 0;
    
    for (UIView *v in [mainView subviews]) {
        float fw = (v.frame.origin.x + v.frame.size.width)+5;
        float fh = (v.frame.origin.y + v.frame.size.height)+5;
        w = MAX(fw, w);
        h = MAX(fh, h);
    }
    [mainView setFrame:CGRectMake(mainView.frame.origin.x, mainView.frame.origin.y, w, h)];
}

-(NSArray *)setDate:(NSString *)firstdate seconddate:(NSString *)seconddate{
    NSString * startdate,*enddate;
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
    [dateFormatter1 setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter1 setDateFormat:@"YYYY-MM-dd"];
    NSDate *date1 = [dateFormatter1 dateFromString:firstdate];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone localTimeZone]];
    [formatter setDateFormat:@"ddMMM"];
    startdate = [NSString stringWithFormat:@"%@ - ",[formatter stringFromDate:date1]];
    
    NSDate *date2 = [dateFormatter1 dateFromString:seconddate];
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
    [formatter1 setDateFormat:@"ddMMM YYYY"];
    enddate = [NSString stringWithFormat:@"%@ |",[formatter1 stringFromDate:date2]];
    NSArray *array = [NSArray arrayWithObjects:startdate, enddate, nil];
    return array;
}

-(NSArray *)setTime:(NSString *)firsttime secondtime:(NSString *)secondtime{
    NSString * starttime,*endtime;
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
    [dateFormatter1 setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter1 setDateFormat:@"HH:mm:ss"];
    NSDate *date1 = [dateFormatter1 dateFromString:firsttime];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"hh:mma"];
    starttime = [NSString stringWithFormat:@"%@",[formatter stringFromDate:date1]];
    
    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
    [dateFormatter2 setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter2 setDateFormat:@"HH:mm:ss"];
    NSDate *date2 = [dateFormatter2 dateFromString:secondtime];
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
    [formatter1 setDateFormat:@"hh:mma"];
    endtime = [NSString stringWithFormat:@"%@",[formatter1 stringFromDate:date2]];
    NSArray *array = [NSArray arrayWithObjects:starttime, endtime, nil];
    return array;
}


-(void)changeFrameWRT:(UIView *)mainView ofview:(UIView*)toview{
    float h = 0;
    float fh = (mainView.frame.origin.y + mainView.frame.size.height)+5;
    h = MAX(fh, h);
    [toview setFrame:CGRectMake(toview.frame.origin.x, h, toview.frame.size.width, toview.frame.size.height)];
}

-(void)changeFrameforDashboardWRT:(UIView *)mainView ofview:(UIView*)toview{
    float h = 0;
    float fh = (mainView.frame.origin.y + mainView.frame.size.height)+15;
    h = MAX(fh, h);
    [toview setFrame:CGRectMake(toview.frame.origin.x, h, toview.frame.size.width, toview.frame.size.height)];
}

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    [delegate autocomplete:self];
}

-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    //searchBar.frame = CGRectMake(0, 0, 320, 35);
}

#pragma mark - Lifecycle Methods
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)CCKFNavDrawerSelection:(NSInteger)selectionIndex
{
    NSLog(@"%li", (long)selectionIndex);
}

- (void)Drawer_Logout{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)logoutFunction{
    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
    [maindelegate.defaults setValue:@"19.1183" forKey:@"latitude"];
    [maindelegate.defaults setValue:@"73.0276" forKey:@"longitude"];
    //[delegate.defaults setValue:@"Mahape" forKey:@"loc_name"];
    [maindelegate.defaults setValue:@"3" forKey:@"radius"];
    ViewController *splash = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
    UINavigationController *passcodeNavigationController = [[UINavigationController alloc] initWithRootViewController:splash];
    [self presentViewController:passcodeNavigationController animated:YES completion:nil];
}


@end
