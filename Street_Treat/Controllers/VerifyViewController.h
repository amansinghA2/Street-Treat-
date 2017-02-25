//
//  VerifyViewController.h
//  Street_Treat
//
//  Created by Kamlesh Dubey on 6/28/16.
//  Copyright © 2016 Digillence Rolson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Common.h"
#import "AppDelegate.h"
#import "DashboardViewController.h"

@interface VerifyViewController : UIViewController<UITextFieldDelegate,commonProtocol>{
    Common * constant;
    AppDelegate * delegate;
    NSTimer * timer;
    int secLeft,minutes,seconds;
    NSMutableData * otpdata,*LoginData;
    NSString * responseType;
    UIButton *backBtn;
}

@property (strong, nonatomic) IBOutlet RPFloatingPlaceholderTextField *otptxtFld;
@property (strong, nonatomic) IBOutlet UILabel *timetext;
@property (weak, nonatomic) IBOutlet UILabel *otptext;
@property (strong, nonatomic) IBOutlet NSString *getRegFlds;
@property (weak, nonatomic) IBOutlet UIButton *verifyBtn;
- (IBAction)VerifyTapped:(id)sender;
@property (strong, nonatomic) IBOutlet NSString *GetLoginBody;

@property (weak, nonatomic) IBOutlet UIButton *resendBtn;

- (IBAction)resendTapped:(id)sender;

@end
