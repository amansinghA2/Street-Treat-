//
//  HorizontalScrollView.h
//
//  Created by mac on 24/03/15.
//  Copyright (c) 2015 Sandeep Aggarwal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScrollElement.h"
#import "NSString+FontAwesome.h"
#import "UIImage+FontAwesome.h"

@protocol HorizontalScrollViewDelegate <NSObject>
-(void)selectedElementControlValueChangedFromIndex:(NSInteger)from to:(NSInteger)to;
@end

@interface HorizontalScrollView : UIScrollView

@property id<HorizontalScrollViewDelegate>horizontalScrollViewDelegate;
@property(nonatomic) NSInteger selectedElementIndex;
@property (nonatomic)  CGFloat width_element;
-(ScrollElement*)addNewScrollElement:(NSString*)text color:(UIColor*)color;
- (id)initWithFrame:(CGRect)frame num_elements:(NSInteger)num_elements;

@property (nonatomic) NSInteger total_elements;

@end
