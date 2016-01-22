//
//  menuSrollView.m
//  GermanKid
//
//  Created by Eric Cao on 1/21/16.
//  Copyright © 2016 sheepcao. All rights reserved.
//

#import "menuSrollView.h"

@implementation menuSrollView
double buttonWidth;

-(void)setupCategory:(NSArray *)categoryArray
{
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    self.delaysContentTouches = YES;

    for (int i = 0; i < categoryArray.count; i++) {
        buttonWidth =self.contentSize.width/categoryArray.count ;
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0+i*buttonWidth, 0,buttonWidth , self.contentSize.height)];
        button.tag = 100+i;
        [button setTitle:categoryArray[i] forState:UIControlStateNormal];
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        button.backgroundColor = [UIColor clearColor];
        [self addSubview:button];
        
    }
    self.backgroundColor = [UIColor whiteColor];
    
    
}

-(void)scrollToPage:(int)page
{
    
    for (UIView *subview in [self subviews]) {
        if ([subview isKindOfClass:[UIButton class]]) {
            
            if (subview.tag == page+100) {
                UIButton *btn = (UIButton *)subview;
                [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                [self setContentOffset:CGPointMake(buttonWidth*(page-1), 0)];
            }else
            {
                UIButton *btn = (UIButton *)subview;
                [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            }
        }
    }
}



/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
