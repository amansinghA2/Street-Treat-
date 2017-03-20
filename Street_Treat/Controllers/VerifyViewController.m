//
//  VerifyViewController.m
//  Street_Treat
//
//  Created by Kamlesh Dubey on 6/28/16.
//  Copyright © 2016 Digillence Rolson. All rights reserved.
//

#import "VerifyViewController.h"

@interface VerifyViewController ()

@end

@implementation VerifyViewController
@synthesize otptxtFld,otptext,verifyBtn,timetext,resendBtn,getRegFlds,GetLoginBody;

-(void) viewWillAppear:(BOOL)animated{
    [delegate.defaults setObject:@"VerifyViewController" forKey:@"internetdisconnect"];
    [self SetTimer];
}

-(void)updateCountdown{
    resendBtn.enabled = YES;
    if(secLeft > 0 ){
        secLeft -- ;
        minutes = (secLeft % 3600) / 60;
        seconds = (secLeft %3600) % 60;
        timetext.text = [NSString stringWithFormat:@"%02d:%02d Sec", minutes, seconds];
    }else{
        secLeft = 180;
        [timer invalidate];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    constant = [[Common alloc]init];
    constant.delegate = self;
    delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    otpdata =[[NSMutableData alloc]init];
    LoginData = [[NSMutableData alloc]init];
    [constant addNavigationBar:self.view];
    resendBtn.enabled = NO;
    
    backBtn = (UIButton *)[self.view viewWithTag:1111];
    [backBtn addTarget:self action:@selector(backTapped) forControlEvents:UIControlEventTouchUpInside];
    backBtn.hidden = TRUE;
    UISearchBar *search = (UISearchBar *)[self.view viewWithTag:11111];
    search.hidden = TRUE;
    UIButton *menubtn = (UIButton *)[self.view viewWithTag:111];
    menubtn.hidden = TRUE;
    UIButton *notificationbtn = (UIButton *)[self.view viewWithTag:222];
    notificationbtn.hidden = TRUE;
    
    UIButton *current_Loc = (UIButton *)[self.view viewWithTag:444];
    current_Loc.hidden = TRUE;

    
    otptxtFld = [[RPFloatingPlaceholderTextField alloc]initWithFrame:CGRectMake(20, otptext.frame.origin.y-50, self.view.frame.size.width - 40, 35)];
    otptxtFld.delegate=self;
    otptxtFld.keyboardType = UIKeyboardTypeNumberPad;
    otptxtFld.placeholder = @"PLEASE ENTER OTP";
    //otptxtFld.text = @"digipqr";
    [constant addfeild:self.view textfeild:otptxtFld];
    
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar.items = @[[[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelNumberPad)],
                            [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                            [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
    [numberToolbar sizeToFit];
    otptxtFld.inputAccessoryView = numberToolbar;
    
    timetext = [[UILabel alloc]initWithFrame:CGRectMake(resendBtn.frame.origin.x, otptxtFld.frame.origin.y, 60, 30)];
    [timetext setFont:[UIFont fontWithName:@"Roboto-Regular" size:11]];
    [timetext setTextColor:[UIColor darkGrayColor]];
    [self.view addSubview:timetext];
    
}

-(void)cancelNumberPad{
    [otptxtFld resignFirstResponder];
}

-(void)doneWithNumberPad{
    [otptxtFld resignFirstResponder];
}

-(void)backTapped{
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    [self.view endEditing:YES];
    return YES;
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
    NSString *messageBody = [NSString stringWithFormat:@"mobile=%@&otp=%@",[delegate.defaults valueForKey:@"mobile"],otptxtFld.text];
    [constant sendRequest:self.view mutableDta:otpdata url:constant.otpURL msgBody:messageBody];
    }else{
        [constant Redirect:self.navigationController Identifier:@"InternetDisconnectViewController"];
        //[self.view makeToast:@"Check your internet connection"];
    }
}

- (void)sendResponse:(Common *)response data:(NSMutableArray*)data indicator:(UIActivityIndicatorView *)indicator{
    NSLog(@"data.. %@",data);
    dispatch_sync(dispatch_get_main_queue(), ^{
        if([responseType isEqualToString:@"Verify"]){
            if([[data valueForKey:@"status"] intValue]==0){
                [self.view makeToast:[data valueForKey:@"message"]];
            }else if([[data valueForKey:@"status"]intValue] == -1){
                [constant logoutFunction];
            }else{
                otptxtFld.text = nil;
                [timer invalidate];
                backBtn.hidden = FALSE;
                responseType = @"Login";
                
                //Commented Out
                [constant sendRequest:self.view mutableDta:LoginData url:constant.LoginURL msgBody:GetLoginBody];
            }
        }else if([responseType isEqualToString:@"Login"]){
             NSLog(@"data.. %@",data);
            if([[data valueForKey:@"status"]intValue] == 1){
                UITabBarController *tabbar = [self.storyboard instantiateViewControllerWithIdentifier:@"Street_TreatTabbar"];
                [self.navigationController pushViewController:tabbar animated:YES];
            }else if([[data valueForKey:@"status"]intValue] == -1){
                [constant logoutFunction];
            }else{
                [indicator stopAnimating];
                [[UIApplication sharedApplication] endIgnoringInteractionEvents];
                [self.view makeToast:[data valueForKey:@"message"]];
            }
        }else{
            [self.view makeToast:[data valueForKey:@"message"]];
            [timer invalidate];
        }
        [indicator stopAnimating];
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        
    });
}

- (IBAction)resendTapped:(id)sender {
    [self SetTimer];
    responseType = @"Resend";
    //[self GetOTP];
    // NSLog(@"otp.. %@",getRegFlds);
    if([constant isActiveInternet] == YES){

    NSString *messageBody = [NSString stringWithFormat:@"mobile=%@",[delegate.defaults valueForKey:@"mobile"]];
    [constant sendRequest:self.view mutableDta:otpdata url:constant.generatenewotpURL msgBody:messageBody];
    }else{
        [constant Redirect:self.navigationController Identifier:@"InternetDisconnectViewController"];
        //[self.view makeToast:@"Check your internet connection"];
    }
    //[self.view makeToast:@"New OTP has been sent to your registered mobile"];
}

-(void)SetTimer{
    timer = [NSTimer scheduledTimerWithTimeInterval: 1.0 target:self selector:@selector(updateCountdown) userInfo:nil repeats: YES];
    secLeft = 180;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
