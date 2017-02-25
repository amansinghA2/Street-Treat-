//
//  BucketsListCell.h
//  Street_Treat
//
//  Created by Kamlesh Dubey on 8/22/16.
//  Copyright © 2016 Digillence Rolson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BucketsListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *bucketListLbl;
@property (weak, nonatomic) IBOutlet UIImageView *bucketListImg;
@property (weak, nonatomic) IBOutlet UIView *bucketSelectView;

@end
