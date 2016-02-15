//
//  menuSrollView.h
//  GermanKid
//
//  Created by Eric Cao on 1/21/16.
//  Copyright © 2016 sheepcao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface menuSrollView : UIScrollView
@property (nonatomic,strong) __block UIView  *colorBar;
-(void)setupCategory:(NSArray *)categoryArray;
-(void)scrollToPage:(int)page;
@end
