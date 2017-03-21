
//

//  GenerateCouponsViewController.m

//  Street_Treat

//

//  Created by Kamlesh Dubey on 9/6/16.

//  Copyright © 2016 Digillence Rolson. All rights reserved.

//



#import "GenerateCouponsViewController.h"

#import "UPStackMenu.h"



@interface GenerateCouponsViewController (){
    
    UIView *contentView;
    
    UPStackMenu *stack;
    
}

@end



@implementation GenerateCouponsViewController

@synthesize cameraBtn,DetailScroll,Promoscroll,Promopagecontol,DetailsArr,PromoArr;



@synthesize storeName,storeAddress,storeShopForLbl,storeTimeLbl,storeAwayIconLbl,storeAwayLbl,shareButton,addTofavouritesBtn,votesCount,storeStarsLbl,storeRatingLbl,storeChecksCount,storeValidCouponsCount,streetOffersLbl,mobileFld,otpFld,reviewView;



-(void)viewWillAppear:(BOOL)animated{
    selectedOffersArr = [[NSMutableArray alloc]init];
    if ([[delegate.defaults valueForKey:@"navigateFromReport"] isEqualToString:@"fromCouponsPage"]){
        [self.view makeToast:@"Report Submitted Successfully"];
        
    }
    
    [delegate.defaults setObject:@"GenerateCouponsViewController" forKey:@"internetdisconnect"];
    
    store_ID = [[delegate.defaults valueForKey:@"store_ID"] intValue];
    
    NSLog(@"store_ID..%ld",store_ID);
    
    userLatitude = [[delegate.defaults valueForKey:@"latitude"] floatValue];
    
    userLongitude = [[delegate.defaults valueForKey:@"longitude"] floatValue];
    //    currentLatitude = [[delegate.defaults valueForKey:@"latitude"] floatValue];
    //    currentLongitude = [[delegate.defaults valueForKey:@"longitude"] floatValue];
    
    currentLatitude = [[delegate.defaults valueForKey:@"user_latitude"] floatValue];
    currentLongitude = [[delegate.defaults valueForKey:@"user_longitude"] floatValue];
    [self getStoreDetails];
}



-(void)viewDidAppear:(BOOL)animated{
    
    [self setUpstackMenu];
    
}



-(void)setUpstackMenu{
    
    contentView = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 60, self.view.frame.size.height + 5 , 35, 35)];
    
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
    
    
    
    NSMutableArray *items = [[NSMutableArray alloc] initWithObjects:squareItem, circleItem,viewItem, nil];
    
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
    
    NSString *message = [NSString stringWithFormat:@"Item touched : %@", item.title];
    
    NSLog(@"index.. %lu",(unsigned long)index);
    
    if(index == 0){
        
        [delegate.defaults setValue:@"Favourites" forKey:@"route"];
        
        [commonclass Redirect:self.navigationController Identifier:@"ResultsViewController"];
        
        
        
    }else if(index == 1){
        
        [commonclass Redirect:self.navigationController Identifier:@"ProfileViewController"];
        
    }else if (index == 2){
        
        [delegate.defaults setInteger:store_ID forKey:@"Store_ID"];
        [delegate.defaults synchronize];
        SubmitReviewViewController * addReview = [self.storyboard instantiateViewControllerWithIdentifier:@"SubmitReviewViewController"];
        [self.navigationController pushViewController:addReview animated:YES];
        
    }
    
    [stack closeStack];
    
    //    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:message message:nil delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    
    //    [alert show];
    
}





-(void)getStoreDetails{
    
    responseType = @"StoreDetails";
    
    if([commonclass isActiveInternet] == YES){
        
        NSString *messageBody = [NSString stringWithFormat:@"log_id=%@&store_id=%ld&latitude=%f&longitude=%f&current_latitude=%@&current_longitude=%@",[delegate.defaults valueForKey:@"logid"],store_ID,currentLatitude,currentLongitude,[delegate.defaults valueForKey:@"latitude"],[delegate.defaults valueForKey:@"longitude"]];
        
        NSLog(@"body.. %@",messageBody);
        
        NSLog(@"url.. %@",commonclass.getstoreDetailsURL);
        
        [commonclass sendRequest:self.view mutableDta:detailsData url:commonclass.getstoreDetailsURL msgBody:messageBody];
        
    }else{
        
        [commonclass Redirect:self.navigationController Identifier:@"InternetDisconnectViewController"];
        
        //[self.view makeToast:@"Check your internet connection"];
        
    }
    
}



- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // [delegate.defaults setValue:@"myloc" forKey:@"locupdatefrom"];
    
  //  cameraBtn.hidden = true;
    
    // [delegate.defaults setValue:@"b" forKey:@"navigateFromReport"];
    
    [self AddtoFavourites];
    
    isDataLoadingCompleted = false;
    
    self.navigationController.navigationBarHidden =true;
    
    commonclass = [[Common alloc]init];
    
    commonclass.delegate = self;
    
    delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    // [commonclass addNavigationBar:self.view];
    
    checkinsData = [[NSMutableData alloc]init];
    dataDetails = [[NSMutableArray alloc]init];
    
    generateData = [[NSMutableData alloc]init];
    
    selectedOffersArr = [[NSMutableArray alloc]init];
    
    detailsData = [[NSMutableData alloc]init];
    
    detailsArr = [[NSMutableArray alloc]init];
    
    
    
    //    NSData *data = [delegate.defaults valueForKey:@"StoreCheckedIn"];
    
    //    DetailsArr = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    //    NSLog(@"Data... %@",DetailsArr);
    
    //    [self Setdata];
    
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
    
    UIButton *menubtn = (UIButton *)[self.view viewWithTag:111];
    
    menubtn.hidden = TRUE;
    
    UIButton *notificationbtn = (UIButton *)[self.view viewWithTag:222];
    
    notificationbtn.hidden = TRUE;
    
    UISearchBar * search = (UISearchBar *)[self.view viewWithTag:11111];
    
    search.hidden = TRUE;
    
    
    
    UIButton *current_Loc = (UIButton *)[self.view viewWithTag:444];
    
    current_Loc.hidden = TRUE;
    
    DtlcheckInBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    DtlcheckInBtn.frame = CGRectMake(self.view.frame.size.width - 115, self.view.frame.size.height - 100, 130, 35);
    
    DtlcheckInBtn.backgroundColor = [UIColor Tabbar_Color];
    
    DtlcheckInBtn.layer.cornerRadius = 18.0f;
    
    [DtlcheckInBtn setTitle:@"CHECKED IN" forState:UIControlStateNormal];
    
    [DtlcheckInBtn.titleLabel setFont:[UIFont fontWithName:@"Roboto-Bold" size:15]];
    
    [DtlcheckInBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [DtlcheckInBtn addTarget:self action:@selector(checkInTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:DtlcheckInBtn];
    
    
    
    [self.view bringSubviewToFront:DtlcheckInBtn];
    
    
    
    
    
    [self setupMobileVerificationPopup];
    
    Popupmainview.hidden = true;
    
    OTPView.hidden = true;
    
    
    
    DetailScroll.contentSize = CGSizeMake(self.view.frame.size.width,reviewView.frame.origin.y + 1);
    
    [self.view makeToast:@"Checked In to the store"];
    
}



- (IBAction)checkInTapped:(id)sender {
    
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
    
    //    }
    
}



//-(void)setupMobileVerificationPopup{

//    Popupmainview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];

//    Popupmainview.backgroundColor = [UIColor PopupBackground];

//    Popupmainview.tag = 2000;

//

//    [self.view addSubview:Popupmainview];

//}





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
    
    [self.view makeToast:@"Coming Soon"];
    
}



-(void)cancelSubscribeTapped{
    
    Popupmainview.hidden = true;
    
}



-(void)SubscribeTapped{
    
    
    
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
    
    
    
    
    
    
    
    //    responseType = @"SubscribeBuckets";
    
    //    NSString *subscribeBody = [NSString stringWithFormat:@"log_id=%@&bucket_id=%ld&start_date=%@&end_date=%@",[delegate.defaults valueForKey:@"logid"],BucketID,subsstartdateFld.text,subsenddateFld.text];
    
    //    NSLog(@"subscribe body.. %@",subscribeBody);
    
    //    NSLog(@"url.. %@",common.CreateBucketsURL);
    
    //    [common sendRequest:self.view mutableDta:allBucketslistdata url:common.CreateBucketsURL msgBody:subscribeBody];
    
}







-(void)getStoreCoupons{
    
    responseType = @"StoreCoupons";
    
    if([commonclass isActiveInternet] == YES){
        
        NSString *messageBody = [NSString stringWithFormat:@"log_id=%@&store_id=%ld",[delegate.defaults valueForKey:@"logid"],store_ID];
        
        NSLog(@"body.. %@",messageBody);
        
        NSLog(@"commonclass.searchListURL.. %@",commonclass.getOffersURL);
        
        [commonclass sendRequest:self.view mutableDta:checkinsData url:commonclass.getOffersURL msgBody:messageBody];
        
    }else{
        
        [commonclass Redirect:self.navigationController Identifier:@"InternetDisconnectViewController"];
        
        //[self.view makeToast:@"Check your internet connection"];
        
    }
    
}



-(void)shareStore{
    
    responseType = @"shareStore";
    
    if([commonclass isActiveInternet] == YES){
        
        NSString *messageBody = [NSString stringWithFormat:@"log_id=%@&store_id=%ld",[delegate.defaults valueForKey:@"logid"],store_ID];
        
        NSLog(@"body.. %@",messageBody);
        
        NSLog(@"commonclass.searchListURL.. %@",commonclass.shareStoreURL);
        
        [commonclass sendRequest:self.view mutableDta:checkinsData url:commonclass.shareStoreURL msgBody:messageBody];
        
    }else{
        
        [commonclass Redirect:self.navigationController Identifier:@"InternetDisconnectViewController"];
        
        //[self.view makeToast:@"Check your internet connection"];
    }
}

- (void)sendResponse:(Common *)response data:(NSMutableArray*)data indicator:(UIActivityIndicatorView *)indicator{
    
    NSLog(@"data.. %@",data);
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if(data != NULL){
//        if([responseType isEqualToString:@"CheckedIn"]){
//            
//            if([[data valueForKey:@"status"]intValue] == 1){
//            }else if([[data valueForKey:@"status"]intValue] == -1){
//                
//                [commonclass logoutFunction];
//                
//            }else{
// 
//            }
//          }else
         if([responseType isEqualToString:@"StoreDetails"]){
            
            [detailsArr removeAllObjects];
            
            if([[data valueForKey:@"status"]intValue] == 1){
                
                detailsArr = [data valueForKey:@"items"];
                
                NSLog(@"data.. %@",detailsArr);
                
                [self Setdata:detailsArr];
                
                [self getStoreCoupons];
                
            }else if([[data valueForKey:@"status"]intValue] == -1){
                
                [commonclass logoutFunction];
                
            }else{
                
            
            }
            
        }
        else if([responseType isEqualToString:@"StoreCoupons"]){
            
            // [offersArr rem ]
            if([[data valueForKey:@"status"]intValue] == 1){
                
                offersArr = [data valueForKey:@"items"];
                
                    [_selectofferTappedButton setTitle:@"Select More Offers" forState:UIControlStateNormal];
                    _borderLabel.hidden = true;
                    _leftSideLabel.hidden = false;
                    
                    _rightSideLabel.hidden = false;
                    
                    _plusLabel.hidden = false;
                
//                }else{
//                    
//                    [_selectofferTappedButton setTitle:@"Generate" forState:UIControlStateNormal];
//                    
//                    [_selectofferTappedButton setBackgroundColor:[UIColor redColor]];
//                    
//                    _leftSideLabel.hidden = true;
//                    
//                    _rightSideLabel.hidden = true;
//                    
//                    _plusLabel.hidden = true;
//                }
                
                //
                
                NSLog(@"data.. %@",offersArr);
                
                //    backBtn.enabled = true;
                
            }else if([[data valueForKey:@"status"]intValue] == -1){
                
                [commonclass logoutFunction];
                
            }else{
                
                [_selectofferTappedButton setTitle:@"Generate Offer" forState:UIControlStateNormal];
                
                [_selectofferTappedButton setBackgroundColor:[UIColor redColor]];
                [_selectofferTappedButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                _selectofferTappedButton.layer.cornerRadius = 5.0;
                _borderLabel.hidden = false;
                _leftSideLabel.hidden = true;
                
                _rightSideLabel.hidden = true;
                
                _plusLabel.hidden = true;
                
            }
        }else if([responseType isEqualToString:@"GenerateOffers"]){
            
            if([[data valueForKey:@"status"]intValue] == 1){
                
                [self.view makeToast:@"Congratulations, your coupon has been generated successfully" duration:4.0 position:CSToastPositionBottom];
                
                [commonclass Redirect:self.navigationController Identifier:@"MyCouponsViewController"];
                
                //                backBtn.enabled = true;
                
            }else if([[data valueForKey:@"status"]intValue] == -1){
                
                [commonclass logoutFunction];
                
            }else{
                
            }
            
        }else if([responseType isEqualToString:@"AddFavourite"]){
            
            if([[data valueForKey:@"status"]intValue] == 1){
                
                if ([[data valueForKey:@"items"]boolValue] == true) {
                    
                    [self.view makeToast:@"The store has been added to your Favourites list" duration:4.0 position:CSToastPositionBottom];
                    
                    [addTofavouritesBtn setTitle:commonclass.addedtofavouritesIcon forState:UIControlStateNormal];
                    
                    //                    backBtn.enabled = true;
                    
                }else if([[data valueForKey:@"status"]intValue] == -1){
                    
                    [commonclass logoutFunction];
                    
                }else{
                    
                    [self.view makeToast:@"The store has been removed from your Favourites list" duration:4.0 position:CSToastPositionBottom];
                    
                    [addTofavouritesBtn setTitle:commonclass.addtofavouritesIcon forState:UIControlStateNormal];
                    
                    //                    backBtn.enabled = true;
                    
                }
                
            }else{
                
                
                
            }
            
        }else if([responseType isEqualToString:@"shareStore"]){
            
            if([[data valueForKey:@"status"]intValue] == 1){
                
                //                backBtn.enabled = true;
                
            }else if([[data valueForKey:@"status"]intValue] == -1){
                
                [commonclass logoutFunction];
                
            }else{
                
            }
            
        }
            [indicator stopAnimating];
            [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        }else{
            [indicator stopAnimating];
            [[UIApplication sharedApplication] endIgnoringInteractionEvents];
           // [self.view makeToast:@"Server error occured Please wait"];
            [self getStoreDetails];
        }
    });
}

- (UIView *)createDemoView:(NSString *)sender senderTag:(int)tag tapGesture:(UITapGestureRecognizer *)sender1
{
    UIScrollView *scroll;
    scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height - 50)];
    demoView = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height)];
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

-(void)Setdata:(NSMutableArray *)details{
    
    NSLog(@"deatils... %@",details);
    
    
    
    if([details valueForKey:@"images"] != [NSNull null]){
        dataDetails = details;
        imgcnt = [[details valueForKey:@"images"] count];
        Promoscroll.backgroundColor = [UIColor whiteColor];
        Promoscroll.contentSize = CGSizeMake(Promoscroll.frame.size.width * imgcnt, Promoscroll.frame.size.height);
        
        //    PromoArr = [[NSMutableArray alloc]initWithObjects:[UIImage imageNamed:@"Promo1.png"],[UIImage imageNamed:@"Promo2.png"],[UIImage imageNamed:@"Promo3.png"],[UIImage imageNamed:@"Promo4.png"],nil];
        
        // Promoscroll.contentSize = CGSizeMake(Promoscroll.frame.size.width * imgcnt, Promoscroll.frame.size.height);
        
        
        
        for (int j = 0; j < imgcnt; j++) {
            
            NSString * imglink = [NSString stringWithFormat:@"%@/%@",commonclass.siteURL,[details valueForKey:@"images"][j]];
            
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
            
        }
        
        
        
        Promopagecontol.currentPage = 0;
        
        Promopagecontol.numberOfPages = imgcnt;
        
        [DetailScroll bringSubviewToFront:Promopagecontol];
        
    }
    
    //    for (int j = 0; j < imgcnt; j++) {
    
    //        CGRect frame;
    
    //        frame.origin.x = Promoscroll.frame.size.width * j;
    
    //        frame.origin.y = 0;
    
    //        frame.size = Promoscroll.frame.size;
    
    //        UIImageView* imgView = [[UIImageView alloc] init];
    
    //        imgView.image = [PromoArr objectAtIndex:j];
    
    //        imgView.frame = frame;
    
    //        [Promoscroll addSubview:imgView];
    
    //    }
    
    
    
    //    Promopagecontol.currentPage = 0;
    
    //    Promopagecontol.numberOfPages = imgcnt;
    
    //    [DetailScroll bringSubviewToFront:Promopagecontol];
    
    
    
    storeName.text = [details valueForKey:@"store_name"];
    
    [delegate.defaults setValue:[details valueForKey:@"store_name"] forKey:@"Store_Name"];
    
    [delegate.defaults synchronize];
    
    storeAddress.text = [NSString stringWithFormat:@"%@, %@",[details valueForKey:@"address_1"],[details valueForKey:@"address_2"]];
    
    if(([DetailsArr valueForKey:@"categories"] == [NSNull null])){
        
        storeShopForLbl.text = @"0";
        
    }else{
        
        // NSString * shopforLbl =
        
        NSArray * shpArr = [details valueForKey:@"parent_categories"];
        
        if(shpArr.count==1){
            
            storeShopForLbl.text = [NSString stringWithFormat:@"%@ ",shpArr[0]];
            
        }else if (shpArr.count==2){
            
            storeShopForLbl.text = [NSString stringWithFormat:@"%@ | %@ ",shpArr[0],shpArr[1]];
            
        }else{
            
            storeShopForLbl.text = [NSString stringWithFormat:@"%@ | %@ | %@",shpArr[0],shpArr[1],shpArr[2]];
            
        }
        
    }
    
    
    
    NSString * time;
    
    if([details valueForKey:@"start_time"] == [NSNull null] && [details valueForKey:@"end_time"] == [NSNull null]){
        
        storeTimeLbl.backgroundColor = [UIColor redColor];
        
        time = @"Closed";
        
        storeTimeLbl.textAlignment = NSTextAlignmentCenter;
        
    }else{
        
        storeTimeLbl.backgroundColor = [UIColor greenColor];
        
        NSString * startTime = [commonclass calculateTimeinAMPM:[details valueForKey:@"start_time"]];
        
        NSString * endTime = [commonclass calculateTimeinAMPM:[details valueForKey:@"end_time"]];
        
        time = [NSString stringWithFormat:@"%@-%@",startTime,endTime];
        
    }
    
    storeTimeLbl.text = time;
    
    
    
    [cameraBtn setTitle:commonclass.cameraIcon forState:UIControlStateNormal];
    
    storeAwayIconLbl.text = commonclass.storeawayIcon;
    
    NSString * awayDist = [details valueForKey:@"distance_in_kms"];
    
    storeAwayLbl.text = [NSString stringWithFormat:@"%.2f Kms away  ",[awayDist doubleValue]];
    
    
    
    storeValidCouponsCount.text = [details valueForKey:@"accepted_coupons"];
    
    storeChecksCount.text = [details valueForKey:@"no_of_checkins"];
    
    streetOffersLbl.text = [NSString stringWithFormat:@"%@ %% Street Treat Offers",[details valueForKey:@"exclusive_discount"]];
    streetOffersLbl.font = [UIFont fontWithName:@"fontello" size:14.0];
    exclusiveCoupon = [NSString stringWithFormat:@"%@",[details valueForKey:@"exclusive_coupon_id"]];
    
    if([details valueForKey:@"rating"] != [NSNull null]){
        storeRatingLbl.text = [details valueForKey:@"rating"];
        [self setratingsLbl:[[details valueForKey:@"rating"]intValue] label:storeStarsLbl];
        
    }
    
    [shareButton setTitle:commonclass.shareIcon forState:UIControlStateNormal];
    
    [addTofavouritesBtn setTitle:commonclass.addtofavouritesIcon forState:UIControlStateNormal];
    
    
    
    votesCount.text = [NSString stringWithFormat:@"%@ Votes",[details valueForKey:@"number_of_likes"]];
    
    
    
    // DetailScroll.contentSize = CGSizeMake(self.view.frame.size.width, 675);
    
    
    
}



-(void)setratingsLbl:(int)rating label:(UILabel*)rateLbl{
    
    if(rating == 1){
        
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







- (void)scrollViewDidScroll:(UIScrollView *)sender {
    
//  float scrollOffset = sender.contentOffset.y;
    
//    if (scrollOffset <= 0 )
//    {
//        DtlcheckInBtn.hidden = false;
//        //checkInBtn.hidden = false;
//        
//    }else{
//        DtlcheckInBtn.hidden = true;
//        //        checkInBtn.layer.backgroundColor = [[UIColor whiteColor] CGColor];
//        //        [checkInBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    }
    
    if (!pageControlBeingUsed) {
        
        CGFloat pageWidth = Promoscroll.frame.size.width;
        
        int page = floor((Promoscroll.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
        
        Promopagecontol.currentPage = page;
        
    }
    
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
   // DtlcheckInBtn.hidden = true;
    pageControlBeingUsed = NO;
}


-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
   // DtlcheckInBtn.hidden = false;
}

-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
   // DtlcheckInBtn.hidden = true;
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
   // DtlcheckInBtn.hidden = false;
    pageControlBeingUsed = NO;
}

-(void)backTapped{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}



- (IBAction)cameraTapped:(id)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:picker animated:YES completion:NULL];
    
   // [self.view makeToast:@"In Progress"];
    
}


# pragma mark - Image picker controller delegate methods

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    
    [self dismissViewControllerAnimated:true completion:^{
        NSString *textToShare = [NSString stringWithFormat:@"Check out this %@ store on Street Treat App here",[delegate.defaults valueForKey:@"Store_Name"]];
        
        NSURL *myWebsite = [NSURL URLWithString:@"http://www.streettreat.in"];
        
        UIImage *image = chosenImage;
        
        NSMutableArray *objectsToShare= [NSMutableArray arrayWithObjects:image, nil];
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
        
        
        [self presentViewController:activityVC animated:YES completion:^{
            
        }];
        
        
        
        
        UIPopoverPresentationController *presentationController =
        
        [activityVC popoverPresentationController];
        
        
        
        presentationController.sourceView = self.view;
    }];

}





- (IBAction)ReportTapped:(id)sender{
    
    [delegate.defaults setValue:@"fromCouponsPage" forKey:@"navigateFromReport"];
    
    [commonclass Redirect:self.navigationController Identifier:@"ReportErrorViewController"];
    
}



- (IBAction)shareTapped:(id)sender{
    
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
    
    [self AddtoFavourites];
    
}



-(void)AddtoFavourites{
    
    responseType = @"AddFavourite";
    
    if([commonclass isActiveInternet] == YES){
        
        NSString *messageBody = [NSString stringWithFormat:@"log_id=%@&store_id=%ld",[delegate.defaults valueForKey:@"logid"],store_ID];
        
        NSLog(@"body.. %@",messageBody);
        
        NSLog(@"commonclass.searchListURL.. %@",commonclass.AddfavouritesURL);
        
        [commonclass sendRequest:self.view mutableDta:checkinsData url:commonclass.AddfavouritesURL msgBody:messageBody];
        
    }else{
        
        [commonclass Redirect:self.navigationController Identifier:@"InternetDisconnectViewController"];
        
        //[self.view makeToast:@"Check your internet connection"];
        
    }
    
}



- (IBAction)viewReviewsTapped:(id)sender{
    
    [commonclass Redirect:self.navigationController Identifier:@"ViewReviewsViewController"];
    
}



- (IBAction)MoreOffersTapped:(id)sender {
    
    NSString * mobilenumber = [delegate.defaults valueForKey:@"mobile"];
    
    NSLog(@"mobilenumber %@",mobilenumber);
    
    NSLog(@"mobilenumber length %lu",(unsigned long)mobilenumber.length);
    
    if(mobilenumber.length == 0){
        
        Popupmainview.hidden = false;
        
    }else{
        
        if(offersArr.count>0){
            
            [selectedOffersArr removeAllObjects];
            
            CZPickerView *picker = [[CZPickerView alloc] initWithHeaderTitle:@"Select Offers" cancelButtonTitle:@"Cancel" confirmButtonTitle:@"Generate"];
            
            picker.delegate = self;
            
            picker.dataSource = self;
            
            picker.tag = 1;
            
            picker.allowMultipleSelection = YES;
            
            picker.needFooterView = YES;
            
            [picker show];
            
        }else{
            
            responseType = @"GenerateOffers";
            
            if([commonclass isActiveInternet] == YES){
                
                // NSString * cpns = [selectedOffersArr componentsJoinedByString:@","];
                
                NSString *messageBody = [NSString stringWithFormat:@"log_id=%@&latitude=%@&longitude=%@&store_id=%ld&coupon_id=%@",[delegate.defaults valueForKey:@"logid"],[delegate.defaults valueForKey:@"latitude"],[delegate.defaults valueForKey:@"longitude"],store_ID,exclusiveCoupon];
                
                NSLog(@"body.. %@",messageBody);
                
                NSLog(@"commonclass.searchListURL.. %@",commonclass.generateCouponsURL);
                
                [commonclass sendRequest:self.view mutableDta:generateData url:commonclass.generateCouponsURL msgBody:messageBody];
                
            }else{
                
                [commonclass Redirect:self.navigationController Identifier:@"InternetDisconnectViewController"];
                
                //[self.view makeToast:@"Check your internet connection"];
                
            }
            
        }
        
    }
    
}



- (NSString *)czpickerView:(CZPickerView *)pickerView

               titleForRow:(NSInteger)row{
    
    return [offersArr[row] valueForKey:@"short_name"];
    
}



- (NSInteger)numberOfRowsInPickerView:(CZPickerView *)pickerView {
    
    return offersArr.count;
    
}



//- (void)czpickerView:(CZPickerView *)pickerView didConfirmWithItemAtRow:(NSInteger)row {

//    NSLog(@"%@ is chosen!",offersArr[row]);

//    if(pickerView.tag == 1){

//        NSLog(@"offer.. %@",[offersArr[row] valueForKey:@"short_name"]);

//        [selectedOffersArr addObject:[offersArr[row] valueForKey:@"id"]];

//    }

//    [self.navigationController setNavigationBarHidden:YES];

//}



- (void)czpickerView:(CZPickerView *)pickerView didConfirmWithItemsAtRows:(NSArray *)rows {
    
    for (NSNumber *n in rows) {
        
        NSInteger row = [n integerValue];
        
        NSLog(@"%@ is chosen!", [offersArr[row] valueForKey:@"short_name"]);
        
        [selectedOffersArr addObject:[offersArr[row] valueForKey:@"id"]];
        
    }
    
    [selectedOffersArr addObject:exclusiveCoupon];
    
    [self generateOffers];
    
}



-(void)generateOffers{
    
    responseType = @"GenerateOffers";
    
    if([commonclass isActiveInternet] == YES){
        
        NSString * cpns = [selectedOffersArr componentsJoinedByString:@","];
        
        NSString *messageBody = [NSString stringWithFormat:@"log_id=%@&latitude=%@&longitude=%@&store_id=%ld&coupon_id=%@",[delegate.defaults valueForKey:@"logid"],[delegate.defaults valueForKey:@"latitude"],[delegate.defaults valueForKey:@"longitude"],store_ID,cpns];
        
        NSLog(@"body.. %@",messageBody);
        
        NSLog(@"commonclass.searchListURL.. %@",commonclass.generateCouponsURL);
        
        [commonclass sendRequest:self.view mutableDta:generateData url:commonclass.generateCouponsURL msgBody:messageBody];
        
    }else{
        
        [commonclass Redirect:self.navigationController Identifier:@"InternetDisconnectViewController"];
        
        //[self.view makeToast:@"Check your internet connection"];
        
    }
    
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



- (IBAction)reviewTapped:(id)sender {
    [delegate.defaults setInteger:store_ID forKey:@"Store_ID"];
    [delegate.defaults synchronize];
    SubmitReviewViewController * addReview = [self.storyboard instantiateViewControllerWithIdentifier:@"SubmitReviewViewController"];
    [self.navigationController pushViewController:addReview animated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end

