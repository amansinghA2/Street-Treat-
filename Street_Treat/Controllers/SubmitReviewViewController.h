//
//  SubmitReviewViewController.h
//  Street_Treat
//
//  Created by Kamlesh Dubey on 8/5/16.
//  Copyright © 2016 Digillence Rolson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Common.h"
#import "UIView+Toast.h"

@interface SubmitReviewViewController : UIViewController<commonProtocol,UITextViewDelegate,UIGestureRecognizerDelegate>{
    Common * commonclass;
    AppDelegate * delegate;
    NSMutableData * addReviewforStoreData;
    long int ratings;
}
@property (weak, nonatomic) IBOutlet UILabel *storeNameLbl;

@property (weak, nonatomic) IBOutlet UIScrollView *feedbackScroll;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *feedbackBtns;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *FedbacklblsArr;

//@property (weak, nonatomic) IBOutlet UILabel *FedbacklblsArr;


@property (strong, nonatomic) NSArray *feedbacktypesArr;

@property (strong, nonatomic) NSString *reviewString;
@property (strong, nonatomic) NSString *feedbackString;

- (IBAction)feedbackTapped:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UITextView *feedbackTxtView;

@property (weak, nonatomic) IBOutlet UILabel *mstVisitStarsLbl;
@property (weak, nonatomic) IBOutlet UILabel *rcmdStarsLbl;
@property (weak, nonatomic) IBOutlet UILabel *worthExploringStarsLbl;
@property (weak, nonatomic) IBOutlet UILabel *needsImprovementStarsLbl;
@property (weak, nonatomic) IBOutlet UILabel *notRecommendedStarsLbl;









- (IBAction)submitTapped:(id)sender;

@end
