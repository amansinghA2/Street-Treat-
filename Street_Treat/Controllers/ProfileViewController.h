//
//  ProfileViewController.h
//  Street_Treat
//
//  Created by Kamlesh Dubey on 6/21/16.
//  Copyright (c) 2016 Digillence Rolson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChangePasswordViewController.h"
#import "Common.h"
#import "AMTagListView.h"
#import "RPFloatingPlaceholderTextField.h"
#import "AMTagListView.h"
#import "CZPickerView.h"
#import "MyCouponsViewController.h"
#import "HelpViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>


@interface ProfileViewController : UIViewController<UITabBarControllerDelegate,commonProtocol,UITextFieldDelegate,CCKFNavDrawerDelegate,CZPickerViewDelegate,CZPickerViewDataSource,CLLocationManagerDelegate,UIGestureRecognizerDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIAlertViewDelegate >{
    Common * constant;
     AppDelegate * delegate;
     NSMutableData *getProfileData;
//    NSString *post;
//    NSData *postData;
//    NSString *postLength;
//    NSMutableURLRequest *request;
//    NSURLConnection *theConnection;
    NSString *requestType;
    UIView * clrPopupView;
    UIButton * colorsbtn;
    AMTagListView *tagListView;
    AMTagView *view1;
    NSArray * usrProfileArr;
   // UIView * clrView;
   // UIView * apaarelTypeView;
    long int btnwt;
    NSString * setType;
    //NSArray * tempstylerarr;
    NSArray * tempColorsarr;
    NSArray * AllcolorArr;
   // UILabel * clrnamelabel;
    NSArray * AllShirtsArr;
    NSMutableData * profileImageData;
    //NSArray * AllPantsArr;
    //NSArray * AllTShirtArr;
   // NSArray * AllShoesArr;
    
    NSArray * AllstylesArr;
    NSMutableArray * selectedColorsArr,* apparelSizesViews;
    NSMutableArray * selectedStylesArr;
    NSString * tempclrs,* tempStyles;
    NSString * shirtStr;
    NSString * apparelstr;
    
    UIView * locationenablerView;
    CLLocationManager *locationManager;
    CLLocation *currentLocation;
    NSString * locality;
    NSString *name;
    NSString *age;
    NSString *lastname;
    NSString *birthdate;
    UIView *flyoutView;
}


//@property (strong, nonatomic) UIActivityIndicatorView *indicator1;

@property (weak, nonatomic) IBOutlet UIImageView *profile_Pic;
@property (strong, nonatomic) CCKFNavDrawer *rootNav;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;

@property (weak, nonatomic) IBOutlet UILabel *nmeLbl;
@property (weak, nonatomic) IBOutlet UIButton *nmeeditBtn;
- (IBAction)nme_infoEditTapped:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *genderLbl;
@property (weak, nonatomic) IBOutlet UILabel *ageLbl;
@property (weak, nonatomic) IBOutlet UILabel *mobileLbl;
@property (weak, nonatomic) IBOutlet UILabel *emailLbl;
- (IBAction)changePassTapped:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *per_InfoMainView;
@property (weak, nonatomic) IBOutlet UIView *per_infoInnerView;
@property (strong, nonatomic) IBOutlet RPFloatingPlaceholderTextField *nametxtFld;
@property (strong, nonatomic) IBOutlet RPFloatingPlaceholderTextField *mobiletxtFld;
@property (strong, nonatomic) IBOutlet RPFloatingPlaceholderTextField *emailTxtFld;
@property (strong, nonatomic) IBOutlet RPFloatingPlaceholderTextField *agetTxtField;
@property (strong, nonatomic) IBOutlet RPFloatingPlaceholderTextField *birthDateField;
@property (strong, nonatomic) IBOutlet RPFloatingPlaceholderTextField *lastTxtField;
@property (weak, nonatomic) IBOutlet UIButton *per_infoeditBtn;
- (IBAction)per_infoEditTapped:(id)sender;

@property (strong, nonatomic) NSMutableArray *colorArr;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *clrBtnsCollection;
@property (weak, nonatomic) IBOutlet UIView *colorView;
@property (weak, nonatomic) IBOutlet UIButton *col_EditBtn;
@property (weak, nonatomic) IBOutlet UIScrollView *colorPrefScroll;
@property (weak, nonatomic) IBOutlet UIView *clr_PopupView;
- (IBAction)clrSelectDone:(id)sender;
- (IBAction)clr_OkTapped:(id)sender;
- (IBAction)col_EditTapped:(id)sender;

@property (strong, nonatomic) NSMutableArray *style_prefArr;
@property (weak, nonatomic) IBOutlet UIScrollView *stylePrefScroll;
@property (weak, nonatomic) IBOutlet UIView *style_PopupMainview;
@property (weak, nonatomic) IBOutlet UIView *style_PopupInnerView;
@property (weak, nonatomic) IBOutlet UITextField *shirtTxtFld;
@property (weak, nonatomic) IBOutlet UITextField *tShirtTxtFld;
@property (weak, nonatomic) IBOutlet UITextField *pantsTxtFld;
@property (weak, nonatomic) IBOutlet UITextField *shoesTxtFld;

- (IBAction)sizesOKTapped:(id)sender;



@property (weak, nonatomic) IBOutlet UIScrollView *editScroll;




@property (weak, nonatomic) IBOutlet UIView *styleView;
@property (weak, nonatomic) IBOutlet UIButton *style_EditBtn;
- (IBAction)style_EditTapped:(id)sender;

@property (strong, nonatomic) NSMutableArray *apparel_Arr;
@property (strong, nonatomic) NSMutableArray *userapparel_Arr;
@property (weak, nonatomic) IBOutlet UIView *apparelView;
@property (weak, nonatomic) IBOutlet UIButton *apprel_EditBtn;
- (IBAction)apprel_EditTapped:(id)sender;

- (IBAction)MyCouponsTapped:(id)sender;
- (IBAction)favouritesTapped:(id)sender;
- (IBAction)sharedTapped:(id)sender;
- (IBAction)myReviewsTapped:(id)sender;
- (IBAction)shareProfileTapped:(id)sender;
- (IBAction)saveProfileTapped:(id)sender;

@end
