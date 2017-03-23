//
//  DetailViewController.h
//  Street_Treat
//
//  Created by Kamlesh Dubey on 6/17/16.
//  Copyright (c) 2016 Digillence Rolson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Common.h"
#import "AppDelegate.h"
#import "ReportErrorViewController.h"
#import "ViewReviewsViewController.h"
#import "SubmitReviewViewController.h"
#import "GenerateCouponsViewController.h"
#import "ProfileViewController.h"
#import "ImageViewController.h"

#import "UPStackMenu.h"

@interface StoreDealsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *shortDealTitleLbl;
@property (weak, nonatomic) IBOutlet UILabel *longDealTitleLbl;
@property (weak, nonatomic) IBOutlet UIButton *ExpandBtn;


@end

@interface DetailViewController : UIViewController<UIScrollViewDelegate,UITabBarControllerDelegate,UITabBarDelegate,commonProtocol,CCKFNavDrawerDelegate,UPStackMenuDelegate,CLLocationManagerDelegate , UIGestureRecognizerDelegate>{
    BOOL pageControlBeingUsed;
    Common * commonclass;
    AppDelegate * delegate;
    NSMutableData * detailData,* dealsData,* amenitiesData,* miscdata;
    NSMutableArray * deatilsArr;
    long int store_ID;
    NSString * responseType;
    NSMutableArray * dealsArr,*amenitiesArr;
    NSString * time;
    BOOL isexpand, isselecttapped;
    NSIndexPath * path;
    long selectedIndex;
    NSMutableArray *indexpathArr;
    StoreDealsCell * cell;
    NSString * setType;
    NSString * awayDist;
    NSMutableData *  checkinsData;
    long int amenitiesCnt;
    UIView * flyoutView;
    UIButton * backBtn;
    double  userLatitude,userLongitude,currentLatitude,currentLongitude;
    NSString *imgLink1;
    UIView * Popupmainview,*verifyView, * OTPView;
    UITextField *mobileFld,* otpFld;
    NSMutableArray *imagesList;
    UIView * locationenablerView;
    CLLocationManager *locationManager;
    CLLocation *currentLocation;
    NSString * locality;
    long int imgcnt;
    UIView *demoView;
    NSMutableArray *dataDetails;
    
    UIButton * DtlcheckInBtn;
    NSMutableArray *arrForImage;
    //UIButton * checkinBtn;
}

@property (strong, nonatomic) CCKFNavDrawer *rootNav;

@property (weak, nonatomic) IBOutlet UIScrollView *DetailScroll;
@property (nonatomic,strong) NSArray * DetailsArr;
@property (weak, nonatomic) IBOutlet UIScrollView *Promoscroll;
@property (weak, nonatomic) IBOutlet UIPageControl *Promopagecontol;
@property (nonatomic,strong) NSMutableArray * promoArr;

@property (weak, nonatomic) IBOutlet UILabel *storeName;
@property (weak, nonatomic) IBOutlet UILabel *storeAddress;
@property (weak, nonatomic) IBOutlet UILabel *storeShopForLbl;
@property (weak, nonatomic) IBOutlet UILabel *storeTimeLbl;
- (IBAction)ReportTapped:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *storeAwayIconLbl;
@property (weak, nonatomic) IBOutlet UILabel *storeAwayLbl;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UIButton *addTofavouritesBtn;
- (IBAction)shareTapped:(id)sender;
- (IBAction)favouritesTapped:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *checkInBtn;

@property (weak, nonatomic) IBOutlet UILabel *votesCount;
- (IBAction)viewReviewsTapped:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *storeStarsLbl;

@property (weak, nonatomic) IBOutlet UILabel *storeRatingLbl;

@property (weak, nonatomic) IBOutlet UILabel *storeChecksCount;
@property (weak, nonatomic) IBOutlet UILabel *storeValidCouponsCount;
@property (weak, nonatomic) IBOutlet UITableView *storeOffersTbl;
@property (weak, nonatomic) IBOutlet UILabel *storeStreetOffersLbl;

@property (weak, nonatomic) IBOutlet UISlider *budgetSlider;
@property (weak, nonatomic) IBOutlet UIScrollView *amenitiesScroll;
@property (weak, nonatomic) IBOutlet UILabel *storeDescLbl;

@property (weak, nonatomic) IBOutlet UIView *reviewView;

- (IBAction)AddReviewTapped:(id)sender;
- (IBAction)checkInTapped:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *offersLine1Lbl;
@property (weak, nonatomic) IBOutlet UILabel *offersAddLbl;
@property (weak, nonatomic) IBOutlet UILabel *offersLine2Lbl;
@property (weak, nonatomic) IBOutlet UIView *budgetMetersView;
@property (weak, nonatomic) IBOutlet UIView *AmenitiesView;
@property (weak, nonatomic) IBOutlet UIView *DescriptionView;
@property (weak, nonatomic) IBOutlet UIView *StoreOffersView;
@property (weak, nonatomic) IBOutlet UIView *TimingsView;
@property (weak, nonatomic) IBOutlet UILabel *MondayTimeLbl;
@property (weak, nonatomic) IBOutlet UILabel *TuesdayTimeLbl;
@property (weak, nonatomic) IBOutlet UILabel *WednesdayTimeLbl;
@property (weak, nonatomic) IBOutlet UILabel *ThursdayTimeLbl;
@property (weak, nonatomic) IBOutlet UILabel *FridayTimeLbl;
@property (weak, nonatomic) IBOutlet UILabel *saturdayTimeLbl;
@property (weak, nonatomic) IBOutlet UILabel *sundayTimeLbl;

@end
