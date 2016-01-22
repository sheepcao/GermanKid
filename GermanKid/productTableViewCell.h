//
//  productTableViewCell.h
//  GermanKid
//
//  Created by Eric Cao on 1/21/16.
//  Copyright © 2016 sheepcao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface productTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *prodImage;
@property (weak, nonatomic) IBOutlet UIImageView *productImage;

@property (weak, nonatomic) IBOutlet UILabel *productName;
@property (weak, nonatomic) IBOutlet UILabel *buyLabel;
@property (weak, nonatomic) IBOutlet UIButton *voteButton;

@end
