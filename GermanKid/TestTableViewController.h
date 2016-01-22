//
//  TestTableViewController.h
//  PageMenuDemoStoryboard
//
//  Created by Jin Sasaki on 2015/06/05.
//  Copyright (c) 2015年 Jin Sasaki. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol scrollEnableDelegate <NSObject>

-(void)enableScroll;

@end


@interface TestTableViewController : UITableViewController
@property (weak,nonatomic) id <scrollEnableDelegate> scrollDelegate;

@end
