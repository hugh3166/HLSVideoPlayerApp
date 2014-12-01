//
//  DetailViewController.h
//  VideoApp
//
//  Created by Young on 9/13/14.
//  Copyright (c) 2014 Young. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIButton *purchaseOrPlayButton;
@property (weak, nonatomic) IBOutlet UIImageView *thumbView;

- (void)playStreamingMovieButtonPressed;

@end
