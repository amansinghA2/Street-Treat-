//
//  ExhibitionListingViewController.h
//  Street_Treat
//
//  Created by Kamlesh Dubey on 8/19/16.
//  Copyright © 2016 Digillence Rolson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Common.h"
#import "AppDelegate.h"
#import "ExhibitionNormalCell.h"
#import "ExhibitionDetailViewController.h"
#import "UIImageView+WebCache.h"
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"

@interface ExhibitionListingViewController : UIViewController<commonProtocol>{
    Common * commonclass;
    AppDelegate * delegate;
    NSMutableData * exhibitionData;
    NSMutableArray * exhibitionsArr;
    ExhibitionNormalCell *cell;
    long int imgcnt;
    UIImageView * storeimgview;
    NSMutableArray * phonenoArr;
}

@property (weak, nonatomic) IBOutlet UITableView *resultTable;
@property (weak, nonatomic) IBOutlet UILabel *storeCountLbl;
@property (weak, nonatomic) IBOutlet UIButton *locationBtn;
- (IBAction)locationBtnTapped:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *filterBtn;
- (IBAction)filterBtnTapped:(id)sender;

@end
