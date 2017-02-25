//
//  Drawer.m
//  CCKFNavDrawer
//
//  Created by calvin on 2/2/14.
//  Copyright (c) 2014年 com.calvin. All rights reserved.
//

#import "DrawerView.h"

@implementation DrawerView
@synthesize NameLbl,TermsLbl,LoyaltyLvlLbl,StatusLbl;
@synthesize coverPic,profilePic,phoneNoLbl;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
        
        profilePic.layer.cornerRadius = profilePic.frame.size.height/2;
        profilePic.clipsToBounds = YES;
        
        
         // NSLog(@"name.. %@",NameLbl);
       /* NSLog(@"logId.. %@",[delegate.defaults valueForKey:@"logId"]);
      
        NSLog(@"Terms.. %@",[delegate.defaults valueForKey:@"Terms"]);
        NSLog(@"LoyaltyLvl.. %@",[delegate.defaults valueForKey:@"LoyaltyLvl"]);
        NSLog(@"EmailId.. %@",[delegate.defaults valueForKey:@"EmailId"]);
        NSLog(@"loyaltyDiff.. %@",[delegate.defaults valueForKey:@"loyaltyDiff"]);
        NSLog(@"loyaltyVlu.. %@", [delegate.defaults valueForKey:@"loyaltyVlu"]);*/
        
//        [NameLbl setText:[NSString stringWithFormat:@"  Hi, %@",[delegate.defaults valueForKey:@"Name"]]];
//        TermsLbl.text = [delegate.defaults valueForKey:@"Terms"];
//        LoyaltyLvlLbl.text = [delegate.defaults valueForKey:@"LoyaltyLvl"];
//        StatusLbl.text = [NSString stringWithFormat:@"365 days your purchase $%@. More to avail next loyalty level benifits $%@.",[delegate.defaults valueForKey:@"loyaltyVlu"],[delegate.defaults valueForKey:@"loyaltyDiff"]];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    //[self setNeedsDisplay];
    delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
     // NSLog(@"name.. %@",[delegate.defaults valueForKey:@"Name"]);
//    NameLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 250, 30)];
//    NameLbl.textColor = [UIColor whiteColor];
   
    //NSLog(@"logId.. %@",[delegate.defaults valueForKey:@"logId"]);
   // NSLog(@"name.. %@",[delegate.defaults valueForKey:@"Name"]);
   /* NSLog(@"Terms.. %@",[delegate.defaults valueForKey:@"Terms"]);
    NSLog(@"LoyaltyLvl.. %@",[delegate.defaults valueForKey:@"LoyaltyLvl"]);
    NSLog(@"EmailId.. %@",[delegate.defaults valueForKey:@"EmailId"]);
    NSLog(@"loyaltyDiff.. %@",[delegate.defaults valueForKey:@"loyaltyDiff"]);
    NSLog(@"loyaltyVlu.. %@", [delegate.defaults valueForKey:@"loyaltyVlu"]);*/
    
//    dispatch_sync(dispatch_get_main_queue(), ^{
//        [NameLbl setText:[NSString stringWithFormat:@"  Hi, %@",[delegate.defaults valueForKey:@"Name"]]];
//        TermsLbl.text = [delegate.defaults valueForKey:@"Terms"];
//        LoyaltyLvlLbl.text = [delegate.defaults valueForKey:@"LoyaltyLvl"];
//        StatusLbl.text = [NSString stringWithFormat:@"365 days your purchase $%@. More to avail next loyalty level benifits $%@.",[delegate.defaults valueForKey:@"loyaltyVlu"],[delegate.defaults valueForKey:@"loyaltyDiff"]];
//    });
 
//        [NameLbl setText:[NSString stringWithFormat:@"  Hi, %@",[delegate.defaults valueForKey:@"Name"]]];
//    // [super addSubview:NameLbl];
//       TermsLbl.text = [delegate.defaults valueForKey:@"Terms"];
//            LoyaltyLvlLbl.text = [delegate.defaults valueForKey:@"LoyaltyLvl"];
//            StatusLbl.text = [NSString stringWithFormat:@"365 days your purchase $%@. More to avail next loyalty level benifits $%@.",[delegate.defaults valueForKey:@"loyaltyVlu"],[delegate.defaults valueForKey:@"loyaltyDiff"]];
   }

@end
