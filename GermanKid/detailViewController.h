//
//  detailViewController.h
//  GermanKid
//
//  Created by Eric Cao on 1/25/16.
//  Copyright © 2016 sheepcao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface detailViewController : UIViewController

@property BOOL isFromBanner;

@property (nonatomic,strong) NSString *discount;
@property (nonatomic,strong) NSString *price;
@property (nonatomic,strong) NSString *productUrl;
@property (nonatomic,strong) NSString *likeCount;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *imageCount;
@property (nonatomic,strong) NSString *introduct;

@end
