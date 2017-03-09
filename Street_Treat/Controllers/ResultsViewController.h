//
//  ResultsViewController.h
//  Street_Treat
//
//  Created by Kamlesh Dubey on 6/10/16.
//  Copyright (c) 2016 Digillence Rolson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailViewController.h"
#import "DashboardViewController.h"
#import "Common.h"
#import "AppDelegate.h"
#import "NormalListCell.h"
#import "ExhibitionNormalCell.h"
#import "PremiumListingCell.h"
#import "ExhibitionDetailViewController.h"
#import "UIImageView+WebCache.h"
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"
#import "StaticDataViewController.h"
#import "GenerateCouponsViewController.h"
@import GoogleMaps;
#import <GooglePlaces/GooglePlaces.h>
#import "ImageViewController.h"

#import "UPStackMenu.h"

@interface ResultsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITabBarControllerDelegate,commonProtocol,CCKFNavDrawerDelegate,GMSAutocompleteViewControllerDelegate,UPStackMenuDelegate,UITextFieldDelegate,CZPickerViewDelegate,CZPickerViewDataSource,CLLocationManagerDelegate , UIScrollViewDelegate , UIGestureRecognizerDelegate>{
    Common * commonclass;
    AppDelegate * delegate;
    NSMutableData *searchData,* extraData,* categoriesData;
    NSMutableArray * searchResponseArr,* highstreetArr,*brandedArr,* designerArr,* exhibitionArr,* verticalsArr,* favouritesArr,*categoriesArr,*selectedcategoriesIDArr,*selectedcategoriesArr,* premiumListArr;
    NSString * seg_string;
    NSString * checkin;
    float PrevX,nextX,PrevY;
    NormalListCell *cell;
    ExhibitionNormalCell * cell1;
    PremiumListingCell * premiumcell;
    long int imgcnt;
    UIImageView * storeimgview;
    NSMutableArray * phonenoArr;
    NSMutableArray * phoneno_StoreIDArr;
    NSMutableArray * distAwayArr;
    NSMutableArray * arrForImage;
    NSIndexPath * arrayIndexPath;
    NSMutableArray * premiumdistAwayArr;
    NSMutableArray * premiumphoneno_StoreIDArr;
    NSMutableArray * premiumphonenoArr;
    NSMutableArray * timeArray;
    NSMutableArray * promoArr;
    UISearchBar * search;
    NSString * awayDist;
    NSString * imglink1;
    NSString * premiumAwayDist;
    NSString * singleTime;
    NSString * tabType;
    UIView * flyoutView;
    int temppremiumCnt;
    NSMutableData *  checkinsData;
    NSTimer *timer;
    UIView *viewforImage;

   // int j;
    BOOL isUpdate;
    UILabel * premiumStoreNamelabel;
    NSString * time;

    NSString * locality;
    
    NSString *post;
    NSData *postData;
    NSString *postLength;
    NSMutableURLRequest *request;
    NSURLConnection *theConnection;
    UITextField *searchField;
    
    CLLocationManager *locationManager;
    CLLocation *currentLocation;
    
    float userLatitude,userLongitude,userRadius,currentLatitude,currentLongitude;
    
    UIView * Popupmainview,*verifyView, * OTPView;
    UITextField *mobileFld,* otpFld;
    
    float ratingsVal, distanceval, discountval;
    
    long int store_ID,premiumCnt;
    UIRefreshControl *refreshControl;
    NSString * verticalset;
    NSString * segTapString;
    NSString *typeCell;
    UIImageView * premiumImage;
    long int counter;
}
@property (weak, nonatomic) IBOutlet UITableView *resultTable;
@property (weak, nonatomic) IBOutlet UIView *resultView;
@property (weak, nonatomic) IBOutlet UIView *filterPopup;
@property (strong, nonatomic) CCKFNavDrawer *rootNav;
@property (nonatomic, strong) NSString * setType;
@property (weak, nonatomic) IBOutlet UIView *imageShowView;

@property (weak, nonatomic) IBOutlet UIView *couponDetMainView;
- (IBAction)couponCloseTapped:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *storeCountLbl;
@property (weak, nonatomic) IBOutlet UIButton *locationBtn;
- (IBAction)locationBtnTapped:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *filterBtn;
- (IBAction)filterBtnTapped:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *indicatorLine;

@property (weak, nonatomic) IBOutlet UIButton *highstreetBtn;
- (IBAction)highstreetTapped:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *brandsBtn;
- (IBAction)brandsTapped:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *designersBtn;
- (IBAction)designersTapped:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *exhibitionsBtn;
- (IBAction)exhibitionsTapped:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *VerticalsHdrLbl;

@property (weak, nonatomic) IBOutlet UISlider *RatingsSlider;
@property (weak, nonatomic) IBOutlet UILabel *ratingsMaxLbl;
- (IBAction)RatingsChanged:(id)sender;

@property (weak, nonatomic) IBOutlet UISlider *DistanceSlider;
@property (weak, nonatomic) IBOutlet UILabel *distanceMaxLbl;
- (IBAction)DistanceChanged:(id)sender;

@property (weak, nonatomic) IBOutlet UISlider *DiscountSlider;
@property (weak, nonatomic) IBOutlet UILabel *discountMaxLbl;
- (IBAction)DiscountChanged:(id)sender;
- (IBAction)filterSubmitTapped:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *CategoriesSelectLbl;
@property (weak, nonatomic) IBOutlet UILabel *SelectedCategoriesLbl;



@end
