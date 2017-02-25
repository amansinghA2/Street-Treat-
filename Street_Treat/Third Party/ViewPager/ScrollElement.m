//
//  ScrollElement.m
//
//  Created by mac on 24/03/15.
//  Copyright (c) 2015 Sandeep Aggarwal. All rights reserved.
//

#import "ScrollElement.h"
#import "HorizontalScrollView.h"


@interface ScrollElement ()

@property UILabel* elementLabel;
@property UIView* elementColorView;
@property BOOL isSelected;
@property UIColor* color;


@end

@implementation ScrollElement
{
    CGFloat sizeFactor;
    
}


-(instancetype)init
{
    self=[super init];
    if (self)
    {
        
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self commonMethod];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self= [super initWithCoder:aDecoder];
    
    if (self)
    {
        [self commonMethod];
    }
    
    return self;
}


-(void)commonMethod
{
    sizeFactor=1.0f;
    
    CGFloat width=self.bounds.size.width;
    CGFloat height=self.bounds.size.height;
    
    //label
    UILabel* elementLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, height/4.0f, width, height/2.0f)];
    [elementLabel setTextAlignment:NSTextAlignmentCenter];
    [elementLabel setTextColor:[UIColor blackColor]];
    //[elementLabel setFont:[UIFont fontWithName:@"Helvetica Neue" size:10.0f*sizeFactor]];
    [elementLabel setFont:[UIFont fontWithName:@"fontello" size:10.0f*sizeFactor]];
    
    self.elementLabel=elementLabel;
    
    //colorView
    CGFloat padding=0.0f;
    UIView* elementColorView=[[UIView alloc] initWithFrame:CGRectMake(0, 3.7*height/4.0f, width-padding, 3.0f*sizeFactor)];
    
    self.elementColorView=elementColorView;
    [self addSubview:elementLabel];
    [self addSubview:elementColorView];
    
    //vertical line view
    width=0.5f;
    height=self.bounds.size.height/2.0f;
    CGFloat x=self.bounds.size.width-width/2.0f;
    CGFloat y=(self.bounds.size.height-height)/2.0f;
    
    
    UIView* lineView=[[UIView alloc] initWithFrame:CGRectMake(x, y, width, height)];
    [lineView setBackgroundColor:[UIColor colorWithRed:39/255.0f green:78/255.0f blue:121/255.0f alpha:1.0f]];
    [self addSubview:lineView];
    
    [self addTarget:self action:@selector(select) forControlEvents:UIControlEventTouchUpInside];
}

-(void)setLabel:(NSString*)text color:(UIColor*)color
{
    [self.elementLabel setText:text];
    [self.elementColorView setBackgroundColor:color];
    self.color=color;
}



-(void)select
{
    if (self.isSelected==NO)
    {
        //[self.elementLabel setFont:[UIFont boldSystemFontOfSize:10.0f*sizeFactor]];
        [self.elementLabel setFont:[UIFont fontWithName:@"fontello" size:10.0f*sizeFactor]];
         self.isSelected=YES;
        if (self.delegate && [self.delegate respondsToSelector:@selector(ScrollElementTapped:)])
        {
            [self.delegate ScrollElementTapped:self];
        }
    }
}

-(void)deSelect
{
    if (self.isSelected==YES)
    {
        //[self.elementLabel setFont:[UIFont fontWithName:@"Helvetica Neue" size:10.0f*sizeFactor]];
        [self.elementLabel setFont:[UIFont fontWithName:@"fontello" size:10.0f*sizeFactor]];
        self.isSelected=NO;
    }
    
}


@end
