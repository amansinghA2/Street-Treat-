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
#import "Common.h"

@interface ImageViewController : UIViewController<commonProtocol>{
    Common * commonclass;
    UIButton *backBtn;
     UIButton * DtlcheckInBtn;
}
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIScrollView *ScrollImageView;
@property (weak, nonatomic) NSString *imglink;
@property (weak, nonatomic) NSMutableArray *imagesList;
@end
