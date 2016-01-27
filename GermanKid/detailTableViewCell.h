//
//  detailTableViewCell.h
//  GermanKid
//
//  Created by Eric Cao on 1/26/16.
//  Copyright © 2016 sheepcao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface detailTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageDetail;
//@property (strong, nonatomic) UILabel *Imagedescription;
@property (weak, nonatomic) IBOutlet UILabel *descrip;

@end
