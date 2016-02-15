//
//  detailFirstTableViewCell.h
//  GermanKid
//
//  Created by Eric Cao on 2/2/16.
//  Copyright © 2016 sheepcao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "oldPriceButton.h"

@interface detailFirstTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *prodName;
@property (weak, nonatomic) IBOutlet UILabel *priceNow;

@property (weak, nonatomic) IBOutlet oldPriceButton *originalPrice;
@property (weak, nonatomic) IBOutlet UILabel *prodDescrip;
@end
