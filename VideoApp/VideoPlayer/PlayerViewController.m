//
//  PlayerViewController.m
//  VideoApp
//
//  Created by Young on 11/22/14.
//  Copyright (c) 2014 Young. All rights reserved.
//

#import "PlayerViewController.h"
@import MediaPlayer;

@interface PlayerViewController () {
    MPMoviePlayerController *_player;
    MPMoviePlayerViewController *_playViewController;
}
@end

@implementation PlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)dealloc {
    _player = nil;
}

- (void)playbackDidFinish:(NSNotification*)notification {
    NSNumber *reason = [notification.userInfo objectForKey:MPMoviePlayerPlaybackDidFinishReasonUserInfoKey];
    switch ([reason intValue]) {
        case MPMovieFinishReasonPlaybackEnded:
            NSLog(@"MPMovieFinishReasonPlaybackEnded");
            break;
        case MPMovieFinishReasonPlaybackError:
            NSLog(@"MPMovieFinishReasonPlaybackError");
            break;
        case MPMovieFinishReasonUserExited:
            NSLog(@"MPMovieFinishReasonUserExited");
            [self exit];
            break;
        default:
            break;
    }
}

- (void)playbackStateDidChange:(NSNotification *)notification {
    switch (_player.playbackState) {
        case MPMoviePlaybackStatePlaying:
            NSLog(@"MPMoviePlaybackStatePlaying");
            break;
        case MPMoviePlaybackStateStopped:
            NSLog(@"MPMoviePlaybackStateStopped");
            break;
        case MPMoviePlaybackStatePaused:
            NSLog(@"MPMoviePlaybackStatePaused");
            break;
        case MPMoviePlaybackStateInterrupted:
            NSLog(@"MPMoviePlaybackStateInterrupted");
            break;
        case MPMoviePlaybackStateSeekingForward:
            NSLog(@"MPMoviePlaybackStateSeekingForward");
            break;
        case MPMoviePlaybackStateSeekingBackward:
            NSLog(@"MPMoviePlaybackStateSeekingBackward");
            break;
        default:
            break;
    }
}

- (void)exit {
    [self dismissViewControllerAnimated:YES completion:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackStateDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    _player = nil;
}

- (void)play:(NSURL *)url {
    _playViewController = [[MPMoviePlayerViewController alloc] initWithContentURL:url];
    
    _player = _playViewController.moviePlayer;
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playbackStateDidChange:)
                                                 name:MPMoviePlayerPlaybackStateDidChangeNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playbackDidFinish:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:nil];
    
    [_player prepareToPlay];
    [_player.view setFrame: [self view].bounds];  // player's frame must match parent's
    [[self view] addSubview: _player.view];
    
    // Set movie player layout
    [_player setControlStyle:MPMovieControlStyleFullscreen];
    [_player setFullscreen:YES];
    _player.shouldAutoplay = YES;
    
    // May help to reduce latency
    [_player prepareToPlay];
    
    /** // credential
     NSURLCredential *credential = [[NSURLCredential alloc]
     initWithUser: @"userName"
     password: @"password"
     persistence: NSURLCredentialPersistenceForSession];
     self.credential = credential;
     [credential release];
     **/
    [self presentMoviePlayerViewControllerAnimated: _playViewController];
//    [_player play];
}

@end
