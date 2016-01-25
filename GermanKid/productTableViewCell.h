//
//  productTableViewCell.h
//  GermanKid
//
//  Created by Eric Cao on 1/21/16.
//  Copyright © 2016 sheepcao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface productTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *prodButtonOne;
@property (weak, nonatomic) IBOutlet UIImageView *productImageOne;
@property (weak, nonatomic) IBOutlet UILabel *prodNameOne;
@property (weak, nonatomic) IBOutlet UILabel *prodOneLikeNumber;


@property (weak, nonatomic) IBOutlet UIImageView *productImageTwo;
@property (weak, nonatomic) IBOutlet UIButton *prodButtonTwo;
@property (weak, nonatomic) IBOutlet UILabel *prodNameTwo;
@property (weak, nonatomic) IBOutlet UILabel *prodTwoLikeNumber;


@end
