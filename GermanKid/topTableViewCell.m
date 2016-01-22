//
//  topTableViewCell.m
//  GermanKid
//
//  Created by Eric Cao on 1/21/16.
//  Copyright © 2016 sheepcao. All rights reserved.
//

#import "topTableViewCell.h"

@implementation topTableViewCell

- (void)awakeFromNib {
    // Initialization code
    _loopBanner.autoPlayTimeInterval = 5;

    _loopBanner.continuous = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
