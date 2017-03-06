//
//  LoginViewController.h
//  Street_Treat
//
//  Created by Kamlesh Dubey on 5/12/16.
//  Copyright (c) 2016 Digillence Rolson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Common.h"
//#import <FacebookSDK/FacebookSDK.h>
#import <Google/SignIn.h>
#import "VerifyViewController.h"
#import "DashboardViewController.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface LoginViewController : UIViewController<GIDSignInDelegate,FBSDKLoginButtonDelegate, GIDSignInUIDelegate,UITextFieldDelegate,commonProtocol,UIGestureRecognizerDelegate,UIScrollViewDelegate,CLLocationManagerDelegate>{
    float PrevX,nextX,PrevY;
    Common * commonclass;
    AppDelegate * delegate;
    NSString * requestType;
    NSMutableData *LoginData;
    NSMutableData *RegisterData;
    NSMutableData *uniqueMobileData;
    NSMutableData *uniqueEmailData,*LoginFBData;
    NSArray * regFlds;
    BOOL iskeyboardPresent,iskeyboardAppeared;
    UITouch *touch;
    NSString * textfeildtype;
     NSString * locality;
}
- (IBAction)googleSignInAction:(id)sender;
- (void)loginButton:(FBSDKLoginButton *)loginButton
didCompleteWithResult:	(FBSDKLoginManagerLoginResult *)result
              error:	(NSError *)error;
- (void) loginButtonDidLogOut:(FBSDKLoginButton *)loginButton;
@property (weak, nonatomic) IBOutlet UIScrollView *LoginScroll;
@property (weak, nonatomic) IBOutlet UIButton *LoginBtn;
@property(nonatomic,retain) CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet UIButton *regHdrBtn;
- (IBAction)LoginHdrTapped:(id)sender;
- (IBAction)RegisterHdrTapped:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *hdr_Underline;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@property (strong, nonatomic) IBOutlet NSString *setRegFlds;
@property (strong, nonatomic) IBOutlet NSString *SetLoginBody;
- (IBAction)facebookLoginAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *LoginView;
@property (strong, nonatomic) IBOutlet RPFloatingPlaceholderTextField *usertxtFld;
@property (strong, nonatomic) IBOutlet RPFloatingPlaceholderTextField *passTxtFld;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
- (IBAction)submitTapped:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *LoginGoogleView;
//@property (weak, nonatomic) IBOutlet FBLoginView *LoginFBView;
@property (weak, nonatomic) IBOutlet FBSDKLoginButton *fbloginButton;
@property (weak, nonatomic) IBOutlet UILabel *fbicon;
@property (weak, nonatomic) IBOutlet UILabel *gplusicon;

@property (weak, nonatomic) IBOutlet UIView *RegisterView;
@property (strong, nonatomic) IBOutlet RPFloatingPlaceholderTextField *firstnametxtFld;
@property (strong, nonatomic) IBOutlet RPFloatingPlaceholderTextField *lastnametxtFld;
@property (strong, nonatomic) IBOutlet RPFloatingPlaceholderTextField *mobilenotxtFld;
@property (strong, nonatomic) IBOutlet RPFloatingPlaceholderTextField *emailtxtFld;
@property (strong, nonatomic) IBOutlet RPFloatingPlaceholderTextField *reg_passtxtFld;
@property (strong, nonatomic) IBOutlet RPFloatingPlaceholderTextField *reg_cnf_passtxtFld;
@property (weak, nonatomic) IBOutlet UIButton *Malebtn;
@property (weak, nonatomic) IBOutlet UIButton *femaleBtn;
@property (strong, nonatomic) NSString *genderStr;
- (IBAction)GenderTapped:(UIButton *)sender;


@property (weak, nonatomic) IBOutlet UIButton *reg_submitBtn;
- (IBAction)reg_SubmitTapped:(id)sender;
- (IBAction)ForgotTapped:(id)sender;






@end
