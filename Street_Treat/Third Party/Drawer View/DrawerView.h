//
//  Drawer.h
//  CCKFNavDrawer
//
//  Created by calvin on 2/2/14.
//  Copyright (c) 2014年 com.calvin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface DrawerView : UIView{
    AppDelegate * delegate;
}

@property (strong, nonatomic) IBOutlet UITableView *drawerTableView;

@property (strong, nonatomic) IBOutlet UILabel *TermsLbl;
@property (strong, nonatomic) IBOutlet UILabel *LoyaltyLvlLbl;
@property (strong, nonatomic) IBOutlet UILabel *StatusLbl;

@property (weak, nonatomic) IBOutlet UIImageView *coverPic;
@property (weak, nonatomic) IBOutlet UIImageView *profilePic;
@property (strong, nonatomic) IBOutlet UILabel *NameLbl;
@property (weak, nonatomic) IBOutlet UILabel *phoneNoLbl;


@end
