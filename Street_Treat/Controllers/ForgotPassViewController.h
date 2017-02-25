//
//  ForgotPassViewController.h
//  Street_Treat
//
//  Created by Kamlesh Dubey on 6/15/16.
//  Copyright (c) 2016 Digillence Rolson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Common.h"
#import "RPFloatingPlaceholderTextField.h"
#import "UIView+Toast.h"
#import "AppDelegate.h"
#import "ChangePasswordViewController.h"

@interface ForgotPassViewController : UIViewController<UITextFieldDelegate,commonProtocol>{
    Common * constant;
    AppDelegate * delegate;
    NSMutableData *forgotData;
    NSString * otpStr;
    
    NSString * fldType,*fldValue;
    UIView * OTPMainview;
    UILabel *timetext;
    NSTimer * timer;
    int secLeft,minutes,seconds;
    NSMutableData * otpdata;
    NSString * responseType;
    UIView * tempview;
    
}

@property (weak, nonatomic) IBOutlet UILabel *LockLbl;
@property (strong, nonatomic) IBOutlet UIScrollView * ForgotScroll;
@property (strong, nonatomic) NSString * setMobile;
@property (strong, nonatomic) IBOutlet RPFloatingPlaceholderTextField *Email;
@property (strong, nonatomic) IBOutlet RPFloatingPlaceholderTextField *Mobile;
@property (strong, nonatomic) IBOutlet RPFloatingPlaceholderTextField *otptxtFld;
@property (weak, nonatomic) IBOutlet UILabel *orLbl;

@property (weak, nonatomic) IBOutlet UIButton *getBtn;
//- (IBAction)getTapped:(id)sender;
//@property (strong, nonatomic) UIActivityIndicatorView *indicator;

@end
