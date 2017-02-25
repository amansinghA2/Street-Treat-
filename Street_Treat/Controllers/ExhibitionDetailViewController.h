//
//  ExhibitionDetailViewController.h
//  Street_Treat
//
//  Created by Kamlesh Dubey on 8/24/16.
//  Copyright © 2016 Digillence Rolson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Common.h"
#import "AppDelegate.h"

@interface ExhibitionDetailViewController : UIViewController<commonProtocol>{
    BOOL pageControlBeingUsed;
    Common * commonclass;
    AppDelegate * delegate;
    NSMutableData * detailData;
}

@property (weak, nonatomic) IBOutlet UIScrollView *DetailScroll;
@property (weak, nonatomic) IBOutlet UIScrollView *Promoscroll;
@property (weak, nonatomic) IBOutlet UIPageControl *Promopagecontol;
@property (nonatomic,strong) NSMutableArray * promoArr;

@property (weak, nonatomic) IBOutlet UILabel *storeNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *storeAddLbl;
@property (weak, nonatomic) IBOutlet UILabel *storeDateLbl;
@property (weak, nonatomic) IBOutlet UILabel *storeTimeLbl;
@property (weak, nonatomic) IBOutlet UILabel *storeAwayIconLbl;
@property (weak, nonatomic) IBOutlet UILabel *storeAwayLbl;
@property (weak, nonatomic) IBOutlet UILabel *storeAttendingLbl;
@property (weak, nonatomic) IBOutlet UIButton *storecheckInBtn;
@property (weak, nonatomic) IBOutlet UIButton *storePhoneBtn;

@end
