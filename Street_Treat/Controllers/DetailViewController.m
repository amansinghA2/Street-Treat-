//
//  DetailViewController.m
//  Street_Treat
//
//  Created by Kamlesh Dubey on 6/17/16.
//  Copyright (c) 2016 Digillence Rolson. All rights reserved.
//

#import "DetailViewController.h"

@implementation StoreDealsCell
@synthesize shortDealTitleLbl,longDealTitleLbl,ExpandBtn;
//@synthesize bucketListLbl,bucketListImg,bucketSelectView;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

@interface DetailViewController (){
    UIView *contentView;
    UPStackMenu *stack;
}

@end

@implementation DetailViewController
@synthesize DetailScroll,Promopagecontol,Promoscroll,promoArr,storeChecksCount,storeValidCouponsCount,reviewView,DetailsArr,storeOffersTbl,budgetSlider,amenitiesScroll,checkInBtn,offersLine1Lbl,offersAddLbl,offersLine2Lbl,budgetMetersView,AmenitiesView,DescriptionView;

@synthesize TimingsView,MondayTimeLbl,TuesdayTimeLbl,WednesdayTimeLbl,ThursdayTimeLbl,FridayTimeLbl,saturdayTimeLbl,sundayTimeLbl;

-(void)viewWillAppear:(BOOL)animated{
    if ([[delegate.defaults valueForKey:@"navigateFromReport"] isEqualToString:@"fromDetail"]){
        [self.view makeToast:@"Report Submitted Successfully"];
    }
    
    [delegate.defaults setObject:@"DetailViewController" forKey:@"internetdisconnect"];
    self.navigationController.navigationBarHidden =true;
    self.navigationItem.hidesBackButton = YES;
    
    self.rootNav = (CCKFNavDrawer *)self.navigationController;
    [self.rootNav setCCKFNavDrawerDelegate:self];
    store_ID = [[delegate.defaults valueForKey:@"store_ID"] intValue];
    NSLog(@"store_ID..%ld",store_ID);
    
    userLatitude = [[delegate.defaults valueForKey:@"latitude"] floatValue];
    userLongitude = [[delegate.defaults valueForKey:@"longitude"] floatValue];
    
    currentLatitude = [[delegate.defaults valueForKey:@"user_latitude"] floatValue];
    currentLongitude = [[delegate.defaults valueForKey:@"user_longitude"] floatValue];
    [commonclass setNavigationController:self.navigationController tabBarController:self.tabBarController];
    
    [self getStoreDetails];
    
    
}

-(void)updateMobile{
     if([commonclass isActiveInternet] == YES){
    responseType = @"UpdateMobile";
    NSString *messageBody = [NSString stringWithFormat:@"log_id=%@&mobile=%@",[delegate.defaults valueForKey:@"logid"],mobileFld.text];
    NSLog(@"body.. %@",messageBody);
    NSLog(@"commonclass.searchListURL.. %@",commonclass.updateMobileURL);
    [commonclass sendRequest:self.view mutableDta:miscdata url:commonclass.updateMobileURL msgBody:messageBody];
     }else{
         [commonclass Redirect:self.navigationController Identifier:@"InternetDisconnectViewController"];
         //[self.view makeToast:@"Check your internet connection"];
     }
}

-(void)viewDidAppear:(BOOL)animated{
    [self setUpstackMenu];
}

-(void)setUpstackMenu{
    contentView = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 60, self.view.frame.size.height +5, 35, 35)];
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
     UPStackMenuItem *shareItem = [[UPStackMenuItem alloc] initWithImage:[UIImage imageNamed:@"Download_Excel"] highlightedImage:[UIImage imageNamed:@"Download_Excel"] title:@"Add To Favourites"];
     UPStackMenuItem *addFavouritesItem = [[UPStackMenuItem alloc] initWithImage:[UIImage imageNamed:@"Download_Excel"] highlightedImage:[UIImage imageNamed:@"Download_Excel"] title:@"Share Store"];
    UPStackMenuItem *squareItem = [[UPStackMenuItem alloc] initWithImage:[UIImage imageNamed:@"Download_Excel"] highlightedImage:[UIImage imageNamed:@"Download_Excel"] title:@"View Favourites"];
    UPStackMenuItem *circleItem = [[UPStackMenuItem alloc] initWithImage:[UIImage imageNamed:@"Email_Excel"] highlightedImage:[UIImage imageNamed:@"Download_Excel"] title:@"Update Profile"];
    UPStackMenuItem *viewItem = [[UPStackMenuItem alloc] initWithImage:[UIImage imageNamed:@"Email_Excel"] highlightedImage:[UIImage imageNamed:@"Download_Excel"] title:@"Add Reviews"];
    
    NSMutableArray *items = [[NSMutableArray alloc] initWithObjects:shareItem,addFavouritesItem,squareItem, circleItem,viewItem, nil];
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
    flyoutView = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height/1.5, self.view.frame.size.width, self.view.frame.size.height/3)];
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
    if(index == 0){
        [self favouritesTapped:nil];
        //[self stackMenuWillClose:stack];
    }else  if(index == 1){
        [self shareTapped:nil];
    }else if(index == 2){
        [delegate.defaults setValue:@"Favourites" forKey:@"route"];
        [commonclass Redirect:self.navigationController Identifier:@"ResultsViewController"];
        
    }else if(index == 3){
        [commonclass Redirect:self.navigationController Identifier:@"ProfileViewController"];
    }else if (index == 4){
        
    }
    
    [stack closeStack];
   // [self setStackIconClosed:YES];
}

-(void)backTapped{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)getDealsatStore{
     if([commonclass isActiveInternet] == YES){
    // log_id,store_id,latitude,longitude,radius
    responseType = @"Deals";
    NSString *messageBody = [NSString stringWithFormat:@"log_id=%@&store_id=%ld",[delegate.defaults valueForKey:@"logid"],store_ID];
    NSLog(@"body.. %@",messageBody);
    NSLog(@"url.. %@",commonclass.getOffersURL);
    [commonclass sendRequest:self.view mutableDta:dealsData url:commonclass.getOffersURL msgBody:messageBody];
     }else{
         [commonclass Redirect:self.navigationController Identifier:@"InternetDisconnectViewController"];
         //[self.view makeToast:@"Check your internet connection"];
     }
}

-(void)getStoreDetails{
     if([commonclass isActiveInternet] == YES){
    // log_id,store_id,latitude,longitude,radius
    responseType = @"StoreDetails";
    NSString *messageBody = [NSString stringWithFormat:@"log_id=%@&store_id=%ld&latitude=%f&longitude=%f&current_latitude=%@&current_longitude=%@",[delegate.defaults valueForKey:@"logid"],store_ID,currentLatitude,currentLongitude,[delegate.defaults valueForKey:@"latitude"],[delegate.defaults valueForKey:@"longitude"]];
    NSLog(@"body.. %@",messageBody);
    NSLog(@"url.. %@",commonclass.getstoreDetailsURL);
    [commonclass sendRequest:self.view mutableDta:detailData url:commonclass.getstoreDetailsURL msgBody:messageBody];
     }else{
         [commonclass Redirect:self.navigationController Identifier:@"InternetDisconnectViewController"];
         //[self.view makeToast:@"Check your internet connection"];
     }
}

-(void)getAllStoreAmenities{
     if([commonclass isActiveInternet] == YES){
    responseType = @"getallAmenities";
    NSString *messageBody = [NSString stringWithFormat:@"mtype=%@",@"Amenities"];
    [commonclass sendRequest:self.view mutableDta:amenitiesData url:commonclass.getMastersURL msgBody:messageBody];
     }else{
         [commonclass Redirect:self.navigationController Identifier:@"InternetDisconnectViewController"];
         //[self.view makeToast:@"Check your internet connection"];
     }
}

-(void)setAmenities:(NSMutableArray *)amenities{
    NSLog(@"amenities arr in set amenities.. %@",amenities[0]);
    for(UIView * view in [amenitiesScroll subviews]){
        [view removeFromSuperview];
    }
   int btnwt = 85;
   // long int amenitiesCnt = amenitiesArr.count ;
    amenitiesScroll.contentSize = CGSizeMake(btnwt * amenitiesCnt, amenitiesScroll.frame.size.height);
    
    for (int k = 0; k < amenitiesCnt; k++) {
        UIView *cpnview = [[UIView alloc]initWithFrame:CGRectMake(85 * k, 0, 80,amenitiesScroll.frame.size.height)];
        cpnview.tag = k;
        //cpnview.backgroundColor = [UIColor redColor];
        UILabel * Cpndesclabel = [[UILabel alloc]initWithFrame:CGRectMake(2, 1, cpnview.frame.size.width-5, 30)];
        Cpndesclabel.numberOfLines = 0;
        
//        NSString *text = @"";
//        if([amenities[k] valueForKey:@"code"] != [NSNull null]) {
//           NSString * txt_i = [NSString stringWithFormat:@"%@",[amenities[k] valueForKey:@"code"]];
//            int hexVal = Integer.parseInt(txt_i, 16);
//            text += (char) hexVal;
//        }
        
        
       // NSString * fntcode = [NSString stringWithFormat:@"%c",[[amenities[k] valueForKey:@"font_code"] charValue]];
        
        [Cpndesclabel setFont:[UIFont fontWithName:@"fontello" size:26]];
        
        Cpndesclabel.textColor = [UIColor Tabbar_Color];
        Cpndesclabel.textAlignment = NSTextAlignmentCenter;
        
        NSString * fontcode = [self SetAmenitiesFont:[amenities[k] valueForKey:@"title"]];
        Cpndesclabel.text = fontcode;
        [cpnview addSubview:Cpndesclabel];
        
        UILabel * linelabel = [[UILabel alloc]initWithFrame:CGRectMake(5, (Cpndesclabel.frame.origin.y + Cpndesclabel.frame.size.height) + 1, 70, 1)];
        linelabel.backgroundColor = [UIColor View_Border];
        
        UILabel * typlabel = [[UILabel alloc]initWithFrame:CGRectMake(2, (Cpndesclabel.frame.origin.y + Cpndesclabel.frame.size.height) + 1, cpnview.frame.size.width, 25)];
        [typlabel setFont:[UIFont fontWithName:@"Roboto-Regular" size:9]];
        typlabel.textAlignment = NSTextAlignmentCenter;
        typlabel.numberOfLines = 0;
        typlabel.text = [[amenities[k] valueForKey:@"title"]uppercaseString];
        typlabel.textColor = [UIColor darkGrayColor];
        [cpnview addSubview:typlabel];
        [amenitiesScroll addSubview:cpnview];
    }
    
}

-(NSString *)SetAmenitiesFont:(NSString*)amenitiesType{
    NSString * fontcode;
    if([amenitiesType isEqualToString:@"Air Conditioned"]){
        fontcode = commonclass.amenitiesACIcon;
    }else if ([amenitiesType isEqualToString:@"Parking Available"]){
        fontcode = @"\ue091";
    }else if ([amenitiesType isEqualToString:@"Trial Rooms"]){
        fontcode = @"\ue089";
    }else if ([amenitiesType isEqualToString:@"Celebrity Frequented"]){
        fontcode = @"\ue088";
    }else if ([amenitiesType isEqualToString:@"Credit Card Accepted"]){
        fontcode = @"\ue015";
    }else if ([amenitiesType isEqualToString:@"Exchange Available"]){
        fontcode = @"\ue016";
    }else if ([amenitiesType isEqualToString:@"Cash Accepted"]){
        fontcode = @"\ue013";
    }else if ([amenitiesType isEqualToString:@"Alteration Available"]){
        fontcode = @"\ue012";
    }else if ([amenitiesType isEqualToString:@"Plus Sizes"]){
        fontcode = @"\ue090";
    }else if ([amenitiesType isEqualToString:@"Customization"]){
        fontcode = @"\ue080";
    }else if ([amenitiesType isEqualToString:@"Printed Bills"]){
        fontcode = @"\ue017";
    }
    return fontcode;
}

-(void)shareStore{
     if([commonclass isActiveInternet] == YES){
    responseType = @"shareStore";
    NSString *messageBody = [NSString stringWithFormat:@"log_id=%@&store_id=%ld",[delegate.defaults valueForKey:@"logid"],store_ID];
    NSLog(@"body.. %@",messageBody);
    NSLog(@"commonclass.searchListURL.. %@",commonclass.shareStoreURL);
    [commonclass sendRequest:self.view mutableDta:miscdata url:commonclass.shareStoreURL msgBody:messageBody];
     }else{
         [commonclass Redirect:self.navigationController Identifier:@"InternetDisconnectViewController"];
         //[self.view makeToast:@"Check your internet connection"];
     }
}

- (void)viewDidLoad {
    [super viewDidLoad];
   // [delegate.defaults setValue:@"a" forKey:@"navigateFromReport"];
    commonclass = [[Common alloc]init];
    commonclass.delegate = self;
    delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    //[commonclass addNavigationBar:self.view];
    detailData = [[NSMutableData alloc]init];
    dealsData = [[NSMutableData alloc]init];
    amenitiesData = [[NSMutableData alloc]init];
    dataDetails = [[NSMutableArray alloc]init];
    miscdata = [[NSMutableData alloc]init];
    dealsArr = [[NSMutableArray alloc]init];
    amenitiesArr = [[NSMutableArray alloc]init];
    deatilsArr = [[NSMutableArray alloc]init];
    imagesList = [[NSMutableArray alloc]init];
    checkinsData = [[NSMutableData  alloc]init];
    backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(5, 5, 30, 30);
    [backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backBtn.titleLabel setFont:[UIFont fontWithName:@"fontello" size:25]];
    [backBtn setTitle:commonclass.backIcon forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backTapped) forControlEvents:UIControlEventTouchUpInside];
    backBtn.layer.shadowRadius = 1.5f;
    backBtn.layer.shadowColor = [UIColor blackColor].CGColor;
    backBtn.layer.shadowOffset = CGSizeMake(0.0f, 1.0f);
    backBtn.layer.shadowOpacity = 0.5f;
    backBtn.layer.masksToBounds = NO;
    
    [self.view addSubview:backBtn];
    
    
    UIButton *back = (UIButton *)[self.view viewWithTag:1111];
    [back addTarget:self action:@selector(backTapped) forControlEvents:UIControlEventTouchUpInside];
    UIButton *notifications = (UIButton *)[self.view viewWithTag:222];
    [notifications addTarget:self action:@selector(notificationsTapped) forControlEvents:UIControlEventTouchUpInside];
    UIButton *Menu = (UIButton *)[self.view viewWithTag:111];
    [Menu addTarget:self action:@selector(MenuToggle) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *current_Loc = (UIButton *)[self.view viewWithTag:444];
    current_Loc.hidden = TRUE;
    
    UISearchBar * search = (UISearchBar *)[self.view viewWithTag:11111];
    search.hidden = TRUE;
    
    [self setupMobileVerificationPopup];
    Popupmainview.hidden = true;
    OTPView.hidden = true;
    
    DtlcheckInBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    DtlcheckInBtn.frame = CGRectMake(self.view.frame.size.width - 115, self.view.frame.size.height - 100, 130, 35);
    DtlcheckInBtn.backgroundColor = [UIColor redColor];
    DtlcheckInBtn.layer.cornerRadius = 18.0f;
    [DtlcheckInBtn setTitle:@"CHECK IN" forState:UIControlStateNormal];
    [DtlcheckInBtn.titleLabel setFont:[UIFont fontWithName:@"Roboto-Bold" size:15]];
    [DtlcheckInBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [DtlcheckInBtn addTarget:self action:@selector(checkInTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:DtlcheckInBtn];
    
     [self.view bringSubviewToFront:DtlcheckInBtn];
    
//    NSData *data = [delegate.defaults valueForKey:@"StoreCheckedIn"];
//    DetailsArr = [NSKeyedUnarchiver unarchiveObjectWithData:data];
//    NSLog(@"Data... %@",DetailsArr);
    
    //[self Setdata];
    
    
   /* NSString *messageBody = [NSString stringWithFormat:@"log_id=%@&latitude=%@&longitude=%@&radius=%@&store_id=%@",[delegate.defaults valueForKey:@"logid"],[delegate.defaults valueForKey:@"latitude"],[delegate.defaults valueForKey:@"longitude"],[delegate.defaults valueForKey:@"radius"],[delegate.defaults valueForKey:@"store_ID"]];
    NSLog(@"commonclass.storeDetailURL.. %@",commonclass.storeDetailURL);
    NSLog(@"body.. %@",messageBody);
    [commonclass sendRequest:self.view mutableDta:detailData url:commonclass.storeDetailURL msgBody:messageBody];*/
   
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

- (void)customIOS7dialogButtonTouchUpInside: (CustomIOSAlertView *)alertView clickedButtonAtIndex: (NSInteger)buttonIndex
{
    NSLog(@"Delegate: Button at position %d is clicked on alertView %d.", (int)buttonIndex, (int)[alertView tag]);
    [alertView close];
}


- (UIView *)createDemoView:(NSString *)sender senderTag:(int)tag tapGesture:(UITapGestureRecognizer *)sender1
{
    UIScrollView *scroll;
    scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height - 50)];
    demoView = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height)];
    demoView.backgroundColor = [UIColor whiteColor];
    UIButton *closeButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [closeButton1 setFrame:CGRectMake(demoView.frame.origin.x,self.view.frame.size.height - 50 , demoView.frame.size.width, 50)];
    [closeButton1 setTitle:@"Close" forState:UIControlStateNormal];
    [closeButton1 setBackgroundColor:[UIColor redColor]];
    [closeButton1 addTarget:self action:@selector(closeTapped:) forControlEvents:UIControlEventTouchUpInside];
    scroll.contentSize = CGSizeMake(scroll.frame.size.width * (imgcnt), scroll.frame.size.height - 50);
     for (tag = 0 ; tag < imgcnt ;tag++){
        CGRect frame;
        frame.origin.x = scroll.frame.size.width * (tag);
        frame.origin.y = 0;
        frame.size = scroll.frame.size;
        UIImageView* imageView = [[UIImageView alloc] init];
        imageView.frame = frame;
        //    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        //        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(demoView.frame.origin.x,        demoView.frame.origin.y, demoView.frame.size.width, demoView.frame.size.height - 50)];
         NSString * imglink = [NSString stringWithFormat:@"%@/%@",commonclass.siteURL,[dataDetails valueForKey:@"images"][tag]];
         [imageView setContentMode:UIViewContentModeScaleAspectFit];
         imageView.clipsToBounds = YES;
        [imageView setImageWithURL:[NSURL URLWithString:imglink] placeholderImage:[UIImage imageNamed:@""] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        //    [imageView setImage:[UIImage imageNamed:@"demo"]];
        //    [demoView addSubview:imageView];
        //    [demoView addSubview:closeButton];
        [scroll addSubview:imageView];
        //        [scroll addSubview:closeButton1];
        //        [scroll bringSubviewToFront:closeButton1];
    [demoView addSubview:scroll];
    }
    [demoView addSubview:closeButton1];
    [demoView bringSubviewToFront:closeButton1];
    return demoView;
    
}


-(void)closeTapped:(UIButton *)sender{
    [demoView removeFromSuperview];
}

-(void)selectImage:(UITapGestureRecognizer *)sender{
    
   NSString * imglink = [NSString stringWithFormat:@"%@/%@",commonclass.siteURL,[dataDetails valueForKey:@"images"][sender.view.tag]];
    
   [self.view addSubview:[self createDemoView:imglink senderTag:sender.view.tag tapGesture:sender]];
}

-(void)Setdata:(NSMutableArray*)details{
    NSLog(@"details.. %@",details);
 
   if([details valueForKey:@"images"] != [NSNull null]){
    dataDetails = details;
   imgcnt = [[details valueForKey:@"images"] count];
   Promoscroll.contentSize = CGSizeMake(Promoscroll.frame.size.width * imgcnt, Promoscroll.frame.size.height);
    
    for (int j = 0; j < imgcnt; j++) {
        Promoscroll.backgroundColor = [UIColor whiteColor];
        NSString * imglink = [NSString stringWithFormat:@"%@/%@",commonclass.siteURL,[details valueForKey:@"images"][j]];
        [imagesList addObject:imglink];
        imgLink1 = imglink;
        CGRect frame;
        frame.origin.x = Promoscroll.frame.size.width * j;
        frame.origin.y = 0;
        frame.size = Promoscroll.frame.size;
        UIImageView* imgView = [[UIImageView alloc] init];
        imgView.frame = frame;
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectImage:)];
        tapRecognizer.delegate = self;
        imgView.tag = j;
        [imgView addGestureRecognizer:tapRecognizer];
        imgView.userInteractionEnabled = YES;
        [imgView setContentMode:UIViewContentModeScaleAspectFit];
        imgView.clipsToBounds = YES;
        [imgView setImageWithURL:[NSURL URLWithString:imglink] placeholderImage:[UIImage imageNamed:@""] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [Promoscroll addSubview:imgView];
        Promoscroll.tag = 1;
        DetailScroll.tag = 2;
    }
    
    Promopagecontol.currentPage = 0;
    Promopagecontol.numberOfPages = imgcnt;
    [DetailScroll bringSubviewToFront:Promopagecontol];
    [Promoscroll bringSubviewToFront:backBtn];
   }
    
    DetailScroll.contentSize = CGSizeMake(self.view.frame.size.width,reviewView.frame.origin.y);
    
    _storeName.text = [details valueForKey:@"store_name"];
    [delegate.defaults setValue:[details valueForKey:@"store_name"] forKey:@"Store_Name"];
    [delegate.defaults synchronize];
    _storeAddress.text = [NSString stringWithFormat:@"%@, %@",[details valueForKey:@"address_1"],[details valueForKey:@"address_2"]];
    if(([details valueForKey:@"parent_categories"] == [NSNull null])){
        _storeShopForLbl.text = @"0";
    }else{
        // NSString * shopforLbl =
        NSArray * shpArr = [details valueForKey:@"parent_categories"];
        if(shpArr.count==1){
            _storeShopForLbl.text = [NSString stringWithFormat:@"%@ ",shpArr[0]];
        }else if (shpArr.count==2){
            _storeShopForLbl.text = [NSString stringWithFormat:@"%@ | %@ ",shpArr[0],shpArr[1]];
        }else{
            _storeShopForLbl.text = [NSString stringWithFormat:@"%@ | %@ | %@",shpArr[0],shpArr[1],shpArr[2]];
        }
    }
    
    _storeAwayIconLbl.text = commonclass.storeawayIcon;
    _storeAwayIconLbl.userInteractionEnabled = YES;
    
   // NSString * time;
   
    if([details valueForKey:@"start_time"] == [NSNull null] && [details valueForKey:@"end_time"] == [NSNull null]){
        _storeTimeLbl.backgroundColor = [UIColor redColor];
        time = @"Closed";
        _storeTimeLbl.textAlignment = NSTextAlignmentCenter;
    }else{
        _storeTimeLbl.backgroundColor = [UIColor greenColor];
        NSString * startTime = [commonclass calculateTimeinAMPM:[details valueForKey:@"start_time"]];
        NSString * endTime = [commonclass calculateTimeinAMPM:[details valueForKey:@"end_time"]];
        time = [NSString stringWithFormat:@"%@-%@",startTime,endTime];
    }
    _storeTimeLbl.text = time;
    
    UITapGestureRecognizer *gestureRecognizerTime = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(MoveToTimeTapped:)];
    [_storeTimeLbl addGestureRecognizer:gestureRecognizerTime];
    
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(MoveToMapTapped:)];
    [_storeAwayIconLbl addGestureRecognizer:gestureRecognizer];
    
    awayDist = [details valueForKey:@"distance_in_kms"];
    _storeAwayLbl.text = [NSString stringWithFormat:@"%.2f Kms away  ",[awayDist doubleValue]];
    
    storeValidCouponsCount.text = [details valueForKey:@"valid_coupon"];
    storeChecksCount.text = [details valueForKey:@"checkins"];
    _storeStreetOffersLbl.text = [NSString stringWithFormat:@"%@ %% Street Treat Offers",[details valueForKey:@"exclusive_discount"]];
    if([details valueForKey:@"rating"] == [NSNull null]){
        _storeRatingLbl.text = @"0";
        _storeStarsLbl.text = commonclass.emptystarIcon;
    }else{
        _storeRatingLbl.text = [NSString stringWithFormat:@"%.1f",[[details valueForKey:@"rating"] floatValue]];
        [self setratingsLbl:[[details valueForKey:@"rating"]intValue] label:_storeStarsLbl];
    }
    [_shareButton setTitle:commonclass.shareIcon forState:UIControlStateNormal];
    
    if([[details valueForKey:@"is_favorite"]intValue] == 1){
        [_addTofavouritesBtn setTitle:commonclass.addedtofavouritesIcon forState:UIControlStateNormal];
        [_addTofavouritesBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }else{
        [_addTofavouritesBtn setTitle:commonclass.addtofavouritesIcon forState:UIControlStateNormal];
    }
    
    [self setbudgetMeter:[details valueForKey:@"budget_meter"] slider:budgetSlider];
    
    _storeDescLbl.text = [details valueForKey:@"description"];
    
    amenitiesCnt = [[details valueForKey:@"amenities"] count];
    NSLog(@"amenities.. %@",[details valueForKey:@"amenities"]);
    
    [self setAmenities:[details valueForKey:@"amenities"]];
    
    _votesCount.text = [NSString stringWithFormat:@"%@ Votes |",[details valueForKey:@"no_of_votes"]];
    
    NSString * MonstartTime = [commonclass calculateTimeinAMPM:[details valueForKey:@"Monday_start_time"]];
    NSString * MonendTime = [commonclass calculateTimeinAMPM:[details valueForKey:@"Monday_end_time"]];
    
    if(MonstartTime.length == 0 && MonendTime.length == 0){
        MondayTimeLbl.text = @"NA";
    }else{
        MondayTimeLbl.text = [NSString stringWithFormat:@"%@ To %@",MonstartTime,MonendTime];
    }
    
    NSString * TuestartTime = [commonclass calculateTimeinAMPM:[details valueForKey:@"Tuesday_start_time"]];
    NSString * TueendTime = [commonclass calculateTimeinAMPM:[details valueForKey:@"Tuesday_end_time"]];
    
    if(TuestartTime.length == 0 && TueendTime.length == 0){
        TuesdayTimeLbl.text = @"NA";
    }else{
        TuesdayTimeLbl.text = [NSString stringWithFormat:@"%@ To %@",TuestartTime,TueendTime];
    }
    
    NSString * WedstartTime = [commonclass calculateTimeinAMPM:[details valueForKey:@"Wednesday_start_time"]];
    NSString * WedendTime = [commonclass calculateTimeinAMPM:[details valueForKey:@"Wednesday_end_time"]];
    
    if(WedstartTime.length == 0 && WedendTime.length == 0){
        WednesdayTimeLbl.text = @"NA";
    }else{
        WednesdayTimeLbl.text = [NSString stringWithFormat:@"%@ To %@",WedstartTime,WedendTime];
    }
    
    NSString * ThursstartTime = [commonclass calculateTimeinAMPM:[details valueForKey:@"Thursday_start_time"]];
    NSString * ThursendTime = [commonclass calculateTimeinAMPM:[details valueForKey:@"Tuesday_end_time"]];
    
    if(ThursstartTime.length == 0 && ThursendTime.length == 0){
        ThursdayTimeLbl.text = @"NA";
    }else{
        ThursdayTimeLbl.text = [NSString stringWithFormat:@"%@ To %@",ThursstartTime,ThursendTime];
    }
    
    NSString * FristartTime = [commonclass calculateTimeinAMPM:[details valueForKey:@"Friday_start_time"]];
    NSString * FriendTime = [commonclass calculateTimeinAMPM:[details valueForKey:@"Friday_end_time"]];
    
    if(FristartTime.length == 0 && FriendTime.length == 0){
        FridayTimeLbl.text = @"NA";
    }else{
        FridayTimeLbl.text = [NSString stringWithFormat:@"%@ To %@",FristartTime,FriendTime];
    }
    
    NSString * SatstartTime = [commonclass calculateTimeinAMPM:[details valueForKey:@"Saturday_start_time"]];
    NSString * SatendTime = [commonclass calculateTimeinAMPM:[details valueForKey:@"Saturday_end_time"]];
    
    if(SatstartTime.length == 0 && SatendTime.length == 0){
        saturdayTimeLbl.text = @"NA";
    }else{
        saturdayTimeLbl.text = [NSString stringWithFormat:@"%@ To %@",SatstartTime,SatendTime];
    }
    
    NSString * SunstartTime = [commonclass calculateTimeinAMPM:[details valueForKey:@"Sunday_start_time"]];
    NSString * SunendTime = [commonclass calculateTimeinAMPM:[details valueForKey:@"Sunday_end_time"]];
    
    if(SunstartTime.length == 0 && SunendTime.length == 0){
        sundayTimeLbl.text = @"NA";
    }else{
        sundayTimeLbl.text = [NSString stringWithFormat:@"%@ To %@",SunstartTime,SunendTime];
    }
    
    
    if([[details valueForKey:@"checked_in"] intValue] == 1 && [[details valueForKey:@"can_review"] intValue] == 1){
        DtlcheckInBtn.backgroundColor = [UIColor Tabbar_Color];
        [DtlcheckInBtn setTitle:@"CHECKED IN" forState:UIControlStateNormal];
    }else if([[details valueForKey:@"checked_in"] intValue] == 1 && [[details valueForKey:@"can_review"] intValue] == 0){
        DtlcheckInBtn.backgroundColor = [UIColor Tabbar_Color];
        [DtlcheckInBtn setTitle:@"CHECKED IN" forState:UIControlStateNormal];
    }else if([[details valueForKey:@"checked_in"] intValue] == 0 && [[details valueForKey:@"can_review"] intValue] == 1){
        DtlcheckInBtn.backgroundColor = [UIColor redColor];
        [DtlcheckInBtn setTitle:@"CHECK IN" forState:UIControlStateNormal];
    }else if([[details valueForKey:@"checked_in"] intValue] == 0 && [[details valueForKey:@"can_review"] intValue] == 0){
        DtlcheckInBtn.backgroundColor = [UIColor redColor];
        [DtlcheckInBtn setTitle:@"CHECK IN" forState:UIControlStateNormal];
    }
}

-(void)MoveToTimeTapped:(UIGestureRecognizer *)recognizer{
    CGPoint bottomOffset = CGPointMake(0, DetailScroll.contentSize.height - DetailScroll.bounds.size.height);
    [DetailScroll setContentOffset:bottomOffset animated:YES];

}

-(void)MoveToMapTapped:(UIGestureRecognizer*)recognizer{
    
    NSString * directionLat = [deatilsArr valueForKey:@"latitude"];
    NSString * directionLong = [deatilsArr valueForKey:@"longitude"];
    
    [delegate.defaults setValue:directionLat forKey:@"directionLat"];
    [delegate.defaults setValue:directionLong forKey:@"directionLong"];
    [delegate.defaults synchronize];
    [commonclass Redirect:self.navigationController Identifier:@"DirectionViewController"];
}

-(void)setratingsLbl:(int)rating label:(UILabel*)rateLbl{
    rateLbl.textAlignment = NSTextAlignmentCenter;
    NSLog(@"rating.. %d",rating);
    if(rating == 0){
         _storeRatingLbl.text = @"0";
        rateLbl.text = commonclass.emptystarIcon;
        rateLbl.font = [UIFont fontWithName:@"fontello" size:15.0f];
    }else if(rating == 1){
        rateLbl.text = commonclass.starIcon;
        rateLbl.font = [UIFont fontWithName:@"fontello" size:15.0f];
    }else if (rating == 2){
        rateLbl.text = commonclass.twostarIcon;
        rateLbl.font = [UIFont fontWithName:@"fontello" size:35.0f];
    }else if (rating == 3){
        rateLbl.text = commonclass.threestarIcon;
        rateLbl.font = [UIFont fontWithName:@"fontello" size:45.0f];
    }else if (rating == 4){
        rateLbl.text = commonclass.fourstarIcon;
        rateLbl.font = [UIFont fontWithName:@"fontello" size:55.0f];
    }else if (rating == 5){
        rateLbl.text = commonclass.fivestarIcon;
        rateLbl.font = [UIFont fontWithName:@"fontello" size:90.0f];
    }
}

-(void)setbudgetMeter:(NSString *)val slider:(UISlider*)slider{
    if([val isEqualToString:@"Low"]){
        slider.value = 0.0f;
    }else if ([val isEqualToString:@"Medium"]){
        slider.value = 0.5f;
    }else if ([val isEqualToString:@"High"]){
        slider.value = 1.0f;
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

//- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region{
//    // Show an alert or otherwise notify the user
//}
//
//- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region{
//    
//}
//
//- (void)locationManager:(CLLocationManager *)manager monitoringDidFailForRegion:(CLRegion *)region withError:(NSError *)error{
//    
//}
//
//-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
//{
//    NSString * latstring = [NSString stringWithFormat:@"%f", locationManager.location.coordinate.latitude];
//    NSString * longstring = [NSString stringWithFormat:@"%f", locationManager.location.coordinate.longitude];
//    //CLPlacemark *placemark;
//    
//    CLGeocoder *geocoder = [[CLGeocoder alloc] init] ;
//    [geocoder reverseGeocodeLocation:self->locationManager.location
//                   completionHandler:^(NSArray *placemarks, NSError *error) {
//                       NSLog(@"reverseGeocodeLocation:completionHandler: Completion Handler called!");
//                       
//                       if (error){
//                           NSLog(@"Geocode failed with error: %@", error);
//                           return;
//                           
//                       }
//                       
//                       CLPlacemark *placemark = [placemarks objectAtIndex:0];
//                       
//                       //     NSLog(@"placemark.ISOcountryCode %@",placemark.ISOcountryCode);
//                       //     NSLog(@"placemark.country %@",placemark.country);
//                       //     NSLog(@"placemark.locality %@",placemark.locality );
//                       //     NSLog(@"placemark.postalCode %@",placemark.postalCode);
//                       //     NSLog(@"placemark.administrativeArea %@",placemark.administrativeArea);
//                       //     NSLog(@"placemark.locality %@",placemark.subLocality);
//                       locality = [NSString stringWithFormat:@"%@",placemark.subLocality];
//                       //     NSLog(@"placemark.subLocality %@",placemark.subLocality);
//                       //     NSLog(@"placemark.subThoroughfare %@",placemark.subThoroughfare);
//                       
//                   }];
//    
//    // NSLog(@"Locality.. %@",locality);
//    
//    [delegate.defaults setValue:latstring forKey:@"latitude"];
//    [delegate.defaults setValue:longstring forKey:@"longitude"];
//    
//    currentLatitude = [[delegate.defaults valueForKey:@"latitude"] floatValue];
//    currentLongitude = [[delegate.defaults valueForKey:@"longitude"] floatValue];
//    //    if([[[defaults dictionaryRepresentation] allKeys] containsObject:@"loc_name"]){
//    //        NSLog(@"mykey found");
//    //    }else{
//   // [delegate.defaults setValue:locality forKey:@"loc_name"];
//    [delegate.defaults setValue:@"myloc" forKey:@"locupdatefrom"];
//    [delegate.defaults setValue:locality forKey:@"myloc_name"];
//    //}
//    [delegate.defaults synchronize];
//}

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

- (void)sendResponse:(Common *)response data:(NSMutableArray*)data indicator:(UIActivityIndicatorView *)indicator{
    dispatch_sync(dispatch_get_main_queue(), ^{
        if(data != NULL){
            
            if([responseType isEqualToString:@"CheckedIn"]){
                
                if([[data valueForKey:@"status"]intValue] == 1){
                    [commonclass Redirect:self.navigationController Identifier:@"GenerateCouponsViewController"];
                }else if([[data valueForKey:@"status"]intValue] == -1){
                    [commonclass logoutFunction];
                    
                }else{
                    [self.view makeToast:[data valueForKey:@"message"]];
                }
                
            }
            else if([responseType isEqualToString:@"StoreDetails"]){
                [deatilsArr removeAllObjects];
                if([[data valueForKey:@"status"]intValue] == 1){
                    deatilsArr = [data valueForKey:@"items"];
                    NSLog(@"data.. %@",deatilsArr);
                    [self Setdata:deatilsArr];
                    [self getDealsatStore];
                }else if([[data valueForKey:@"status"]intValue] == -1){
                    [commonclass logoutFunction];
                }
            }
            else if([responseType isEqualToString:@"Deals"]){
                NSLog(@"data.. %@",data);
                if([[data valueForKey:@"status"]intValue] == 1){
                    dealsArr = [data valueForKey:@"items"];
                  //[self getAllStoreAmenities];
                    [storeOffersTbl reloadData];
              
                     DetailScroll.contentSize = CGSizeMake(DetailScroll.frame.size.width, (reviewView.frame.origin.y + reviewView.frame.size.height) + 5);
        
                    
                }else if([[data valueForKey:@"status"]intValue] == -1){
                    [commonclass logoutFunction];
                }else{
                    CGRect newFrame = _StoreOffersView.frame;
                    newFrame.size.width = _StoreOffersView.frame.size.width;
                    newFrame.size.height = 60;
                    [_StoreOffersView setFrame:newFrame];
                    storeOffersTbl.hidden = TRUE;
                    offersLine1Lbl.hidden = TRUE;
                    offersLine2Lbl.hidden = TRUE;
                    offersAddLbl.hidden = TRUE;
                    
                    [commonclass changeFrameWRT:_StoreOffersView ofview:budgetMetersView];
                    [commonclass changeFrameWRT:budgetMetersView ofview:AmenitiesView];
                    [commonclass changeFrameWRT:AmenitiesView ofview:DescriptionView];
                    [commonclass changeFrameWRT:DescriptionView ofview:TimingsView];
                    [commonclass changeFrameWRT:TimingsView ofview:reviewView];
                   // [DetailScroll bringSubviewToFront:reviewView];
                    DetailScroll.contentSize = CGSizeMake(DetailScroll.frame.size.width, (reviewView.frame.origin.y + reviewView.frame.size.height) + 5);
                }
            }else if([responseType isEqualToString:@"getallAmenities"]){
                if([[data valueForKey:@"status"]intValue] == 1){
                    NSLog(@"data.. %@",data);
                    amenitiesArr = [data valueForKey:@"items"];
                   // [self setAmenities];
                }else if([[data valueForKey:@"status"]intValue] == -1){
                    [commonclass logoutFunction];
                }
            }else if([responseType isEqualToString:@"shareStore"]){
                NSLog(@"data.. %@",data);
            }else if([responseType isEqualToString:@"AddFavourite"]){
                if([[data valueForKey:@"status"]intValue] == 1){
                    if ([[data valueForKey:@"items"]boolValue] == true) {
                        [self.view makeToast:@"The store has been added to your Favourites list" duration:4.0 position:CSToastPositionBottom];
                        [_addTofavouritesBtn setTitle:commonclass.addedtofavouritesIcon forState:UIControlStateNormal];
                        backBtn.enabled = true;
                    }else if([[data valueForKey:@"status"]intValue] == -1){
                        [commonclass logoutFunction];
                    }else{
                        [self.view makeToast:@"The store has been removed from your Favourites list" duration:4.0 position:CSToastPositionBottom];
                        [_addTofavouritesBtn setTitle:commonclass.addtofavouritesIcon forState:UIControlStateNormal];
                        backBtn.enabled = true;
                    }
                }else{
//                    [self.view makeToast:@"The store has been removed from your Favourites list" duration:4.0 position:CSToastPositionBottom];
//                    [_addTofavouritesBtn setTitle:commonclass.addtofavouritesIcon forState:UIControlStateNormal];
//                    backBtn.enabled = true;
                }

//                if([[data valueForKey:@"status"]intValue] == 1){
//                    [self.view makeToast:@"The store has been added to your Favourites list" duration:4.0 position:CSToastPositionBottom];
//                }else{
//                    [self.view makeToast:[data valueForKey:@"message"] duration:4.0 position:CSToastPositionBottom];
//                }
            } else if([responseType isEqualToString:@"UpdateMobile"]){
                if([[data valueForKey:@"status"]intValue] == 1){
                    NSString * mobile = mobileFld.text;
                    [delegate.defaults setValue:mobile forKey:@"mobile"];
                    [delegate.defaults synchronize];
                    [self ValidateOTP];
                }else if([[data valueForKey:@"status"]intValue] == -1){
                    [commonclass logoutFunction];
                }else{
                    [self.view makeToast:[data valueForKey:@"message"]];
                }
            }
            else if([responseType isEqualToString:@"UpdateOTP"]){
                if([[data valueForKey:@"status"]intValue] == 1){
                    Popupmainview.hidden = true;
                    [self.view makeToast:[data valueForKey:@"message"]];
                }else if([[data valueForKey:@"status"]intValue] == -1){
                    [commonclass logoutFunction];
                }else{
                    [self.view makeToast:[data valueForKey:@"message"]];
                }
            }
        }
        [indicator stopAnimating];
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    });
}

-(void)setupDetails:(NSMutableArray *)arr{
    NSLog(@"arr %@",arr);
    self.storeName.text = [NSString stringWithFormat:@"%@",[[[arr valueForKey:@"items"] valueForKey:@"Details"][0] valueForKey:@"name"]];
    self.storeAddress.text = [NSString stringWithFormat:@"%@",[[[arr valueForKey:@"items"] valueForKey:@"Details"][0] valueForKey:@"address"]];
    //self.storeStarsLbl.text = commonclass.starIcon;
    //self.storeRatingLbl.text = [NSString stringWithFormat:@"%@",[arr[indexpath.row] valueForKey:@"rating"]];
    NSString * shopforLbl = [[[arr valueForKey:@"items"] valueForKey:@"Details"][0] valueForKey:@"shop_for"];
    NSArray * shpArr = [shopforLbl componentsSeparatedByString:@","];
    if(shpArr.count==1){
        self.storeShopForLbl.text = [NSString stringWithFormat:@"%@ ",shpArr[0]];
    }else if (shpArr.count==2){
        self.storeShopForLbl.text = [NSString stringWithFormat:@"%@ | %@ ",shpArr[0],shpArr[1]];
    }else{
        self.storeShopForLbl.text = [NSString stringWithFormat:@"%@ | %@ | %@",shpArr[0],shpArr[1],shpArr[2]];
    }
    NSString * starttimetemp = [[[arr valueForKey:@"items"] valueForKey:@"Details"][0] valueForKey:@"start_time"];
    NSString * endtimetemp = [[[arr valueForKey:@"items"] valueForKey:@"Details"][0] valueForKey:@"end_time"];
    
    NSArray *timearr=[commonclass setTime:starttimetemp secondtime:endtimetemp];
    self.storeTimeLbl.text = [NSString stringWithFormat:@"%@ | %@",timearr[0],timearr[1]];
    
    self.storeAwayIconLbl.text = commonclass.storeawayIcon;
    awayDist = [[[arr valueForKey:@"items"] valueForKey:@"Details"][0] valueForKey:@"distance_in_kms"];
    self.storeAwayLbl.text = [NSString stringWithFormat:@"%.2f Kms away  ",[awayDist doubleValue]];
    self.storeChecksCount.text = [NSString stringWithFormat:@"%@",[[[arr valueForKey:@"items"] valueForKey:@"Details"][0] valueForKey:@"no_of_checkins"]];
     self.storeValidCouponsCount.text = [NSString stringWithFormat:@"%@",[[[arr valueForKey:@"items"] valueForKey:@"Details"][0] valueForKey:@"accepted_coupons"]];
    [self.shareButton setTitle:commonclass.shareIcon forState:UIControlStateNormal];
    [self.addTofavouritesBtn setTitle:commonclass.addtofavouritesIcon forState:UIControlStateNormal];//
    self.votesCount.text = [NSString stringWithFormat:@"%@ Votes ",[[[arr valueForKey:@"items"] valueForKey:@"Details"][0] valueForKey:@"no_of_votes"]];
    self.storeRatingLbl.text = [NSString stringWithFormat:@"%@",[[[arr valueForKey:@"items"] valueForKey:@"Details"][0] valueForKey:@"rating"]];
    self.storeStarsLbl.text =commonclass.addtofavouritesIcon;
    //self.
}

- (void)scrollViewDidScroll:(UIScrollView *)sender {
    
    float scrollViewHeight = sender.frame.size.height;
    float scrollContentSizeHeight = sender.contentSize.height;
    float scrollOffset = sender.contentOffset.y;
    
    if (sender.tag == 2){
        if (scrollOffset <= 0)
        {
            DtlcheckInBtn.hidden = false;
            //checkInBtn.hidden = false;
            
        }else{
            DtlcheckInBtn.hidden = true;
            //        checkInBtn.layer.backgroundColor = [[UIColor whiteColor] CGColor];
            //        [checkInBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
    }
    
    if (!pageControlBeingUsed) {
        // Switch the indicator when more than 50% of the previous/next page is visible
        CGFloat pageWidth = Promoscroll.frame.size.width;
        int page = floor((Promoscroll.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
        Promopagecontol.currentPage = page;
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
  
    pageControlBeingUsed = NO;
}


-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    DtlcheckInBtn.hidden = false;
}

-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    DtlcheckInBtn.hidden = true;
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    DtlcheckInBtn.hidden = false;
    pageControlBeingUsed = NO;
}

- (IBAction)shareTapped:(id)sender {
    [self shareStore];
    NSString *textToShare = [NSString stringWithFormat:@"Check out this %@ store on Street Treat App here",[delegate.defaults valueForKey:@"Store_Name"]];
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
    [activityVC setValue:@"Check out this Awesome app" forKey:@"subject"];
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

- (IBAction)favouritesTapped:(id)sender{
    [sender setTitle:commonclass.addtofavouritesIcon forState:UIControlStateNormal];
    //[sender setTitleColor:[UIColor redColor]];
    [self AddtoFavourites];
}

-(void)AddtoFavourites{
     if([commonclass isActiveInternet] == YES){
    responseType = @"AddFavourite";
    NSString *messageBody = [NSString stringWithFormat:@"log_id=%@&store_id=%ld",[delegate.defaults valueForKey:@"logid"],store_ID];
    NSLog(@"body.. %@",messageBody);
    NSLog(@"commonclass.searchListURL.. %@",commonclass.AddfavouritesURL);
    [commonclass sendRequest:self.view mutableDta:miscdata url:commonclass.AddfavouritesURL msgBody:messageBody];
     }else{
         [commonclass Redirect:self.navigationController Identifier:@"InternetDisconnectViewController"];
         //[self.view makeToast:@"Check your internet connection"];
     }
}

- (IBAction)viewReviewsTapped:(id)sender {
    ViewReviewsViewController * viewReviews = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewReviewsViewController"];
    [self.navigationController pushViewController:viewReviews animated:YES];
}

- (IBAction)ReportTapped:(id)sender {
     [delegate.defaults setValue:@"fromDetail" forKey:@"navigateFromReport"];
    ReportErrorViewController * report = [self.storyboard instantiateViewControllerWithIdentifier:@"ReportErrorViewController"];
    [self.navigationController pushViewController:report animated:YES];
}

- (IBAction)AddReviewTapped:(id)sender {
    
    if([[deatilsArr valueForKey:@"can_review"] intValue] == 1){
        [delegate.defaults setInteger:store_ID forKey:@"Store_ID"];
        [delegate.defaults synchronize];
        
        SubmitReviewViewController * addReview = [self.storyboard instantiateViewControllerWithIdentifier:@"SubmitReviewViewController"];
        [self.navigationController pushViewController:addReview animated:YES];
    }else{
        [self.view makeToast:@"You need to check in to review the store"];
    }
    
}

- (IBAction)checkInTapped:(id)sender {
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
            if([awayDist doubleValue]<0.25){
                    responseType = @"CheckedIn";
                    [self userCheckedin];
            }else{
                [self.view makeToast:@"You have to be in 250 meters radius to CHECK IN into the store"];
            }
        }
    }

    
//    if ([time isEqualToString:@"Closed"]){
//        [self.view makeToast:@"Store is closed" duration:4.0 position:CSToastPositionBottom];
////        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Store is closed" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
////        [alert show];
//    }else{
//    NSString * mobilenumber = [delegate.defaults valueForKey:@"mobile"];
//    NSLog(@"mobilenumber %@",mobilenumber);
//    NSLog(@"mobilenumber length %lu",(unsigned long)mobilenumber.length);
//    if(mobilenumber.length == 0){
//        Popupmainview.hidden = false;
//    }else{
//        if([awayDist doubleValue]<0.25){
//            [commonclass Redirect:self.navigationController Identifier:@"GenerateCouponsViewController"];
//        }else{
//            [self.view makeToast:@"You have to be in 250 meters radius to CHECK IN into the store"];
//        }
//      }
//    }
}

-(void)userCheckedin{
    
    if([commonclass isActiveInternet] == YES){
        
        NSString *messageBody = [NSString stringWithFormat:@"log_id=%@&latitude=%@&longitude=%@&store_id=%ld",[delegate.defaults valueForKey:@"logid"],[delegate.defaults valueForKey:@"latitude"],[delegate.defaults valueForKey:@"longitude"],store_ID];
        
        NSLog(@"body.. %@",messageBody);
        
        NSLog(@"commonclass.searchListURL.. %@",commonclass.CheckinsURL);
        
        [commonclass sendRequest:self.view mutableDta:checkinsData url:commonclass.CheckinsURL msgBody:messageBody];
        
    }else{
        
        [commonclass Redirect:self.navigationController Identifier:@"InternetDisconnectViewController"];
        
        //[self.view makeToast:@"Check your internet connection"];
        
    }
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [dealsArr count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(isexpand==YES) {
        if (selectedIndex == indexPath.section) {
            return 72;
        } else{
            return 40;
        }
        
    } else{
        return 40;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier;
    cellIdentifier = @"StoreDealsCell";
    cell = (StoreDealsCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[StoreDealsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
//    if([dealsArr count]<1){
//        
//        
//    }else{
        cell.shortDealTitleLbl.text = [dealsArr[indexPath.section] valueForKey:@"short_name"];
        [cell.ExpandBtn addTarget:self action:@selector(ExpandTapped:) forControlEvents:UIControlEventTouchUpInside];
        cell.ExpandBtn.tag = indexPath.section;
        cell.longDealTitleLbl.text = [NSString stringWithFormat:@" %@",[dealsArr[indexPath.section] valueForKey:@"long_name"]];
   // }
    // cell.bucketListLbl.text = [NSString stringWithFormat:@"  %@",[[[[bucketsListArr valueForKey:@"items"] valueForKey:@"buckets"][indexPath.section] valueForKey:@"title"] uppercaseString]];
    
    return cell;
}

-(void)ExpandTapped:(UIButton*)sender{
    selectedIndex = (long)sender.tag;
    isexpand = !isexpand;
    if(isexpand == YES){
        [sender setTitle:@"+" forState:UIControlStateNormal];
    }else{
        [sender setTitle:@"-" forState:UIControlStateNormal];
    }
    NSLog(@"sender.tag..%ld",(long)sender.tag);
    path = [NSIndexPath indexPathWithIndex:sender.tag];
    [self tableView:storeOffersTbl heightForRowAtIndexPath:path];
    [storeOffersTbl reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:sender.tag]] withRowAnimation:UITableViewRowAnimationFade];
    
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
    [self updateMobile];
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
     if([commonclass isActiveInternet] == YES){
    responseType = @"UpdateOTP";
    NSString *messageBody = [NSString stringWithFormat:@"mobile=%@&otp=%@",[delegate.defaults valueForKey:@"mobile"],otpFld.text];
    [commonclass sendRequest:self.view mutableDta:miscdata url:commonclass.otpURL msgBody:messageBody];
     }else{
         [commonclass Redirect:self.navigationController Identifier:@"InternetDisconnectViewController"];
         //[self.view makeToast:@"Check your internet connection"];
     }
}


-(void)SubscribeTapped{
    NSString * mobilenumber = [delegate.defaults valueForKey:@"mobile"];
    if(mobilenumber.length == 0){
        [self updateMobile];
    }else{
        [self GetOTP];
    }
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
