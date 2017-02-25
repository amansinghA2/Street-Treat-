//
//  MenuViewCell.h
//  Kapu
//
//  Created by Kamlesh Dubey on 9/3/15.
//  Copyright (c) 2015 Digillence Rolson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UIImageView *thumbnailImageView;
@property (weak, nonatomic) IBOutlet UILabel *thumbImg;

@end
