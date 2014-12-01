//
//  CatelogTableViewCell.m
//  VideoApp
//
//  Created by Young on 9/27/14.
//  Copyright (c) 2014 Young. All rights reserved.
//

#import "CatalogTableViewCell.h"

#import "Constants.h"

typedef struct CountAndPrice
{
    int count;
    float price;
} CountAndPrice;

@implementation CatalogTableViewCell
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
    NSString *name = [data objectForKey:XML_KEY_NAME];
    self.catalogNameLabel.text = name;
    CountAndPrice countAndPrice = [self calculateTotalCountAndPrice:data];
    self.videoCountLabel.text = [NSString stringWithFormat:@"%@ %d", self.videoCountLabel.text, countAndPrice.count];
    self.totalPriceLabel.text = [NSString stringWithFormat:@"%@ %.2f", self.totalPriceLabel.text, countAndPrice.price];
}

- (CountAndPrice)calculateTotalCountAndPrice: (NSDictionary *)data {
    CountAndPrice result;
    result.count = 0;
    result.price = 0.0f;
    NSArray *subjects = [data objectForKey:XML_SUBJECT];
    if (subjects != nil) {
        // catalog
        for (NSDictionary *subject in subjects) {
            CountAndPrice subResult = [self calculateTotalCountAndPrice:subject];
            result.count += subResult.count;
            result.price += subResult.price;
        }
    } else {
        // items
        NSArray *items = [data objectForKey:XML_ITEM];
        if (items != nil) {
            for (NSDictionary *item in items) {
                result.price += [[item objectForKey:XML_PRICE] floatValue];
            }
            result.count = (int)items.count;
        }
    }
    return result;
}

@end
