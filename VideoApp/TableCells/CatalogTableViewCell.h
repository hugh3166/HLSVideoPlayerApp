//
//  CatelogTableViewCell.h
//  VideoApp
//
//  Created by Young on 9/27/14.
//  Copyright (c) 2014 Young. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CatalogTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *catalogNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *videoCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalPriceLabel;
@property (weak, nonatomic) IBOutlet UIButton *purchaseCatalogButton;

- (void)initInformation: (NSDictionary *)data;

@end
