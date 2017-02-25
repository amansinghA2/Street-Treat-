//
//  DashboardViewController.h
//  Street_Treat
//
//  Created by Kamlesh Dubey on 6/6/16.
//  Copyright (c) 2016 Digillence Rolson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Common.h"
#import "NSString+FontAwesome.h"
#import "UIImage+FontAwesome.h"
#import "UPStackMenu.h"
#import "CCKFNavDrawer.h"
#import "AppDelegate.h"
#import "ResultsViewController.h"
#import "ProfileViewController.h"
#import "ContactViewController.h"
#import "ProfileViewController.h"
@import GoogleMaps;
#import "UIImageView+WebCache.h"
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"
#import "VerticalsViewController.h"
#import "NotificationsViewController.h"

#import "ReportErrorViewController.h"
#import "SubmitReviewViewController.h"
#import "ViewReviewsViewController.h"
#import "ExhibitionListingViewController.h"
#import "BestDealsViewController.h"
#import "ChangePasswordViewController.h"
#import "ViewController.h"
#import "HelpViewController.h"
#import "SearchStoreViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import <GooglePlaces/GooglePlaces.h>

@interface DashboardViewController : UIViewController<UIScrollViewDelegate,UPStackMenuDelegate,UITabBarControllerDelegate,CCKFNavDrawerDelegate,GMSAutocompleteViewControllerDelegate,commonProtocol,UIWebViewDelegate,UIScrollViewDelegate,GMSAutocompleteResultsViewControllerDelegate,CLLocationManagerDelegate>{
     Common * constant;
    BOOL pageControlBeingUsed;
     int i;
    UIView * cpnview;
    UIButton * collectionsbtn;
    AppDelegate * delegate;
    NSMutableData *DashboardData,*parentsData,*dealsdata;
    NSString * requestType,*cpnstoreID;
    
     UITextField *txfSearchField;
    long int promocnt;
    UIWebView * promoDtlWebview;
    long int dealno;
    
    CLLocationManager *locationManager;
    CLLocation *currentLocation;
    
    GMSAutocompleteResultsViewController * resultcontroller;
    UISearchController * searchcontroller;
    NSMutableArray *collectionArr,*ExhibitionTitleArr,*dealsArr,*bucketsArr;
    NSMutableArray * allbucketsBtnsArr;
    
    UISearchBar * search;
    
    UIView * flyoutView;
    
    NSString * locality;
    
    UIView * locationenablerView,* networkEnablerView;
    
     NSTimer *timer;
    
    float userLatitude,userLongitude,userRadius,currentLatitude,currentLongitude;
   // UITextField *txfSearchField;
    
//    UIView *contentView;
//    UPStackMenu *stack;
}
@property (strong, nonatomic) IBOutlet UIView *container;
@property (strong, nonatomic) CCKFNavDrawer *rootNav;
@property (nonatomic, strong) NSString * setType;

@property (nonatomic, strong) UIActivityIndicatorView * dasboardIndicator;

@property (weak, nonatomic) IBOutlet UIScrollView *DashboardScroll;
@property (nonatomic,strong) NSMutableArray * dashboardArr;
@property (nonatomic,strong) NSMutableArray * promoArr;
@property (weak, nonatomic) IBOutlet UIScrollView *PromoScroll;
@property (strong, nonatomic) UIView *promoBannerDet_view;
@property (strong, nonatomic) UIButton *promoBannerDetclose;
@property (weak, nonatomic) IBOutlet UILabel *welcomeLbl;

@property (weak, nonatomic) IBOutlet UILabel *usrNameLbl;
@property (weak, nonatomic) IBOutlet UIPageControl *PromoPgCtrl;

@property (weak, nonatomic) IBOutlet UIScrollView *couponScroll;
@property (nonatomic,strong) NSMutableArray * dealArr;
@property (weak, nonatomic) IBOutlet UIView *couponDetMainView;
@property (weak, nonatomic) IBOutlet UIView *couponDtlSubview;
@property (weak, nonatomic) IBOutlet UILabel *couponValLbl;
@property (weak, nonatomic) IBOutlet UIButton *couponCloseBtn;
- (IBAction)couponCloseTapped:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *cpnStoreNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *cpnStoreCatLbl;
@property (weak, nonatomic) IBOutlet UILabel *cpnStoreAddLbl;




@property (weak, nonatomic) IBOutlet UILabel *couponDescLbl;
@property (weak, nonatomic) IBOutlet UIButton *couponSubmitBtn;
- (IBAction)couponSubmitTapped:(UIButton *)sender;
- (IBAction)moreDealsTapped:(id)sender;


@property (weak, nonatomic) IBOutlet UIScrollView *ExhibitionScroll;
@property (nonatomic,strong) NSMutableArray * exhibitionArr;
- (IBAction)moreExhibitionsTapped:(id)sender;


@property (weak, nonatomic) IBOutlet UILabel *collectionLbl;
@property (weak, nonatomic) IBOutlet UIView *tempview;

@property (weak, nonatomic) IBOutlet UIView *categoryView;

@property (weak, nonatomic) IBOutlet UIButton *menBtn;
@property (weak, nonatomic) IBOutlet UIButton *womenBtn;
@property (weak, nonatomic) IBOutlet UIButton *kidsBtn;

@property (weak, nonatomic) IBOutlet UILabel *exhibiNmLbl;
@property (weak, nonatomic) IBOutlet UILabel *exhibiDtlLbl;

@property (weak, nonatomic) IBOutlet UIView *brandView;
- (IBAction)highStrTapped:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *highStrBtn;
@property (weak, nonatomic) IBOutlet UIButton *brandedBtn;
- (IBAction)brandedTapped:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *designerBtn;
- (IBAction)designerTapped:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *checkinBtn;
- (IBAction)checkInTapped:(id)sender;

- (IBAction)moreCollectionsTapped:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *ExhibitionTitleHdr;
@property (weak, nonatomic) IBOutlet UIButton *ExhibitionMoreBtn;
@property (weak, nonatomic) IBOutlet UIView *ExhibitionDtlsView;
@property (weak, nonatomic) IBOutlet UIView *CheckinDtlsView;
@property (weak, nonatomic) IBOutlet UILabel *CollectionsLblHdr;
@property (weak, nonatomic) IBOutlet UIButton *collectionMoreBtn;

@property (weak, nonatomic) IBOutlet UILabel *bestDlsLbl;
@property (weak, nonatomic) IBOutlet UIButton *moreDealsBtn;




- (IBAction)menTapped:(id)sender;
- (IBAction)womenTapped:(id)sender;
- (IBAction)kidsTapped:(id)sender;




//- (IBAction)hmegrwnTapped:(id)sender;
//- (IBAction)brandedTapped:(id)sender;
//- (IBAction)designerTapped:(id)sender;

-(void)MenuToggle;

@end
