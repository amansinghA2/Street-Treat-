//
//  ForgotPassViewController.m
//  Street_Treat
//
//  Created by Kamlesh Dubey on 6/15/16.
//  Copyright (c) 2016 Digillence Rolson. All rights reserved.
//

#import "ForgotPassViewController.h"

@interface ForgotPassViewController ()

@end

@implementation ForgotPassViewController
@synthesize getBtn,LockLbl,Email,Mobile,orLbl,ForgotScroll,otptxtFld;

-(void)viewWillAppear:(BOOL)animated{
    [delegate.defaults setObject:@"ForgotPassViewController" forKey:@"internetdisconnect"];
    OTPMainview.hidden = TRUE;
    tempview.hidden = TRUE;
    [timer invalidate];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    constant = [[Common alloc]init];
    constant.delegate = self;
    delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    [constant addNavigationBar:self.view];
    UIButton *backBtn = (UIButton *)[self.view viewWithTag:1111];
    [backBtn addTarget:self action:@selector(backTapped) forControlEvents:UIControlEventTouchUpInside];
    UIButton *menubtn = (UIButton *)[self.view viewWithTag:111];
    menubtn.hidden = TRUE;
    UISearchBar *search = (UISearchBar *)[self.view viewWithTag:11111];
    search.hidden = TRUE;
    UIButton *notificationbtn = (UIButton *)[self.view viewWithTag:222];
    notificationbtn.hidden = TRUE;
    getBtn.layer.cornerRadius = 20.0f;
    forgotData = [[NSMutableData alloc]init];
    otpdata =[[NSMutableData alloc]init];
    
    [self setupForgotPasswordView];
    [self setupOTPPopup];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
}

-(void)setupForgotPasswordView{
    ForgotScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 54)];
    UILabel * lockIcon = [[UILabel alloc]initWithFrame:CGRectMake(20, self.view.frame.size.height / 6.5, self.view.frame.size.width - 40, 120)];
    lockIcon.font = [UIFont fontWithName:@"fontello" size:120.0];
    lockIcon.textAlignment = NSTextAlignmentCenter;
    lockIcon.textColor = [UIColor lightGrayColor];
    //lockIcon.backgroundColor = [UIColor redColor];
    lockIcon.text = constant.forgotIcon;
    
    UILabel * passLbl = [[UILabel alloc]initWithFrame:CGRectMake(lockIcon.frame.origin.x, (lockIcon.frame.origin.y+lockIcon.frame.size.height), lockIcon.frame.size.width, 30)];
    passLbl.text = @"FORGOT PASSWORD";
    passLbl.textAlignment = NSTextAlignmentCenter;
    passLbl.font = [UIFont fontWithName:@"Raleway-Bold" size:15.0];
    passLbl.textColor = [UIColor redColor];
    
    Mobile = [[RPFloatingPlaceholderTextField alloc]initWithFrame:CGRectMake(20,passLbl.frame.origin.y+ 70 , lockIcon.frame.size.width, 35)];
    Mobile.delegate=self;
    Mobile.keyboardType = UIKeyboardTypeNumberPad;
    Mobile.placeholder = @"MOBILE";
    [constant addfeild:ForgotScroll textfeild:Mobile];
    
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar.items = @[[[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelKeyboard)],
                            [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                            [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithKeyboard)]];
    [numberToolbar sizeToFit];
    Mobile.inputAccessoryView = numberToolbar;
    
    UIButton * getPasswordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    getPasswordBtn.frame = CGRectMake(ForgotScroll.frame.size.width/[constant.passSubmitPos floatValue], (Mobile.frame.origin.y+Mobile.frame.size.height) + 100, 200, 40);
    getPasswordBtn.titleLabel.font = [UIFont fontWithName:@"Raleway-Bold" size:18.0];
    [getPasswordBtn setTitle:@"GET PASSWORD" forState:UIControlStateNormal];
    getPasswordBtn.titleLabel.textColor = [UIColor whiteColor];
    getPasswordBtn.backgroundColor = [UIColor redColor];
    getPasswordBtn.layer.cornerRadius = 18.0f;
    [getPasswordBtn addTarget:self action:@selector(getPasswordTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [ForgotScroll addSubview:getPasswordBtn];
    [ForgotScroll addSubview:passLbl];
    [ForgotScroll addSubview:lockIcon];
    [self.view addSubview:ForgotScroll];
    [self.view sendSubviewToBack:ForgotScroll];
    //[self.view bringSubviewToFront:ForgotScroll];
}

-(void)setupOTPPopup{
    OTPMainview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    OTPMainview.tag = 12;
    OTPMainview.backgroundColor = [UIColor Popup_color];
    
    tempview = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height - 54, self.view.frame.size.width, 54)];
    //OTPMainview.tag = 12;
    UIView *tempview1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 54)];
    tempview1.backgroundColor = [UIColor Popup_color];
    UIView *tempview2 = [[UIView alloc]initWithFrame:CGRectMake(0, 54, self.view.frame.size.width, self.view.frame.size.height)];
    tempview2.backgroundColor = [UIColor clearColor];
    [tempview addSubview:tempview2];
    [tempview addSubview:tempview1];
    [self.view addSubview:tempview];
    
    UIView * OTPInnerView = [[UIView alloc]initWithFrame:CGRectMake(20, OTPMainview.frame.size.height/4, self.view.frame.size.width - 40, self.view.frame.size.height/2)];
    OTPInnerView.layer.cornerRadius = 10.0f;
    OTPInnerView.backgroundColor = [UIColor whiteColor];
    
    UIButton *closepopupBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [closepopupBtn setBackgroundImage:[UIImage imageNamed:@"close-button.png"] forState:UIControlStateNormal];
    closepopupBtn.frame = CGRectMake(OTPInnerView.frame.size.width - 20, 0, 20, 20);
    [closepopupBtn addTarget:self action:@selector(OTPDone) forControlEvents:UIControlEventTouchUpInside];
    
    
    UILabel * passLbl = [[UILabel alloc]initWithFrame:CGRectMake(0,OTPMainview.frame.origin.y + 20, OTPInnerView.frame.size.width, 25)];
    passLbl.text = @"OTP Verification";
    passLbl.textAlignment = NSTextAlignmentCenter;
    passLbl.font = [UIFont fontWithName:@"Raleway-Bold" size:18.0];
    passLbl.textColor = [UIColor redColor];
    
    otptxtFld = [[RPFloatingPlaceholderTextField alloc]initWithFrame:CGRectMake(15, OTPInnerView.frame.size.width/2.8, OTPInnerView.frame.size.width - 30, 35)];
    otptxtFld.delegate=self;
    otptxtFld.keyboardType = UIKeyboardTypeNumberPad;
    otptxtFld.placeholder = @"PLEASE ENTER OTP";
    //otptxtFld.text = @"digipqr";
    [constant addfeild:OTPInnerView textfeild:otptxtFld];
    
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar.items = @[[[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelNumberPad)],
                            [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                            [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
    [numberToolbar sizeToFit];
    otptxtFld.inputAccessoryView = numberToolbar;
    
    timetext = [[UILabel alloc]initWithFrame:CGRectMake(OTPInnerView.frame.size.width - 65, otptxtFld.frame.origin.y, 50, 30)];
    [timetext setFont:[UIFont fontWithName:@"Roboto-Regular" size:11]];
    [timetext setTextColor:[UIColor darkGrayColor]];
    
    
    UIButton * resendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    resendBtn.frame = CGRectMake(OTPInnerView.frame.size.width - 70, (otptxtFld.frame.origin.y + otptxtFld.frame.size.height) + 5, 50, 20);
    //resendBtn.backgroundColor = [UIColor yellowColor];
    resendBtn.font = [UIFont fontWithName:@"Roboto-Regular" size:11];
    [resendBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [resendBtn setTitle:@"Resend" forState:UIControlStateNormal];
    [resendBtn addTarget:self action:@selector(resendTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel * RcvdLbl = [[UILabel alloc]initWithFrame:CGRectMake(resendBtn.frame.origin.x - 90, (otptxtFld.frame.origin.y + otptxtFld.frame.size.height) + 5 , 90, 20)];
    RcvdLbl.text = @"OTP not recieved?";
    RcvdLbl.textColor = [UIColor lightGrayColor];
    RcvdLbl.font = [UIFont fontWithName:@"Roboto-Regular" size:11];
    
    UIButton * VerifyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    VerifyBtn.frame = CGRectMake(OTPInnerView.frame.size.width/[constant.regSubmitPos floatValue], OTPInnerView.frame.size.height - 100, 150, 40);
    VerifyBtn.titleLabel.font = [UIFont fontWithName:@"Raleway-Bold" size:18.0];
    [VerifyBtn setTitle:@"VERIFY" forState:UIControlStateNormal];
    VerifyBtn.titleLabel.textColor = [UIColor whiteColor];
    VerifyBtn.backgroundColor = [UIColor redColor];
    VerifyBtn.layer.cornerRadius = 18.0f;
    [VerifyBtn addTarget:self action:@selector(VerifyTapped:) forControlEvents:UIControlEventTouchUpInside];
    
   // [OTPInnerView addSubview:closepopupBtn];
    [OTPInnerView addSubview:VerifyBtn];
    [OTPInnerView addSubview:RcvdLbl];
    [OTPInnerView addSubview:resendBtn];
    [OTPInnerView addSubview:timetext];
    [OTPInnerView addSubview:passLbl];
    [OTPMainview addSubview:OTPInnerView];
    [ForgotScroll addSubview:OTPMainview];
}

-(void)OTPDone{
    OTPMainview.hidden = true;
    tempview.hidden = true;
    [self.view endEditing:YES];
}

-(void)SetTimer{
    timer = [NSTimer scheduledTimerWithTimeInterval: 1.0 target:self selector:@selector(updateCountdown) userInfo:nil repeats: YES];
    secLeft = 60;
}

- (IBAction)resendTapped:(id)sender {
   // NSLog(@"sed left.. %d",secLeft);
     if([constant isActiveInternet] == YES){
    if(secLeft == 60){
        [self SetTimer];
       
        responseType = @"Resend";
        [constant sendRequest:self.view mutableDta:forgotData url:constant.forgotpasswordURL msgBody:otpStr];
    }else{
        [self.view makeToast:@"Please wait for one minute before generating new OTP"];
    }
     }else{
         [constant Redirect:self.navigationController Identifier:@"InternetDisconnectViewController"];
         //[self.view makeToast:@"Check your internet connection"];
     }
    
    
}




-(void) updateCountdown{
    //resendBtn.enabled = YES;
    if(secLeft > 0 ){
        secLeft -- ;
        minutes = (secLeft % 3600) / 60;
        seconds = (secLeft %3600) % 60;
        timetext.text = [NSString stringWithFormat:@"%02d:%02d Sec", minutes, seconds];
    }else{
        secLeft = 60;
        [timer invalidate];
    }
}

-(void)cancelNumberPad{
    [otptxtFld resignFirstResponder];
}

-(void)doneWithNumberPad{
    [otptxtFld resignFirstResponder];
}

- (void)keyboardDidShow:(NSNotification *)notification{
    ForgotScroll.contentSize = CGSizeMake(ForgotScroll.frame.size.width, ForgotScroll.frame.size.height + 150);
}

-(void)keyboardDidHide:(NSNotification *)notification{
    ForgotScroll.contentSize = CGSizeMake(ForgotScroll.frame.size.width, ForgotScroll.frame.size.height);
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    if(touch.view.tag==1000){
        [Email resignFirstResponder];
    }
}

-(void)backTapped{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)cancelKeyboard{
    [Mobile resignFirstResponder];
}

-(void)doneWithKeyboard{
    [Mobile resignFirstResponder];
}


- (IBAction)getPasswordTapped:(id)sender {
    [self.view endEditing:YES];
    responseType = @"GetPassword";
    NSLog(@"number.. %@",Mobile.text);
    [delegate.defaults setValue:Mobile.text forKey:@"VerifyMobile"];
    [delegate.defaults synchronize];
    [timer invalidate];
    [self SetTimer];
    if(Mobile.text.length>0){
        fldType = @"mobile";
        fldValue = Mobile.text;
    }
    if (Mobile.text.length == 0){
        [self.view makeToast:@"Please provide proper information"];
    }else{
         if([constant isActiveInternet] == YES){
        otpStr = [NSString stringWithFormat:@"%@=%@",fldType,fldValue];
        NSLog(@"url.. %@",constant.forgotpasswordURL);
        NSLog(@"body.. %@",otpStr);
        [constant sendRequest:self.view mutableDta:forgotData url:constant.forgotpasswordURL msgBody:otpStr];
         }else{
             [constant Redirect:self.navigationController Identifier:@"InternetDisconnectViewController"];
             //[self.view makeToast:@"Check your internet connection"];
         }
        
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    if(textField == Mobile){
        NSString *mobileNumberPattern = @"[0-9]{10}";
        NSPredicate *mobileNumberPred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobileNumberPattern];
        BOOL matched = [mobileNumberPred evaluateWithObject:Mobile.text];
        if (matched == YES){
        }
        else{
            [self.view makeToast:@"Mobile number must be of 10 digits"];
        }
        
    }
}

- (void)sendResponse:(Common *)response data:(NSMutableArray*)data indicator:(UIActivityIndicatorView *)indicator{
   // NSLog(@"data %@",data);
    dispatch_sync(dispatch_get_main_queue(), ^{
        if(data != NULL){
            if([responseType isEqualToString:@"GetPassword"]){
                if([[data valueForKey:@"status"]intValue] == 1){
                    Mobile.text = nil;
                    OTPMainview.hidden = false;
                    tempview.hidden = false;
                }else if([[data valueForKey:@"status"]intValue] == -1){
                    [constant logoutFunction];
                }else{
                    [self.view makeToast:@"Invalid mobile number"];
                }
            }else if([responseType isEqualToString:@"Verify"]){
                NSLog(@"data.. %@",data);
                if([[data valueForKey:@"status"]intValue] == 1){
                    NSLog(@"token.. %@",[[data valueForKey:@"items"] valueForKey:@"token"]);
                    [delegate.defaults setValue:[[data valueForKey:@"items"] valueForKey:@"token"]  forKey:@"tokenStr"];
                    [delegate.defaults setValue:@"FromOTP" forKey:@"passroute"];
                    [delegate.defaults synchronize];
                    ChangePasswordViewController * change = [self.storyboard instantiateViewControllerWithIdentifier:@"ChangePasswordViewController"];
                    [self.navigationController pushViewController:change animated:YES];
                }else if([[data valueForKey:@"status"]intValue] == -1){
                    [constant logoutFunction];
                }else{
                    [self.view makeToast:@"Invalid OTP"];
                }
            }else if([responseType isEqualToString:@"Resend"]){
                NSLog(@"data.. %@",data);
                if([[data valueForKey:@"status"]intValue] == 1){
                    [self.view makeToast:@"New OTP has been sent to your mobile"];
                }else if([[data valueForKey:@"status"]intValue] == -1){
                    [constant logoutFunction];
                }else{
                    //[self.view makeToast:@"Invalid OTP"];
                }
            }
        }else{
            [self.view hideToastActivity];
            [self.view makeToast:@"Server Error"];
        }
        [self clearAll];
        [indicator stopAnimating];
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    });
}

- (IBAction)VerifyTapped:(id)sender {
    responseType = @"Verify";
    if(otptxtFld.text.length>0)
        [self GetOTP];
    else
        [self.view makeToast:@"Please enter OTP"];
}

-(void)GetOTP{
     if([constant isActiveInternet] == YES){
    NSString *messageBody = [NSString stringWithFormat:@"mobile=%@&otp_key=%@",[delegate.defaults valueForKey:@"VerifyMobile"],otptxtFld.text];
    NSLog(@"messageBody %@",messageBody);
    NSLog(@"constant.verifyOTPURL %@",constant.verifyOTPURL);
    
    [constant sendRequest:self.view mutableDta:otpdata url:constant.verifyOTPURL msgBody:messageBody];
     }else{
         [constant Redirect:self.navigationController Identifier:@"InternetDisconnectViewController"];
         //[self.view makeToast:@"Check your internet connection"];
     }
}



//-(void)ForgotResponse:(NSData *)data{
//    NSMutableArray *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//    NSLog(@"result..%@",result);
//    dispatch_sync(dispatch_get_main_queue(), ^{
//        if(result != NULL && [[result valueForKey:@"status"] intValue]==0){
//            [self.view makeToast:[result valueForKey:@"message"]];
//        }else{
//            [self.view makeToast:[result valueForKey:@"message"]];
//        }
//        [self clearAll];
//        [indicator stopAnimating];
//    });
//}

-(void)clearAll{
    Email.text = nil;
    Mobile.text = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
