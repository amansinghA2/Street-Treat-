//
//  ContactViewController.h
//  Street_Treat
//
//  Created by Kamlesh Dubey on 6/28/16.
//  Copyright © 2016 Digillence Rolson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Common.h"
#import "UPStackMenu.h"
@import GoogleMaps;


@interface ContactViewController : UIViewController<UPStackMenuDelegate>{
    Common * commonclass;
     NSMutableData *contactData;
    NSString *post;
    NSData *postData;
    NSString *postLength;
    NSMutableURLRequest *request;
    NSURLConnection *theConnection;
    AppDelegate *delegate;
    UIView * flyoutView;
}

@property (strong, nonatomic) UIActivityIndicatorView *indicator;
@property (weak, nonatomic) IBOutlet UILabel *addressLbl;
@property (weak, nonatomic) IBOutlet UILabel *telImg;
@property (weak, nonatomic) IBOutlet UILabel *faxImg;
@property (weak, nonatomic) IBOutlet UILabel *mailImg;
@property (weak, nonatomic) IBOutlet UILabel *telinfo;
@property (weak, nonatomic) IBOutlet UILabel *faxInfo;
@property (weak, nonatomic) IBOutlet UILabel *mailInfo;
@property (weak, nonatomic) IBOutlet UILabel *websiteLbl;
@property (weak, nonatomic) IBOutlet GMSMapView *mapView;

@end
