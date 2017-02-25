//
//  ViewController.h
//  Street_Treat
//
//  Created by Kamlesh Dubey on 5/12/16.
//  Copyright (c) 2016 Digillence Rolson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewController.h"
#import "AppDelegate.h"

@interface ViewController : UIViewController<UIGestureRecognizerDelegate>{
    float duration;
    AppDelegate * delegate;
}
@property (weak, nonatomic) IBOutlet UIImageView *splashImgView;


@end

