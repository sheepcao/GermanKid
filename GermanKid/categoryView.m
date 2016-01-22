//
//  categoryView.m
//  GermanKid
//
//  Created by Eric Cao on 1/22/16.
//  Copyright © 2016 sheepcao. All rights reserved.
//

#import "categoryView.h"
#import "globalVar.h"

@implementation categoryView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setupView:frame];
        return self;
    }
    return nil;
}

-(void)setupView:(CGRect)frame
{
    self.backgroundColor = [UIColor colorWithRed:242.0/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];

    self.firstBtn = [[UIButton alloc] initWithFrame:CGRectMake((frame.size.width/4 - categoryBtnHeight)/2, (categoryViewHeight-categoryBtnHeight)/2, categoryBtnHeight, categoryBtnHeight)];
    self.firstBtn.layer.cornerRadius = self.firstBtn.frame.size.height/2;
    self.firstBtn.layer.masksToBounds = YES;
    [self.firstBtn setImage:[UIImage imageNamed:@"boy.png"] forState:UIControlStateNormal];
    [self addSubview:self.firstBtn];
    
    
    self.secondBtn = [[UIButton alloc] initWithFrame:CGRectMake((frame.size.width/4 - categoryBtnHeight)/2+frame.size.width/4, (categoryViewHeight-categoryBtnHeight)/2, categoryBtnHeight, categoryBtnHeight)];
    self.secondBtn.layer.cornerRadius = self.secondBtn.frame.size.height/2;
    self.secondBtn.layer.masksToBounds = YES;
    [self.secondBtn setImage:[UIImage imageNamed:@"boy.png"] forState:UIControlStateNormal];
    [self addSubview:self.secondBtn];
    
    
    self.thirdBtn = [[UIButton alloc] initWithFrame:CGRectMake((frame.size.width/4 - categoryBtnHeight)/2+2*frame.size.width/4, (categoryViewHeight-categoryBtnHeight)/2, categoryBtnHeight, categoryBtnHeight)];
    self.thirdBtn.layer.cornerRadius = self.thirdBtn.frame.size.height/2;
    self.thirdBtn.layer.masksToBounds = YES;
    [self.thirdBtn setImage:[UIImage imageNamed:@"boy.png"] forState:UIControlStateNormal];
    [self addSubview:self.thirdBtn];
    
    
    self.forthBtn = [[UIButton alloc] initWithFrame:CGRectMake((frame.size.width/4 - categoryBtnHeight)/2+3*frame.size.width/4, (categoryViewHeight-categoryBtnHeight)/2, categoryBtnHeight, categoryBtnHeight)];
    self.forthBtn.layer.cornerRadius = self.forthBtn.frame.size.height/2;
    self.forthBtn.layer.masksToBounds = YES;
    [self.forthBtn setImage:[UIImage imageNamed:@"boy.png"] forState:UIControlStateNormal];
    [self addSubview:self.forthBtn];
    
}

@end
