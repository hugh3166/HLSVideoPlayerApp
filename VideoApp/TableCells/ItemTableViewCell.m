//
//  DetailTableViewCell.m
//  VideoApp
//
//  Created by Young on 9/27/14.
//  Copyright (c) 2014 Young. All rights reserved.
//

#import "ItemTableViewCell.h"

#import "Constants.h"

@implementation ItemTableViewCell
{
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)initInformation: (NSDictionary *)data {
    self.itemNameLabel.text = [data objectForKey:XML_TITLE];
    self.priceLabel.text = [NSString stringWithFormat:@"%@ %@", self.priceLabel.text, [data objectForKey:XML_PRICE]];
}

@end
