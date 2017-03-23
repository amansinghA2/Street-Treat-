//
//  ReportErrorViewController.h
//  Street_Treat
//
//  Created by Kamlesh Dubey on 8/5/16.
//  Copyright © 2016 Digillence Rolson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Common.h"
#import "UIView+Toast.h"
#import "NotificationsViewController.h"

@interface ReportErrorViewController : UIViewController<commonProtocol,UITextViewDelegate,UIGestureRecognizerDelegate>{
    Common * constant;
    AppDelegate * delegate;
    NSMutableData * reportData;
    NSMutableArray * selectedErrors;
    UIView *flyoutView;

}

@property (weak, nonatomic) IBOutlet UIScrollView *reportScroll;
@property (weak, nonatomic) IBOutlet UILabel *storeNameLbl;


@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *ErrTypesLbls;


@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *CheckboxBtns;
@property (strong, nonatomic) NSArray *errortypesArr;
- (IBAction)checkboxTapped:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *reportTxtView;
@property (strong, nonatomic) NSString *reportString;
@property (weak, nonatomic) IBOutlet UIButton *otherBtn;



@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
- (IBAction)submitTapped:(UIButton *)sender;
- (IBAction)otherTapped:(id)sender;

@end
