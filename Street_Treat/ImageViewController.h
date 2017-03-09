//
//  ImageViewController.h
//  Street_Treat
//
//  Created by Aman on 08/03/17.
//  Copyright © 2017 Digillence Rolson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"

@interface ImageViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) NSString *imglink;
@end
