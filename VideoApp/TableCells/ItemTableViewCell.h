//
//  DetailTableViewCell.h
//  VideoApp
//
//  Created by Young on 9/27/14.
//  Copyright (c) 2014 Young. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItemTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *itemNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *thumbnailImage;

- (void)initInformation: (NSDictionary *)data;

@end
