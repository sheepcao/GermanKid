//
//  detailFirstTableViewCell.m
//  GermanKid
//
//  Created by Eric Cao on 2/2/16.
//  Copyright © 2016 sheepcao. All rights reserved.
//

#import "detailFirstTableViewCell.h"

@implementation detailFirstTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    [self.prodName setFont:[UIFont systemFontOfSize:15.0f weight:UIFontWeightLight]];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
