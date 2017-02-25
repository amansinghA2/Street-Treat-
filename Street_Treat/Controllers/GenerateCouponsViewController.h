//
//  GenerateCouponsViewController.h
//  Street_Treat
//
//  Created by Kamlesh Dubey on 9/6/16.
//  Copyright © 2016 Digillence Rolson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Common.h"
//#import "BestDealsCell.h"
#import "ViewReviewsViewController.h"
#import "ReportErrorViewController.h"
#import "CZPickerView.h"
#import "SubmitReviewViewController.h"
#import "UPStackMenu.h"

@interface GenerateCouponsViewController : UIViewController<commonProtocol,UIScrollViewDelegate,CZPickerViewDataSource, CZPickerViewDelegate,UITextFieldDelegate,UPStackMenuDelegate>{
    Common * commonclass;
    AppDelegate * delegate;
    BOOL pageControlBeingUsed;
    BOOL isDataLoadingCompleted;
    BOOL isFavTapped;
    NSMutableData *  checkinsData,* generateData,* detailsData;
    NSArray * offersArr;
    NSString * responseType;
    long int store_ID;
    NSMutableArray * selectedOffersArr,*detailsArr;
    UIView * Popupmainview,*OTPView,* verifyView;
    double  userLatitude,userLongitude,currentLatitude,currentLongitude;
    UIButton * backBtn;
    UIView * flyoutView;
    UIButton * DtlcheckInBtn;
    

}
@property (weak, nonatomic) IBOutlet UIButton *cameraBtn;
- (IBAction)cameraTapped:(id)sender;

@property (weak, nonatomic) IBOutlet UIScrollView *DetailScroll;
@property (weak, nonatomic) IBOutlet UIScrollView *Promoscroll;
@property (weak, nonatomic) IBOutlet UIPageControl *Promopagecontol;

@property (strong, nonatomic) IBOutlet UITextField *mobileFld;
@property (strong, nonatomic) IBOutlet UITextField *otpFld;

@property (nonatomic,strong) NSArray * DetailsArr;

@property (nonatomic,strong) NSArray * PromoArr;

@property (weak, nonatomic) IBOutlet UILabel *storeName;
@property (weak, nonatomic) IBOutlet UILabel *storeAddress;
@property (weak, nonatomic) IBOutlet UILabel *storeShopForLbl;
@property (weak, nonatomic) IBOutlet UILabel *storeTimeLbl;
- (IBAction)ReportTapped:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *storeAwayIconLbl;
@property (weak, nonatomic) IBOutlet UILabel *storeAwayLbl;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
- (IBAction)shareTapped:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *addTofavouritesBtn;
- (IBAction)favouritesTapped:(id)sender;
- (IBAction)viewReviewsTapped:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *votesCount;
@property (weak, nonatomic) IBOutlet UILabel *storeStarsLbl;
@property (weak, nonatomic) IBOutlet UILabel *storeRatingLbl;
@property (weak, nonatomic) IBOutlet UILabel *storeChecksCount;
@property (weak, nonatomic) IBOutlet UILabel *storeValidCouponsCount;
@property (weak, nonatomic) IBOutlet UILabel *streetOffersLbl;
- (IBAction)MoreOffersTapped:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *reviewView;
- (IBAction)reviewTapped:(id)sender;

@end
