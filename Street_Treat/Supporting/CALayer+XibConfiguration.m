//
//  CALayer+XibConfiguration.m
//  Street_Treat
//
//  Created by Kamlesh Dubey on 9/12/16.
//  Copyright © 2016 Digillence Rolson. All rights reserved.
//

#import "CALayer+XibConfiguration.h"

@implementation CALayer (XibConfiguration)

-(void)setBorderUIColor:(UIColor*)color
{
    self.borderColor = color.CGColor;
}

-(UIColor*)borderUIColor
{
    return [UIColor colorWithCGColor:self.borderColor];
}

@end
