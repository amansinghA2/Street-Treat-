//
//  CALayer+XibConfiguration.h
//  Street_Treat
//
//  Created by Kamlesh Dubey on 9/12/16.
//  Copyright © 2016 Digillence Rolson. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface CALayer (XibConfiguration)

// This assigns a CGColor to borderColor.
@property(nonatomic, assign) UIColor* borderUIColor;

@end
