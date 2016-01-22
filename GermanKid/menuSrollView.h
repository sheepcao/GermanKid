//
//  menuSrollView.h
//  GermanKid
//
//  Created by Eric Cao on 1/21/16.
//  Copyright © 2016 sheepcao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface menuSrollView : UIScrollView

-(void)setupCategory:(NSArray *)categoryArray;
-(void)scrollToPage:(int)page;
@end
