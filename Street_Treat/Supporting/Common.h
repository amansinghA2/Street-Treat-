//
//  Common.h
//  Street_Treat
//
//  Created by Kamlesh Dubey on 5/12/16.
//  Copyright (c) 2016 Digillence Rolson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "NSString+FontAwesome.h"
#import "UIImage+FontAwesome.h"
#import "CCKFNavDrawer.h"
#import "RPFloatingPlaceholderTextField.h"
#import "UIView+Toast.h"
#import "FLAnimatedImage.h"
#import "FLAnimatedImageView.h"
#import "UIImageView+WebCache.h"
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"
#import <QuartzCore/QuartzCore.h>
#import "Reachability.h"
//#import "ViewController.h"

@class Common;
@protocol commonProtocol <NSObject>

@optional
- (void)sendResponse:(Common *)response data:(NSMutableArray*)data indicator:(UIActivityIndicatorView *)indicator;
- (void)autocomplete:(Common *)response;


@end

@interface Common : UIViewController<UISearchBarDelegate,CCKFNavDrawerDelegate,UISearchBarDelegate>{
    UITextField *txfSearchField;
    int ht;
    UIActivityIndicatorView * indicator;
     AppDelegate * maindelegate;
    UIView * loaderView;
}

#define TextColor_TxtFld colorWithRed:(217/255.0) green:(6/255.0) blue:(43/255.0) alpha:1.0
#define Location_ServiceClr colorWithRed:(222/255.0) green:(222/255.0) blue:(222/255.0) alpha:1.0
#define Tabbar_Color colorWithRed:(0/255.0) green:(82/255.0) blue:(157/255.0) alpha:1.0
#define Hdr_Color colorWithRed:(229/255.0) green:(229/255.0) blue:(229/255.0) alpha:1.0
#define MapRadiusColor colorWithRed:(217/255.0) green:(6/255.0) blue:(43/255.0) alpha:0.5
#define coupon_back colorWithRed:(247/255.0) green:(247/255.0) blue:(247/255.0) alpha:1.0
#define TextColor_Placeholder colorWithRed:(253/255.0) green:(58/255.0) blue:(107/255.0) alpha:1.0
#define View_Border colorWithRed:(224/255.0) green:(225/255.0) blue:(224/255.0) alpha:1.0
#define Popup_color colorWithRed:(0/255.0) green:(0/255.0) blue:(0/255.0) alpha:0.3
#define FBColor colorWithRed:(20/255.0) green:(48/255.0) blue:(105/255.0) alpha:1.0
#define PopupBackground colorWithRed:(0/255.0) green:(0/255.0) blue:(0/255.0) alpha:0.8
//#define AmenitiesColors colorWithRed:(0/255.0) green:(0/255.0) blue:(0/255.0) alpha:0.8


//#define LoginURL http://www.streettreat.digiroltest.com/index.php?option=com_konnect&task=loginUser
-(void)PresentViewController:(UIViewController *)controller Identifier:(NSString *)Identifier;
-(void)addNavigationBar:(UIView *)MainView;
-(void)addTabImages:(UITabBar *)Maintab;
-(void)addLayer:(UIView *)MainView button1:(UIButton *)btn1 button2:(UIButton *)btn2 button3:(UIButton *)btn3 btn1title:(NSString *)btn1title btn2title:(NSString *)btn2title btn3title:(NSString *)btn3title;
-(void)addfeild:(UIView *)MainView textfeild:(RPFloatingPlaceholderTextField *)fld;
-(void)roundedImage:(UIImageView *)img;
-(void)genderBtn:(UIButton *)btn corners:(UIRectCorner)corners;
-(void)addSlideAnimation:(UILabel *)line firstView:(UIView *)firstView secondView:(UIView *)secondView button1:(UIButton *)btn1 button2:(UIButton *)btn2 newX:(float)newX newY:(float)newY;
- (UIColor *)getUIColorObjectFromHexString:(NSString *)hexStr alpha:(CGFloat)alpha;
-(void)resizeToFitSubviews:(UIView *)mainView;
-(void)changeFrameWRT:(UIView *)mainView ofview:(UIView*)toview;

-(void)addlistingSlideAnimation:(UILabel *)line button1:(UIButton *)btn1;
-(NSArray *)setDate:(NSString *)firstdate seconddate:(NSString *)seconddate;
-(NSArray *)setTime:(NSString *)firsttime secondtime:(NSString *)secondtime;
-(void)logoutFunction;
-(void)sendRequest:(UIView *)MainView mutableDta:(NSMutableData *)mutableDta url:(NSString *)url msgBody:(NSString *)msgBody;
-(void)DataResponse:(NSData *)data;

-(void)AddLoader:(UIView *)Mainview;
-(void)RemoveLoader:(UIView *)Mainview;
-(void)Redirect:(UINavigationController *)Navigation Identifier:(NSString *)Identifier;
-(int)calculateBirthdate:(NSString *)fromdate;
-(NSString *)calculateTimeinAMPM:(NSString *)fromString;
-(BOOL)isActiveInternet;

-(void)changeFrameforDashboardWRT:(UIView *)mainView ofview:(UIView*)toview;

@property (nonatomic, assign) id<commonProtocol> delegate;


@property (strong, nonatomic) CCKFNavDrawer *rootNav;

@property (strong, nonatomic) NSString *cpnfnt;
@property (strong, nonatomic) NSString *usryPos;
@property (strong, nonatomic) NSString *passyPos;
@property (strong, nonatomic) NSString *forgotPassPos;
@property (strong, nonatomic) NSString *cpnDtlfnt;
@property (strong, nonatomic) NSString *storetitlefnt;
@property (strong, nonatomic) NSString *regSubmitPos;
@property (strong, nonatomic) NSString *passSubmitPos;
@property (strong, nonatomic) NSString *passEnablePos;

//navigation bar Icons
@property (strong, nonatomic) NSString *backIcon;
@property (strong, nonatomic) NSString *notificationIcon;
@property (strong, nonatomic) NSString *menuIcon;
//end

//tabbar Icons
@property (strong, nonatomic) NSString *homeIcon;
@property (strong, nonatomic) NSString *collectionIcon;
@property (strong, nonatomic) NSString *nearmeIcon;
//end


//Login Page Icons
@property (strong, nonatomic) NSString *Fbicon;
@property (strong, nonatomic) NSString *gPlusicon;
//end

//Forgot password Page Icons
@property (strong, nonatomic) NSString *forgotIcon;
//end

//Dashboard Page Icons
@property (strong, nonatomic) NSString *indicatorBlankIcon;
@property (strong, nonatomic) NSString *indicatorFilledIcon;
@property (strong, nonatomic) NSString *menIcon;
@property (strong, nonatomic) NSString *womenIcon;
@property (strong, nonatomic) NSString *childrenIcon;
@property (strong, nonatomic) NSString *highStreetIcon;
@property (strong, nonatomic) NSString *brandedIcon;
@property (strong, nonatomic) NSString *designerIcon;
//end

//Search Result page icon
@property (strong, nonatomic) NSString *locationbaloonIcon;
@property (strong, nonatomic) NSString *filtersIcon;
@property (strong, nonatomic) NSString *starIcon;
@property (strong, nonatomic) NSString *emptystarIcon;
@property (strong, nonatomic) NSString *storeawayIcon;
@property (strong, nonatomic) NSString *storephoneIcon;
//end

//Contact Us Page Icons
@property (strong, nonatomic) NSString *telIcon;
@property (strong, nonatomic) NSString *faxIcon;
@property (strong, nonatomic) NSString *mailIcon;
//end


//Rate & review Page Icons
@property (strong, nonatomic) NSString *radiofilledIcon;
@property (strong, nonatomic) NSString *radioemptyIcon;
@property (strong, nonatomic) NSString *twostarIcon;
@property (strong, nonatomic) NSString *threestarIcon;
@property (strong, nonatomic) NSString *fourstarIcon;
@property (strong, nonatomic) NSString *fivestarIcon;
//end

//Report Error Page Icons
@property (strong, nonatomic) NSString *checkboxfilledIcon;
@property (strong, nonatomic) NSString *checkboxemptyIcon;
//end

//View Feedback Page Icons
@property (strong, nonatomic) NSString *allreviewsIcon;
@property (strong, nonatomic) NSString *positivereviewsIcon;
@property (strong, nonatomic) NSString *negativereviewsIcon;
//end

//Detail Page Icon
@property (strong, nonatomic) NSString *shareIcon;
@property (strong, nonatomic) NSString *addtofavouritesIcon;
@property (strong, nonatomic) NSString *addedtofavouritesIcon;

@property (strong, nonatomic) NSString *amenitiesACIcon;
@property (strong, nonatomic) NSString *amenitiesLiftIcon;
@property (strong, nonatomic) NSString *amenitiesCarParkingIcon;
@property (strong, nonatomic) NSString *amenitiesCreditCardIcon;

//End

//Edit Profile Icons
@property (strong, nonatomic) NSString *editIcon;
@property (strong, nonatomic) NSString *coloreditIcon;
//end

//Generate Coupons Icon
@property (strong, nonatomic) NSString *cameraIcon;
//end


@property (strong, nonatomic) NSString *siteURL;
@property (strong, nonatomic) NSString *getMastersURL;
@property (strong, nonatomic) NSString *LoginURL;//
@property (strong, nonatomic) NSString *RegisterURL;
@property (strong, nonatomic) NSString *uniqueFldURL;
@property (strong, nonatomic) NSString *forgotpasswordURL;
@property (strong, nonatomic) NSString *verifyOTPURL;
@property (strong, nonatomic) NSString *changePasswordURL;
@property (strong, nonatomic) NSString *changePassfromProfileURL;
@property (strong, nonatomic) NSString *FAQsURL;
@property (strong, nonatomic) NSString *privacypolicyURL;
@property (strong, nonatomic) NSString *CheckinsURL;
@property (strong, nonatomic) NSString *getOffersURL;
@property (strong, nonatomic) NSString *generateCouponsURL;
@property (strong, nonatomic) NSString *AddfavouritesURL;
@property (strong, nonatomic) NSString *shareStoreURL;
@property (strong, nonatomic) NSString *callStoreURL;
@property (strong, nonatomic) NSString *addReviewsforStoreURL;
@property (strong, nonatomic) NSString *updateDeviceToken;
@property (strong, nonatomic) NSString *updateMobileURL;

@property (strong, nonatomic) NSString *myCouponsURL;

@property (strong, nonatomic) NSString *bucketsListURL;
@property (strong, nonatomic) NSString *bucketsDeatilURL;

@property (strong, nonatomic) NSString *otpURL;
@property (strong, nonatomic) NSString *getParentCategoriesURL;
@property (strong, nonatomic) NSString *generatenewotpURL;
@property (strong, nonatomic) NSString *staticDataURL;
@property (strong, nonatomic) NSString *contactURL;
@property (strong, nonatomic) NSString *getProfileURL;
@property (strong, nonatomic) NSString *setProfileURL;
@property (strong, nonatomic) NSString *dashboardURL;
@property (strong, nonatomic) NSString *storeDetailURL;
@property (strong, nonatomic) NSString *getstoreDetailsURL;
@property (strong, nonatomic) NSString *verticalsURL;
@property (strong, nonatomic) NSString *exhibition_listURL;
@property (strong, nonatomic) NSString *exhibition_detailURL;
@property (strong, nonatomic) NSString *searchListURL;
@property (strong, nonatomic) NSString *userProfImageURL;
@property (strong, nonatomic) NSString *feedbackURL;
@property (strong, nonatomic) NSString *reportErrorURL;
@property (strong, nonatomic) NSString *viewFeedbacksURL;
@property (strong, nonatomic) NSString *generateOTPURL;


@property (strong, nonatomic) NSString *newsEventsURL;
@property (strong, nonatomic) NSString *termsconditionsURL;

@property (strong, nonatomic) NSString *loginFBURL;


@end
