//
//  ViewController.h
//  GermanKid
//
//  Created by Eric Cao on 1/19/16.
//  Copyright © 2016 sheepcao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "globalVar.h"

@interface ViewController : UIViewController
//@property (weak, nonatomic) IBOutlet UIScrollView *mainScroll;
//
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightDistance;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *LeftDistance;
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;

@end

