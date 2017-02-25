//
//  ScrollElement.h
//
//  Created by mac on 24/03/15.
//  Copyright (c) 2015 Sandeep Aggarwal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSString+FontAwesome.h"
#import "UIImage+FontAwesome.h"

@protocol ScrollElementDelegate <NSObject>
-(void)ScrollElementTapped:(id)sender;
@end

@interface ScrollElement : UIControl

@property NSInteger index;
@property (nonatomic, weak) id<ScrollElementDelegate>delegate;
-(void)setLabel:(NSString*)text color:(UIColor*)color;
-(void)select;
-(void)deSelect;

@end