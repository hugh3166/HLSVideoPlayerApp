//
//  LoginViewController.h
//  VideoApp
//
//  Created by Young on 9/28/14.
//  Copyright (c) 2014 Young. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UILabel *usernameWarn;
@property (weak, nonatomic) IBOutlet UILabel *passwordWarn;

@end
