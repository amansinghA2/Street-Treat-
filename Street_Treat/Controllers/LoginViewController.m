//
//  LoginViewController.m
//  Street_Treat
//
//  Created by Kamlesh Dubey on 5/12/16.
//  Copyright (c) 2016 Digillence Rolson. All rights reserved.
//

#import "LoginViewController.h"
#import "ForgotPassViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface LoginViewController ()

@end

@implementation LoginViewController
@synthesize LoginGoogleView,submitBtn,passTxtFld,usertxtFld,LoginBtn;
@synthesize LoginView,RegisterView,setRegFlds,SetLoginBody;
@synthesize locationManager,firstnametxtFld,lastnametxtFld,mobilenotxtFld,emailtxtFld,reg_passtxtFld,reg_cnf_passtxtFld,reg_submitBtn,Malebtn,femaleBtn,hdr_Underline,regHdrBtn,genderStr,fbicon,gplusicon,LoginScroll;
//float usryPos,passyPos;

#define MAX_LENGTH 10

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = true;
    commonclass.delegate = self;
    [self LoginHdrTapped:nil];
    LoginBtn.titleLabel.textColor = [UIColor redColor];
//    [commonclass setNavigationController:self.navigationController tabBarController:self.tabBarController viewController:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    commonclass = [[Common alloc]init];
    delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate=self;
    locationManager.desiredAccuracy=kCLLocationAccuracyBest;
    locationManager.distanceFilter=kCLDistanceFilterNone;
    [locationManager requestWhenInUseAuthorization];
    [locationManager startMonitoringSignificantLocationChanges];
    [locationManager startUpdatingLocation];
    [delegate.defaults setObject:@"DashboardViewController" forKey:@"internetdisconnect"];
    [delegate.defaults synchronize];
    //self.tabBarController.tabBar.hidden = YES;
     [GIDSignIn sharedInstance].uiDelegate = self;
    //    [delegate.defaults setValue:@"0" forKey:@"helpScreen"];
    iskeyboardPresent = YES;
    iskeyboardAppeared = NO;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    
//    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
//    // Optional: Place the button in the center of your view.
//    loginButton.center = self.view.center;
//    [self.view addSubview:loginButton];
     LoginGoogleView.hidden = TRUE;
    //LoginFBView.hidden = TRUE;
    _loginButton.hidden = true;
    LoginGoogleView.layer.cornerRadius = 20.0f;
    LoginGoogleView.layer.masksToBounds = YES;
//    LoginFBView.layer.cornerRadius = 20.0f;
//    LoginFBView.layer.masksToBounds = YES;
    _loginButton.layer.cornerRadius = 10.0f;
    _loginButton.layer.masksToBounds= YES;
    submitBtn.layer.cornerRadius = 20.0f;
    submitBtn.layer.masksToBounds = YES;
    PrevX = hdr_Underline.frame.origin.x;
    PrevY = hdr_Underline.frame.origin.y;
    nextX = regHdrBtn.frame.origin.x;
    LoginData = [[NSMutableData alloc]init];
    RegisterData = [[NSMutableData alloc]init];
    uniqueEmailData = [[NSMutableData alloc]init];
    //setRegFlds = [[NSMutableArray alloc]init];
    uniqueMobileData = [[NSMutableData alloc]init];
    LoginFBData = [[NSMutableData alloc]init];
    genderStr = @"Male";
    
    if ([FBSDKAccessToken currentAccessToken]) {
        UITabBarController *tabbar = [self.storyboard instantiateViewControllerWithIdentifier:@"Street_TreatTabbar"];
        [self.navigationController pushViewController:tabbar animated:YES];
        // User is logged in, do work such as go to next view controller.
    }
    
    fbicon.text = commonclass.Fbicon;
    gplusicon.text = commonclass.gPlusicon;
    
    regFlds = [[NSArray alloc]initWithObjects:firstnametxtFld,lastnametxtFld,mobilenotxtFld,emailtxtFld,reg_passtxtFld,reg_cnf_passtxtFld, nil];
    
    // Login feilds
    usertxtFld = [[RPFloatingPlaceholderTextField alloc]initWithFrame:CGRectMake(LoginGoogleView.frame.origin.x,[commonclass.usryPos floatValue], LoginGoogleView.frame.size.width, 35)];
    usertxtFld.delegate=self;
    usertxtFld.text = @"";
    usertxtFld.placeholder = @"USERNAME";
    usertxtFld.returnKeyType = UIReturnKeyNext;
    [commonclass addfeild:LoginView textfeild:usertxtFld];
    
    passTxtFld = [[RPFloatingPlaceholderTextField alloc]initWithFrame:CGRectMake(LoginGoogleView.frame.origin.x, usertxtFld.frame.origin.y+[commonclass.passyPos floatValue], LoginGoogleView.frame.size.width, 35)];
    passTxtFld.delegate=self;
    passTxtFld.secureTextEntry = YES;
    passTxtFld.returnKeyType = UIReturnKeyDefault;
    passTxtFld.placeholder = @"PASSWORD";
    passTxtFld.text = @"";
    [commonclass addfeild:LoginView textfeild:passTxtFld];
    //end
    
    // Registration feilds
    firstnametxtFld = [[RPFloatingPlaceholderTextField alloc]initWithFrame:CGRectMake(LoginGoogleView.frame.origin.x,[commonclass.usryPos floatValue], LoginGoogleView.frame.size.width / 2.5, 35)];
    firstnametxtFld.delegate=self;
    firstnametxtFld.placeholder = @"FIRSTNAME*";
    firstnametxtFld.text =@"";
    firstnametxtFld.returnKeyType = UIReturnKeyNext;
    [commonclass addfeild:RegisterView textfeild:firstnametxtFld];
    
    lastnametxtFld = [[RPFloatingPlaceholderTextField alloc]initWithFrame:CGRectMake(firstnametxtFld.frame.size.width * 1.80,[commonclass.usryPos floatValue], LoginGoogleView.frame.size.width / 2.5, 35)];
    lastnametxtFld.delegate=self;
    lastnametxtFld.placeholder = @"LASTNAME*";
    lastnametxtFld.text =@"";
    lastnametxtFld.returnKeyType = UIReturnKeyNext;
    [commonclass addfeild:RegisterView textfeild:lastnametxtFld];
    
    emailtxtFld = [[RPFloatingPlaceholderTextField alloc]initWithFrame:CGRectMake(LoginGoogleView.frame.origin.x, lastnametxtFld.frame.origin.y+[commonclass.passyPos floatValue], LoginGoogleView.frame.size.width + 16, 35)];
    emailtxtFld.delegate=self;
    emailtxtFld.returnKeyType = UIReturnKeyNext;
    emailtxtFld.keyboardType = UIKeyboardTypeEmailAddress;
    emailtxtFld.placeholder = @"EMAIL*";
    emailtxtFld.text =@"";
    [commonclass addfeild:RegisterView textfeild:emailtxtFld];
    
    mobilenotxtFld = [[RPFloatingPlaceholderTextField alloc]initWithFrame:CGRectMake(LoginGoogleView.frame.origin.x, emailtxtFld.frame.origin.y+[commonclass.passyPos floatValue], LoginGoogleView.frame.size.width + 16, 35)];
    mobilenotxtFld.delegate=self;
    mobilenotxtFld.placeholder = @"MOBILE NUMBER";
    mobilenotxtFld.keyboardType = UIKeyboardTypeNumberPad;
    mobilenotxtFld.returnKeyType = UIReturnKeyNext;
   // mobilenotxtFld.text =@"8055642405";
    [commonclass addfeild:RegisterView textfeild:mobilenotxtFld];
    
    reg_passtxtFld = [[RPFloatingPlaceholderTextField alloc]initWithFrame:CGRectMake(LoginGoogleView.frame.origin.x, mobilenotxtFld.frame.origin.y+[commonclass.passyPos floatValue], LoginGoogleView.frame.size.width + 16, 35)];
    reg_passtxtFld.delegate=self;
    reg_passtxtFld.secureTextEntry = YES;
    reg_passtxtFld.returnKeyType = UIReturnKeyNext;
    reg_passtxtFld.placeholder = @"PASSWORD*";
    reg_passtxtFld.text =@"";
    [commonclass addfeild:RegisterView textfeild:reg_passtxtFld];
    
    reg_cnf_passtxtFld = [[RPFloatingPlaceholderTextField alloc]initWithFrame:CGRectMake(LoginGoogleView.frame.origin.x, reg_passtxtFld.frame.origin.y+[commonclass.passyPos floatValue], LoginGoogleView.frame.size.width + 16, 35)];
    reg_cnf_passtxtFld.delegate=self;
    reg_cnf_passtxtFld.secureTextEntry = YES;
    reg_cnf_passtxtFld.placeholder = @"CONFIRM PASSWORD*";
    reg_cnf_passtxtFld.text =@"";
    reg_cnf_passtxtFld.returnKeyType = UIReturnKeyNext;
    [commonclass addfeild:RegisterView textfeild:reg_cnf_passtxtFld];
    //end
    
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar.items = @[[[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelNumberPad)],
                            [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],[[UIBarButtonItem alloc]initWithTitle:@"Next" style:UIBarButtonItemStyleDone target:self action:@selector(jumpToNext)],[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                            [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
    [numberToolbar sizeToFit];
    mobilenotxtFld.inputAccessoryView = numberToolbar;
    
    UIToolbar* numberToolbarTxtFlds = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    numberToolbarTxtFlds.barStyle = UIBarStyleBlackTranslucent;
    numberToolbarTxtFlds.items = @[[[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelKeyboard)],
                                   [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                                   [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithKeyboard)]];
    [numberToolbarTxtFlds sizeToFit];
    usertxtFld.inputAccessoryView = numberToolbarTxtFlds;
    passTxtFld.inputAccessoryView = numberToolbarTxtFlds;
    firstnametxtFld.inputAccessoryView = numberToolbarTxtFlds;
    lastnametxtFld.inputAccessoryView = numberToolbarTxtFlds;
    emailtxtFld.inputAccessoryView = numberToolbarTxtFlds;
    reg_passtxtFld.inputAccessoryView = numberToolbarTxtFlds;
    reg_cnf_passtxtFld.inputAccessoryView = numberToolbarTxtFlds;
    
    reg_submitBtn.layer.cornerRadius = 20.0f;
    
    [commonclass genderBtn:Malebtn corners:(UIRectCornerTopLeft | UIRectCornerBottomLeft)];
    [commonclass genderBtn:femaleBtn corners:(UIRectCornerTopRight | UIRectCornerBottomRight)];
    
   // [GIDSignIn sharedInstance].uiDelegate = self;
    //[[GIDSignIn sharedInstance] signInSilently];
    
    [GIDSignIn sharedInstance].delegate = self;
    _fbloginButton.delegate = self;
    _fbloginButton.readPermissions =
    @[@"public_profile", @"email", @"user_friends"];
//    self.LoginFBView.delegate = self;
//    self.LoginFBView.readPermissions = @[@"public_profile", @"email"];
//    for (id loginObject in self.LoginFBView.subviews)
//    {
//        if ([loginObject isKindOfClass:[UIButton class]])
//        {
//            UIButton * loginButton =  loginObject;
//            UIImage *loginImage = [UIImage imageNamed:@"f connect.png"];
//            [loginButton setBackgroundImage:loginImage forState:UIControlStateNormal];
//            [loginButton setBackgroundImage:nil forState:UIControlStateSelected];
//            [loginButton setBackgroundImage:nil forState:UIControlStateHighlighted];
//            
//        }
//        if ([loginObject isKindOfClass:[UILabel class]])
//        {
//            UILabel * loginLabel =  loginObject;
//            if([loginLabel.text isEqualToString:@"Log in with Facebook"]){
//                loginLabel.text = @"";
//            }
//            //loginLabel.hidden=YES;
//            //loginLabel.text = @"";
//            //            loginLabel.frame = CGRectMake(0, 0, 0, 0);
//        }
//    }
    
//    LoginFBView.backgroundColor = [UIColor FBColor];
//    self.LoginFBView.loginBehavior=FBSessionLoginBehaviorForcingWebView;
    
    //    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(GPlusLogin)];
    //    [self.LoginGoogleView addGestureRecognizer:gestureRecognizer];
    //    // gestureRecognizer.cancelsTouchesInView = NO;
    
    //    UISwipeGestureRecognizer * swipedown=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipedown:)];
    //    swipedown.direction=UISwipeGestureRecognizerDirectionDown;
    //    [self.view addGestureRecognizer:swipedown];
    //
    //    UISwipeGestureRecognizer * swipeup=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeup:)];
    //    swipeup.direction=UISwipeGestureRecognizerDirectionUp;
    //    [self.view addGestureRecognizer:swipeup];
    
    //    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panRecognizer_Panned:)];
    //    [self.view addGestureRecognizer:panRecognizer];
}

-(void)cancelKeyboard{
    [usertxtFld resignFirstResponder];
    [passTxtFld resignFirstResponder];
    [firstnametxtFld resignFirstResponder];
    [lastnametxtFld resignFirstResponder];
    [emailtxtFld resignFirstResponder];
    [reg_passtxtFld resignFirstResponder];
    [reg_cnf_passtxtFld resignFirstResponder];
}

-(void)doneWithKeyboard{
    [usertxtFld resignFirstResponder];
    [passTxtFld resignFirstResponder];
    [firstnametxtFld resignFirstResponder];
    [lastnametxtFld resignFirstResponder];
    [emailtxtFld resignFirstResponder];
    [reg_passtxtFld resignFirstResponder];
    [reg_cnf_passtxtFld resignFirstResponder];
}



-(void)jumpToNext{
    [reg_passtxtFld becomeFirstResponder];
}

-(void)cancelNumberPad{
    [mobilenotxtFld resignFirstResponder];
    iskeyboardPresent = YES;
    iskeyboardAppeared = NO;
    //iskeyboardAppeared = YES;
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    touch = [touches anyObject];
    if(touch.view.tag==1000){
        [usertxtFld resignFirstResponder];
        [passTxtFld resignFirstResponder];
    }
}

-(void)doneWithNumberPad{
    [mobilenotxtFld resignFirstResponder];
    iskeyboardPresent = YES;
    iskeyboardAppeared = NO;
    //[self swipedown:nil];
}


-(void)GPlusLogin{
    [[GIDSignIn sharedInstance] signIn];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == usertxtFld) {
        [passTxtFld becomeFirstResponder];
    }else if (textField == passTxtFld) {
        [textField resignFirstResponder];
        [self.view endEditing:YES];
    }else if (textField == firstnametxtFld) {
        [lastnametxtFld becomeFirstResponder];
    }else if (textField == lastnametxtFld) {
        [emailtxtFld becomeFirstResponder];
    }else if (textField == emailtxtFld) {
        [mobilenotxtFld becomeFirstResponder];
    }else if (textField == mobilenotxtFld) {
        [reg_passtxtFld becomeFirstResponder];
    }else if (textField == reg_passtxtFld) {
        [reg_cnf_passtxtFld becomeFirstResponder];
    }else if (textField == reg_cnf_passtxtFld) {
        [textField resignFirstResponder];
        iskeyboardPresent = YES;
        iskeyboardAppeared = NO;
        textfeildtype = @"";
    }
    return YES;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField == reg_cnf_passtxtFld) {
        reg_cnf_passtxtFld.returnKeyType = UIReturnKeyDone;
    }
    if(textField == mobilenotxtFld){
        textfeildtype = @"mobile";
    }else if(textField == reg_passtxtFld){
        textfeildtype = @"password";
    }else if(textField == reg_cnf_passtxtFld){
        iskeyboardPresent = YES;
        iskeyboardAppeared = YES;
        textfeildtype = @"cnfpassword";
    }
    return YES;
}

- (BOOL) validateFirst_LastName: (NSString *) candidate {
    NSString *emailRegex = @"^[a-zA-Z0-9]{2,25}$";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:candidate];
}

- (BOOL) validatePassword: (NSString *) candidate {
    NSString *passRegex = @"^[a-zA-Z0-9]{6,20}$";
    NSPredicate *passTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", passRegex];
    
    return [passTest evaluateWithObject:candidate];
}

- (BOOL) validateEmail: (NSString *) candidate {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:candidate];
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if(textField == mobilenotxtFld){
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
       if(newLength > MAX_LENGTH){
        return NO;
       }else{
         return YES;
       }
    }
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    if(textField == reg_cnf_passtxtFld){
        iskeyboardPresent = YES;
        iskeyboardAppeared = NO;
    }
    [self.view endEditing:YES];
    return YES;
}


- (void)keyboardDidShow:(NSNotification *)notification
{
    //   if(iskeyboardPresent == YES && iskeyboardAppeared == NO){
    iskeyboardAppeared = YES;
    LoginScroll.contentSize = CGSizeMake(LoginScroll.frame.size.width, LoginScroll.frame.size.height + 200);
    //    }
    LoginScroll.scrollEnabled = YES;
}

-(void)keyboardDidHide:(NSNotification *)notification
{
    //    if(iskeyboardPresent == YES && iskeyboardAppeared == NO){
    iskeyboardAppeared = NO;
    LoginScroll.contentSize = CGSizeMake(LoginScroll.frame.size.width, LoginScroll.frame.size.height);
    //    }
    LoginScroll.scrollEnabled = NO;
}



- (IBAction)submitTapped:(id)sender {
    if((usertxtFld.text == nil && passTxtFld.text == nil) || usertxtFld.text == nil || passTxtFld.text == nil ){
        [self.view makeToast:@"Please provide proper information"];
    }else{
        requestType = @"Login";
        if([commonclass isActiveInternet] == YES){
        [commonclass AddLoader:[[UIApplication sharedApplication] keyWindow]];
        NSString *messageBody = [NSString stringWithFormat:@"username=%@&password=%@&device_os=ios&device_token=%@",usertxtFld.text,passTxtFld.text,[delegate.defaults valueForKey:@"deviceToken"]];
        NSLog(@"body.. %@",messageBody);
        NSLog(@"commonclass.LoginURL.. %@",commonclass.LoginURL);
        [commonclass sendRequest:self.view mutableDta:LoginData url:commonclass.LoginURL msgBody:messageBody];
        }else{
            [commonclass Redirect:self.navigationController Identifier:@"InternetDisconnectViewController"];
            //[self.view makeToast:@"Check your internet connection"];
        }
    }
}


- (void)sendResponse:(Common *)response data:(NSMutableArray*)data indicator:(UIActivityIndicatorView *)indicator{
    NSLog(@"data.. %@",data);
    dispatch_sync(dispatch_get_main_queue(), ^{
        if(data != NULL){
            if([requestType isEqualToString:@"Login"]){
                if([[data valueForKey:@"status"]intValue] == 1){
                    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"firstLaunch"];
                    NSString * log_id = [[data valueForKey:@"items"] valueForKey:@"log_id"] ;
                   // NSString * log_id = @"4d0054923037ac2b343e804c432679f7";
                    NSString * log_name = [[data valueForKey:@"items"] valueForKey:@"username"];//name
                    NSString * usr_name = [[data valueForKey:@"items"] valueForKey:@"name"];
                    NSString * mobile = [[data valueForKey:@"items"] valueForKey:@"mobile"];
                    
                    if (mobile == nil || [mobile isEqualToString:@""]){
                        [delegate.defaults setBool:false forKey:@"updateMobile"];
                    }else{
                        [delegate.defaults setBool:true forKey:@"updateMobile"];
                    }
                    
                    NSString * otp_Verified = [[data valueForKey:@"items"] valueForKey:@"otp_verified"];
                    NSLog(@"%@",otp_Verified);
                    [delegate.defaults setObject:otp_Verified forKey:@"otp_verified"];
                    [delegate.defaults setValue:log_id forKey:@"logid"];
                    [delegate.defaults setValue:mobile forKey:@"mobile"];
                    [delegate.defaults setValue:log_name forKey:@"logname"];
                    [delegate.defaults setValue:usr_name forKey:@"usr_name"];
                    
                    [delegate.defaults synchronize];
                    [self ClearAll];
                    UITabBarController *tabbar = [self.storyboard instantiateViewControllerWithIdentifier:@"Street_TreatTabbar"];
                    [self.navigationController pushViewController:tabbar animated:YES];
                    //[commonclass RemoveLoader:[[UIApplication sharedApplication] keyWindow]];
                }else if([[data valueForKey:@"status"]intValue] == -1){
                    [commonclass logoutFunction];
                }else{
                    [self.view makeToast:[data valueForKey:@"message"]];
                }
            }else if ([requestType isEqualToString:@"Unique_Email"]){
                if([[data valueForKey:@"status"] intValue] == 1){
                }else if([[data valueForKey:@"status"]intValue] == -1){
                    [commonclass logoutFunction];
                }else{
                    [self.view makeToast:[data valueForKey:@"message"]];
                }
            }else if ([requestType isEqualToString:@"Unique_Mobile"]){
                if([[data valueForKey:@"status"] intValue] == 1){
                }else if([[data valueForKey:@"status"]intValue] == -1){
                    [commonclass logoutFunction];
                }else{
                    [self.view makeToast:[data valueForKey:@"message"]];
                }
            }else if ([requestType isEqualToString:@"Register"]){
                if([[data valueForKey:@"status"]intValue] == 1){
                   [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"firstLaunch"];
//                    NSString * otp_Verified = [[data valueForKey:@"items"] valueForKey:@"otp_verified"];
//                    [delegate.defaults setBool:otp_Verified forKey:@"otp_verified"];
                    [self.view makeToast:[data valueForKey:@"message"] duration:2.0 position:CSToastPositionBottom];
                    requestType = @"Login";
                    NSLog(@"body.. %@",SetLoginBody);
                 //  NSTimer  *timer = [NSTimer scheduledTimerWithTimeInterval: 2.0 target:self selector:@selector(updateCountdown) userInfo:nil repeats:NO];
                    if(mobilenotxtFld.text.length == 10){
                      //  [delegate.defaults setObject:true forKey:@"otp_verified"];
                        VerifyViewController * result = [self.storyboard instantiateViewControllerWithIdentifier:@"VerifyViewController"];
                        result.getRegFlds = setRegFlds;
                        result.GetLoginBody = SetLoginBody;
                        NSString * mobile = mobilenotxtFld.text;
                        [delegate.defaults setValue:mobile forKey:@"mobile"];
                        [delegate.defaults synchronize];
                        //[self ClearAll];
                        [self.navigationController pushViewController:result animated:YES];
                    }else {
                        if([commonclass isActiveInternet] == YES){
                            // [delegate.defaults setBool:false forKey:@"otp_verified"];
                            [commonclass sendRequest:self.view mutableDta:LoginData url:commonclass.LoginURL msgBody:SetLoginBody];
                        }else{
                            [commonclass Redirect:self.navigationController Identifier:@"InternetDisconnectViewController"];
                            //[self.view makeToast:@"Check your internet connection"];
                        }
                    }
                }else if([[data valueForKey:@"status"]intValue] == -1){
                    [commonclass logoutFunction];
                }else{
//                    if([commonclass isActiveInternet] == YES){
//                        // [delegate.defaults setBool:false forKey:@"otp_verified"];
//                        [commonclass sendRequest:self.view mutableDta:LoginData url:commonclass.LoginURL msgBody:SetLoginBody];
//                    }else{
//                        [commonclass Redirect:self.navigationController Identifier:@"InternetDisconnectViewController"];
//                        //[self.view makeToast:@"Check your internet connection"];
//                    }
                }
            }else if ([requestType isEqualToString:@"GoogleSignIn"]){
                if([[data valueForKey:@"status"]intValue] == 1){
            NSLog(@"%@",data);
                    NSString * log_id = [[data valueForKey:@"items"] valueForKey:@"log_id"] ;
                    // NSString * log_id = @"4d0054923037ac2b343e804c432679f7";
                    NSString * log_name = [[data valueForKey:@"items"] valueForKey:@"username"];//name
                    NSString * usr_name = [[data valueForKey:@"items"] valueForKey:@"name"];
                    NSString * mobile = [[data valueForKey:@"items"] valueForKey:@"mobile"];
                    
                    if (mobile == nil || [mobile isEqualToString:@""]){
                        [delegate.defaults setBool:false forKey:@"updateMobile"];
                    }else{
                        [delegate.defaults setBool:true forKey:@"updateMobile"];
                    }
                    
                    NSString * otp_Verified = [[data valueForKey:@"items"] valueForKey:@"otp_verified"];
                    NSLog(@"%@",otp_Verified);
                    [delegate.defaults setObject:otp_Verified forKey:@"otp_verified"];
                    [delegate.defaults setValue:log_id forKey:@"logid"];
                    [delegate.defaults setValue:mobile forKey:@"mobile"];
                    [delegate.defaults setValue:log_name forKey:@"logname"];
                    [delegate.defaults setValue:usr_name forKey:@"usr_name"];
                    
                    [delegate.defaults synchronize];
            UITabBarController *tabbar = [self.storyboard instantiateViewControllerWithIdentifier:@"Street_TreatTabbar"];
                    
            [self.navigationController pushViewController:tabbar animated:YES];
            [[FBSDKLoginManager new] logOut];
            [[GIDSignIn sharedInstance] signOut];
                }else if([[data valueForKey:@"status"]intValue] == -1){
                    [commonclass logoutFunction];
                }else{
                }
            }else if ([requestType isEqualToString:@"FaceBook"]){
                if([[data valueForKey:@"status"]intValue] == 1){
                NSLog(@"dsfdsf%@",@"Lol");
                    NSString * log_id = [[data valueForKey:@"items"] valueForKey:@"log_id"] ;
                    // NSString * log_id = @"4d0054923037ac2b343e804c432679f7";
                    NSString * log_name = [[data valueForKey:@"items"] valueForKey:@"username"];//name
                    NSString * usr_name = [[data valueForKey:@"items"] valueForKey:@"name"];
                    NSString * mobile = [[data valueForKey:@"items"] valueForKey:@"mobile"];
                    
                    if (mobile == nil || [mobile isEqualToString:@""]){
                        [delegate.defaults setBool:false forKey:@"updateMobile"];
                    }else{
                        [delegate.defaults setBool:true forKey:@"updateMobile"];
                    }
                    
                    NSString * otp_Verified = [[data valueForKey:@"items"] valueForKey:@"otp_verified"];
                    NSLog(@"%@",otp_Verified);
                    [delegate.defaults setObject:otp_Verified forKey:@"otp_verified"];
                    [delegate.defaults setValue:log_id forKey:@"logid"];
                    [delegate.defaults setValue:mobile forKey:@"mobile"];
                    [delegate.defaults setValue:log_name forKey:@"logname"];
                    [delegate.defaults setValue:usr_name forKey:@"usr_name"];
                    
                    [delegate.defaults synchronize];
//                UITabBarController *tabbar = [self.storyboard instantiateViewControllerWithIdentifier:@"Street_TreatTabbar"];
//                [self.navigationController pushViewController:tabbar animated:YES];
                 [[FBSDKLoginManager new] logOut];
                }
                else if([[data valueForKey:@"status"]intValue] == -1){
                    [commonclass logoutFunction];
                }else{
                    
                }
            }
        }else{
             [self.view makeToast:@"Oops server error occured"];
        }
        [indicator stopAnimating];
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        [commonclass RemoveLoader:[[UIApplication sharedApplication] keyWindow]];
        
    });
}

//-(void) updateCountdown{
//    UITabBarController *tabbar = [self.storyboard instantiateViewControllerWithIdentifier:@"Street_TreatTabbar"];
//    [self.navigationController pushViewController:tabbar animated:YES];
//}

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
    
    CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
    [geoCoder cancelGeocode];
    [geoCoder reverseGeocodeLocation:locationManager.location
                   completionHandler:^(NSArray *placemarks, NSError *error)
     {
         // NSLog(@"Error is %@",error.localizedDescription);
         for (CLPlacemark *placemark in placemarks) {
             locality = [NSString stringWithFormat:@"%@",placemark.subLocality];
             [delegate.defaults setValue:locality forKey:@"updateloc_name"];
             if (locality != nil){
             [delegate.defaults setValue:locality forKey:@"myloc_name"];
             }
      //     [delegate.defaults setValue:locality forKey:@"loc_name"];
         }
     }];
    
    // NSLog(@"Locality.. %@",locality);
    
    [delegate.defaults setValue:latstring forKey:@"latitude"];
    [delegate.defaults setValue:longstring forKey:@"longitude"];
    
    //    if([[[defaults dictionaryRepresentation] allKeys] containsObject:@"loc_name"]){
    //        NSLog(@"mykey found");
    //    }else{
    //        [defaults setValue:locality forKey:@"loc_name"];
    //        [defaults setValue:locality forKey:@"myloc_name"];
    //    }
    [delegate.defaults synchronize];
}


-(void)textFieldDidEndEditing:(UITextField *)textField{
    if(textField == mobilenotxtFld){
        NSString *mobileNumberPattern = @"[0-9]{10}";
        NSPredicate *mobileNumberPred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobileNumberPattern];
        BOOL matched = [mobileNumberPred evaluateWithObject:mobilenotxtFld.text];
        if (matched == YES){
            requestType = @"Unique_Mobile";
            if([commonclass isActiveInternet] == YES){
            NSString *messageBody = [NSString stringWithFormat:@"unique_field=mobile&value[0]=%@",mobilenotxtFld.text];
            NSLog(@"body.. %@",messageBody);
            [commonclass sendRequest:self.view mutableDta:uniqueMobileData url:commonclass.uniqueFldURL msgBody:messageBody];
            }else{
                [commonclass Redirect:self.navigationController Identifier:@"InternetDisconnectViewController"];
                //[self.view makeToast:@"Check your internet connection"];
            }
        }
        else{
            [self.view makeToast:@"Mobile number must be of 10 digits"];
        }
        
        
    }else if (textField == emailtxtFld){
        requestType = @"Unique_Email";
        if([commonclass isActiveInternet] == YES){
        NSString *messageBody = [NSString stringWithFormat:@"unique_field=email&value[0]=%@",emailtxtFld.text];
        NSLog(@"body.. %@",messageBody);
        NSLog(@"URl.... %@",commonclass.uniqueFldURL);
        [commonclass sendRequest:self.view mutableDta:uniqueEmailData url:commonclass.uniqueFldURL msgBody:messageBody];
        }else{
            [commonclass Redirect:self.navigationController Identifier:@"InternetDisconnectViewController"];
            //[self.view makeToast:@"Check your internet connection"];
        }
    }
//    else if (textField == reg_cnf_passtxtFld){
//        iskeyboardAppeared = YES;
//    }
    else if (textField == firstnametxtFld){
        if ([self validateFirst_LastName:textField.text]) {
         
        } else {
            [self.view endEditing:YES];
            [self.view makeToast:@"First name must be min 2 characters and max 25 characters" duration:4.0 position:CSToastPositionBottom];
        }
    }else if (textField == lastnametxtFld){
        if ([self validateFirst_LastName:textField.text]) {
            
        } else {
            [self.view endEditing:YES];
            [self.view makeToast:@"Last name must be min 2 characters and max 25 characters" duration:4.0 position:CSToastPositionBottom];
        }
    }else if (textField == reg_passtxtFld){
        if ([self validatePassword:textField.text]) {
            
        } else {
            [self.view endEditing:YES];
            [self.view makeToast:@"Password must be min 6 characters and max 20 characters" duration:4.0 position:CSToastPositionBottom];
        }
    }else if (textField == reg_cnf_passtxtFld){
        if ([self validatePassword:textField.text]) {
            
        } else {
            [self.view endEditing:YES];
            [self.view makeToast:@"Confirm Password name must be min 6 characters and max 20 characters" duration:4.0 position:CSToastPositionBottom];
        }
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)reg_SubmitTapped:(id)sender {
    [self.view endEditing:YES];
    //    BOOL isnull = false;
    if(![reg_passtxtFld.text isEqualToString:reg_cnf_passtxtFld.text]){
        [self.view makeToast:@"Password mismatch"];
        //}
        //
        //    for(UITextField * fld in regFlds){
        //        if(fld.text == nil){
        //            isnull = true;
        //            [self.view makeToast:@"Please provide proper information"];
        //        }else{
        //            isnull = false;
        //        }
        //    }
        //
        //    if(isnull == true ){
        //        [self.view makeToast:@"Please provide proper information"];
    }else{
        if(firstnametxtFld.text.length == 0){
            [self.view makeToast:@"First name is required"];
        }else if (lastnametxtFld.text.length == 0){
            [self.view makeToast:@"Last name is required"];
        }else if (emailtxtFld.text.length == 0){
            [self.view makeToast:@"Email is required"];
        }else if (reg_passtxtFld.text.length < 6){
            [self.view makeToast:@"Password is required"];
        }else if (reg_cnf_passtxtFld.text.length < 6){
            [self.view makeToast:@"Confirm Password is required"];
        }else{
            
            SetLoginBody = [NSString stringWithFormat:@"username=%@&password=%@&device_os=ios&device_token=%@",emailtxtFld.text,reg_passtxtFld.text,[delegate.defaults valueForKey:@"deviceToken"]];
            NSLog(@"body.. %@",SetLoginBody);
            
            requestType = @"Register";
            if([commonclass isActiveInternet] == YES){
            [commonclass AddLoader:[[UIApplication sharedApplication] keyWindow]];
            NSString *messageBody = [NSString stringWithFormat:@"name=%@&last_name=%@&email=%@&password=%@&mobile=%@&gender=%@&device_os=ios",firstnametxtFld.text,lastnametxtFld.text,emailtxtFld.text,reg_passtxtFld.text,mobilenotxtFld.text,genderStr];
            NSLog(@"body.. %@",messageBody);
            setRegFlds = messageBody;
            [commonclass sendRequest:self.view mutableDta:RegisterData url:commonclass.RegisterURL msgBody:messageBody];
            }else{
                [commonclass Redirect:self.navigationController Identifier:@"InternetDisconnectViewController"];
                //[self.view makeToast:@"Check your internet connection"];
            }
        }
    }
}

- (IBAction)ForgotTapped:(id)sender {
    ForgotPassViewController * forgot = [self.storyboard instantiateViewControllerWithIdentifier:@"ForgotPassViewController"];
    [self.navigationController pushViewController:forgot animated:YES];
}

- (IBAction)LoginHdrTapped:(id)sender {
    iskeyboardPresent = NO;
    LoginScroll.contentSize = CGSizeMake(LoginScroll.frame.size.width, LoginScroll.frame.size.height);
    LoginScroll.scrollEnabled = NO;
    [self.view endEditing:YES];
    [commonclass addSlideAnimation:hdr_Underline firstView:LoginView secondView:RegisterView button1:LoginBtn button2:regHdrBtn newX:(PrevX *2) - 15 newY:PrevY];
}

- (IBAction)RegisterHdrTapped:(id)sender {
    iskeyboardPresent = YES;
    [self.view endEditing:YES];
    LoginScroll.contentSize = CGSizeMake(LoginScroll.frame.size.width, LoginScroll.frame.size.height + 200);
    LoginScroll.scrollEnabled = NO;
    [commonclass addSlideAnimation:hdr_Underline firstView:RegisterView secondView:LoginView button1:regHdrBtn button2:LoginBtn newX:regHdrBtn.frame.origin.x newY:PrevY];
}

- (IBAction)GenderTapped:(UIButton *)sender{
    if(sender.tag == 1){
        Malebtn.backgroundColor = [UIColor TextColor_TxtFld];
        [Malebtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        femaleBtn.backgroundColor = [UIColor whiteColor];
        [femaleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        genderStr = @"Male";
    }else{
        Malebtn.backgroundColor = [UIColor whiteColor];
        [Malebtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        femaleBtn.backgroundColor = [UIColor TextColor_TxtFld];
        [femaleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        genderStr = @"Female";
    }
}

-(void)ClearAll{
    usertxtFld.text = nil;
    passTxtFld.text = nil;
    firstnametxtFld.text = nil;
    lastnametxtFld.text = nil;
    mobilenotxtFld.text = nil;
    emailtxtFld.text = nil;
    reg_passtxtFld.text = nil;
    reg_cnf_passtxtFld.text = nil;
}

#pragma mark - Private method implementation

-(void)toggleHiddenState:(BOOL)shouldHide{
}

#pragma mark - FBLoginView Delegate method implementation

//-(void)loginViewShowingLoggedInUser:(FBLoginView *)loginView{
//    [self toggleHiddenState:NO];
//}
//
//-(void)loginViewFetchedUserInfo:(FBLoginView *)loginView user:(id<FBGraphUser>)user{
//    NSString *fbAccessToken = [FBSession activeSession].accessTokenData.accessToken;
//    NSLog(@"%@", fbAccessToken);
//}
//
//-(void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView{
//    [self toggleHiddenState:YES];
//}
//
//-(void)loginView:(FBLoginView *)loginView handleError:(NSError *)error{
//    NSLog(@"%@", [error localizedDescription]);
//    for (id loginObject in self.LoginFBView.subviews)
//    {
//        if ([loginObject isKindOfClass:[UILabel class]])
//        {
//            UILabel * loginLabel =  loginObject;
//            if([loginLabel.text isEqualToString:@"Log in with Facebook"]){
//                loginLabel.text = @"";
//            }
//        }
//    }
//}

- (void)signInWillDispatch:(GIDSignIn *)signIn error:(NSError *)error {
    //[myActivityIndicator stopAnimating];
}

// Present a view that prompts the user to sign in with Google
- (void)signIn:(GIDSignIn *)signIn
presentViewController:(UIViewController *)viewController {
    [self presentViewController:viewController animated:YES completion:nil];
}

- (void)signIn:(GIDSignIn *)signIn
didSignInForUser:(GIDGoogleUser *)user
     withError:(NSError *)error {
    requestType = @"GoogleSignIn";
  [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"firstLaunch"];
    // Perform any operations on signed in user here.
    NSLog(@"user gplus token..%@",user.authentication.idToken);
    NSString *userId = user.userID;                  // For client-side use only!
    NSString *idToken = user.authentication.idToken; // Safe to send to the server
    NSString *fullName = user.profile.name;
    NSString *givenName = user.profile.givenName;
    NSString *familyName = user.profile.familyName;
    NSString *email = user.profile.email;
    
    NSString *messageBody = [NSString stringWithFormat:@"accesstoken=%@&login_type=%@&device_os=%@&device_token=%@",idToken,@"gmail",@"ios",[delegate.defaults valueForKey:@"deviceToken"]];
    NSLog(@"messageBody.. %@",messageBody);
    NSLog(@"constant.searchListURL.. %@",commonclass.searchListURL);
    [commonclass sendRequest:self.view mutableDta:LoginData url:commonclass.loginFBURL msgBody:messageBody];
    // ...
}

- (void)signIn:(GIDSignIn *)signIn
didDisconnectWithUser:(GIDGoogleUser *)user
     withError:(NSError *)error {
    // Perform any operations when the user disconnects from app here.
    // ...
}

// Dismiss the "Sign in with Google" view
- (void)signIn:(GIDSignIn *)signIn
dismissViewController:(UIViewController *)viewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = true;
}

- (IBAction)googleSignInAction:(id)sender {
    [delegate.defaults setObject:@"google" forKey:@"fborgoogle"];
    [GIDSignIn sharedInstance].delegate=self;
    [GIDSignIn sharedInstance].uiDelegate=self;
    [[GIDSignIn sharedInstance] signIn];
}
- (IBAction)facebookLoginAction:(id)sender {
//    self.loginButton.delegate = self;
//    self.LoginFBView.readPermissions = @[@"public_profile", @"email"];
}

// FB Delegate Methods

- (void)loginButton:(FBSDKLoginButton *)loginButton
didCompleteWithResult:	(FBSDKLoginManagerLoginResult *)result
error:	(NSError *)error{
    requestType = @"FaceBook";
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"firstLaunch"];
    [delegate.defaults setObject:@"fb" forKey:@"fborgoogle"];
    NSString *fbAccessToken = [FBSDKAccessToken currentAccessToken].tokenString;
    
    if (fbAccessToken != nil) {
        UITabBarController *tabbar = [self.storyboard instantiateViewControllerWithIdentifier:@"Street_TreatTabbar"];
        [self.navigationController pushViewController:tabbar animated:YES];
    }
    NSString *messageBody = [NSString stringWithFormat:@"accesstoken=%@&login_type=%@&device_os=%@&device_token=%@",fbAccessToken,@"facebook",@"ios",[delegate.defaults valueForKey:@"deviceToken"]];
    NSLog(@"messageBody.. %@",messageBody);
    NSLog(@"constant.searchListURL.. %@",commonclass.searchListURL);
    [commonclass sendRequest:self.view mutableDta:LoginData url:commonclass.loginFBURL msgBody:messageBody];
    
    //[[PFFacebookUtils facebookLoginManager] setLoginBehavior:FBSDKLoginBehaviorSystemAccount];
}

- (void) loginButtonDidLogOut:(FBSDKLoginButton *)loginButton{
    [[FBSDKLoginManager new] logOut];
}

- (BOOL) loginButtonWillLogin:(FBSDKLoginButton *)loginButton{
   [[FBSDKLoginManager new] logOut];
//   requestType = @"FaceBook";
//    NSString *fbAccessToken = [FBSDKAccessToken currentAccessToken].tokenString;
    requestType = @"FaceBook";
   [delegate.defaults setObject:@"fb" forKey:@"fborgoogle"];

    return true;
}

@end
