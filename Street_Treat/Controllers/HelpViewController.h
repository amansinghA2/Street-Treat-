//
//  HelpViewController.h
//  Street_Treat
//
//  Created by Kamlesh Dubey on 9/6/16.
//  Copyright © 2016 Digillence Rolson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Common.h"

@interface HelpViewController : UIViewController<UIScrollViewDelegate>{
     BOOL pageControlBeingUsed;
    Common * constant;
    AppDelegate *delegate;
}
@property (weak, nonatomic) IBOutlet UIScrollView *HelpScroll;
@property (weak, nonatomic) IBOutlet UIPageControl *helpPageControl;
@property (nonatomic,strong) NSMutableArray * helpArr;
@property (weak, nonatomic) IBOutlet UIButton *skipBtn;
- (IBAction)skipTapped:(id)sender;

@end
