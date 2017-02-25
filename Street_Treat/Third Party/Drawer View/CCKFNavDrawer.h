//
//  CCKFNavDrawer.h
//  CCKFNavDrawer
//
//  Created by calvin on 23/1/14.
//  Copyright (c) 2014年 com.calvin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DTCustomColoredAccessory.h"
#import "AppDelegate.h"
//#import "Common.h"

@protocol CCKFNavDrawerDelegate <NSObject>
@required
- (void)CCKFNavDrawerSelection:(NSInteger)selectionIndex;
- (void)Drawer_Logout;
@end

@interface CCKFNavDrawer : UINavigationController<UIGestureRecognizerDelegate, UITableViewDataSource, UITableViewDelegate>{
    CGRect temp;
     //Common * commonclass;
    NSMutableIndexSet *expandedSections;
    NSArray * menuNamesArray;
     NSArray * menuImagesArray;
    UIStoryboard * storyboard;
    CGFloat screenHeight,screenWidth;
    NSArray * earlyBirdArray;
     NSArray * earlyBirdImagesArray;
    int ht;
    
    AppDelegate * delegate;
    
}

//Side menu Icons
@property (strong, nonatomic) NSString *searchStoreIcon;
@property (strong, nonatomic) NSString *menIcon;
@property (strong, nonatomic) NSString *womenIcon;
@property (strong, nonatomic) NSString *childrenIcon;
@property (strong, nonatomic) NSString *exhibitionsIcon;
@property (strong, nonatomic) NSString *aboutUsIcon;
@property (strong, nonatomic) NSString *news_eventsIcon;
@property (strong, nonatomic) NSString *terms_conditionsIcon;
@property (strong, nonatomic) NSString *faqsIcon;
@property (strong, nonatomic) NSString *privacyIcon;
@property (strong, nonatomic) NSString *contactUsIcon;
@property (strong, nonatomic) NSString *editProfileIcon;
@property (strong, nonatomic) NSString *rateAppIcon;
@property (strong, nonatomic) NSString *helpIcon;
@property (strong, nonatomic) NSString *logoutIcon;
//end

@property (nonatomic, strong) UIPanGestureRecognizer *pan_gr;
@property (weak, nonatomic)id<CCKFNavDrawerDelegate> CCKFNavDrawerDelegate;

- (void)drawerToggle;
- (void)setUpDrawer;


@end
