//
//  ChangePasswordViewController.h
//  VendorApp
//
//  Created by Kamlesh Dubey on 12/6/16.
//  Copyright © 2016 Digillence Rolson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Common.h"
#import "UIView+Toast.h"
#import "LoginViewController.h"

@interface ChangePasswordViewController : UIViewController<commonProtocol,UITextFieldDelegate>{
    Common * commonclass;
    AppDelegate * delegate;
    NSMutableData * changedata;
    UIButton *backBtn;
}

@property (strong, nonatomic) IBOutlet RPFloatingPlaceholderTextField *OldPasswordFld;
@property (strong, nonatomic) IBOutlet RPFloatingPlaceholderTextField *NewPasswordFld;
@property (strong, nonatomic) IBOutlet UIScrollView * ChangeScroll;
@property (strong, nonatomic) NSString * getMobile;

@end
