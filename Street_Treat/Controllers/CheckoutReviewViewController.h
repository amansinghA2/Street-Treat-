//
//  CheckoutReviewViewController.h
//  Street_Treat
//
//  Created by Kamlesh Dubey on 10/12/16.
//  Copyright © 2016 Digillence Rolson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Common.h"
#import "DashboardViewController.h"
#import "ViewController.h"

@interface CheckoutReviewViewController : UIViewController<commonProtocol , UITextViewDelegate>{
    Common * commonclass;
    NSMutableData *parentsData;
    AppDelegate * delegate;
    NSString *typeReview;
    NSString *categorySelString;
    NSString *salesmanSelectString;
    NSString *AppealSelectString;
    NSString *trailRoomSelectString;
    float ratingsVal;
}
@property (weak, nonatomic) IBOutlet UILabel *storeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingsMaxLbl;
@property (weak, nonatomic) IBOutlet UISlider *sliderOutlet;
@property (weak, nonatomic) IBOutlet UITextField *pricetTextfield;

@property (weak, nonatomic) IBOutlet UISegmentedControl *CategorySelect;
- (IBAction)categoryChanged:(id)sender;

@property (weak, nonatomic) IBOutlet UISegmentedControl *priceSelect;
- (IBAction)priceChanged:(id)sender;

@property (weak, nonatomic) IBOutlet UISegmentedControl *salesmanSelect;
- (IBAction)salesmanChanged:(id)sender;

@property (weak, nonatomic) IBOutlet UISegmentedControl *AppealSelect;
- (IBAction)AppealChanged:(id)sender;

@property (weak, nonatomic) IBOutlet UISegmentedControl *trailRoomSelect;
- (IBAction)trailRoomChanged:(id)sender;

@property (weak, nonatomic) IBOutlet UITextView *feedBackTextView;
@property (weak, nonatomic) IBOutlet UILabel *overallShoppingLbl;
- (IBAction)submitTapped:(id)sender;
- (IBAction)closeTapped:(id)sender;
- (IBAction)ratingsAction:(id)sender;


@end
