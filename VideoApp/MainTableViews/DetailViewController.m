//
//  DetailViewController.m
//  VideoApp
//
//  Created by Young on 9/13/14.
//  Copyright (c) 2014 Young. All rights reserved.
//

#import "DetailViewController.h"
#import "../Constants.h"
#import "../VideoPlayer/PlayerViewController.h"
@import MediaPlayer;

@interface DetailViewController () {
    PlayerViewController *_playerViewController;
    MPMoviePlayerController *_player;
}
- (void)configureView;
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    [self.descriptionLabel sizeToFit];
    
    if (self.detailItem) {
        self.titleLabel.text = [NSString stringWithFormat:@"%@ %@", self.titleLabel.text, [self.detailItem objectForKey:XML_TITLE]];
//        self.authorLabel.text = [self.detailItem objectForKey:XML_AUTHOR];
        self.priceLabel.text = [NSString stringWithFormat:@"%@ %@", self.priceLabel.text, [self.detailItem objectForKey:XML_PRICE]];
//        self.timeLabel.text = [NSString stringWithFormat:@"%@ %@", self.timeLabel.text, [self.detailItem objectForKey:XML_TIME]];
        self.dateLabel.text = [NSString stringWithFormat:@"%@ %@", self.dateLabel.text, [self.detailItem objectForKey:XML_DATE]];
        self.descriptionLabel.text = [NSString stringWithFormat:@"%@ %@", self.descriptionLabel.text, [self.detailItem objectForKey:XML_DESC]];
    }
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(playStreamingMovieButtonPressed)];
    singleTap.numberOfTapsRequired = 1;
    [self.thumbView setUserInteractionEnabled:YES];
    [self.thumbView addGestureRecognizer:singleTap];
}

/* Handle touches to the Thumbnail Image View. */
- (void)playStreamingMovieButtonPressed {
    // Configure the new ViewController. In this case, it reports any
    // changes to a custom delegate object.
    
//        NSURL *theMovieURL = [NSURL URLWithString:@"http://192.168.1.25/~young/stream_server/temp_ts/list.m3u8"];
    NSURL *theMovieURL = [NSURL URLWithString:[_detailItem objectForKey:XML_URL]];
    
    if (_playerViewController == nil) {
        UIStoryboard *storyboard = self.navigationController.storyboard;
        PlayerViewController *playerViewController = [storyboard instantiateViewControllerWithIdentifier:@"PlayerViewController"];
        _playerViewController = playerViewController;
    }
    
    [self presentViewController:_playerViewController animated:YES completion: nil];
    [_playerViewController play: theMovieURL];
}

- (IBAction)onPurchaseOrPlayButtonDown:(UIButton *)sender
{
}

@end
