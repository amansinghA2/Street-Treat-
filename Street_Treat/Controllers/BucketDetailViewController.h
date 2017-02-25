//
//  BucketDetailViewController.h
//  Street_Treat
//
//  Created by Kamlesh Dubey on 9/7/16.
//  Copyright © 2016 Digillence Rolson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Common.h"
#import "AppDelegate.h"

@interface BucketDetailViewController : UIViewController<commonProtocol>{
    Common * commonclass;
    AppDelegate * delegate;
    NSMutableData * BucketsDtlData;
    NSMutableArray * BucketsDtlArr;
    NSString * responseType;
}

@end
