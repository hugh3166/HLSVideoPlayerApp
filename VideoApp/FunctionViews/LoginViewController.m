//
//  LoginViewController.m
//  VideoApp
//
//  Created by Young on 9/28/14.
//  Copyright (c) 2014 Young. All rights reserved.
//

#import "LoginViewController.h"
#import "../Utilities/NetManager.h"

@interface LoginViewController (){
    NetManager *_netManager;
}
@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (_netManager == nil) {
        _netManager = [NetManager instance];
    }
    _passwordField.delegate = self;
    _usernameField.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == _usernameField) {
        [_passwordField becomeFirstResponder];
    } else if (textField == _passwordField) {
        [self onLoginButtonClick: _loginButton];
    }
    return YES;
}

- (IBAction)onLoginButtonClick:(UIButton *)sender {
    BOOL inputOK = YES;
    if (!_passwordField.hasText) {
        [_passwordField becomeFirstResponder];
        inputOK = NO;
        _passwordWarn.hidden = NO;
    } else {
        _passwordWarn.hidden = YES;
    }
    if (!_usernameField.hasText) {
        [_usernameField becomeFirstResponder];
        inputOK = NO;
        _usernameWarn.hidden = NO;
    } else {
        _usernameWarn.hidden = YES;
    }
    if (!inputOK) {
        return;
    }
    
    // TODO: encrypt password
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://localhost/~young/stream_server/stream_login.php"]];
    [request setHTTPMethod:@"POST"];
    NSString *bodyData = @"u=user&pw=passwod";
    [request setHTTPBody:[NSData dataWithBytes:[bodyData UTF8String] length:strlen([bodyData UTF8String])]];
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:_netManager];
    [conn start];
    
    /*
    CFStringRef bodyString = CFSTR(""); // Usually used for POST data
    CFStringRef headerFieldName = CFSTR("X-My-Favorite-Field");
    CFStringRef headerFieldValue = CFSTR("Dreams");
    CFDataRef bodyData = CFStringCreateExternalRepresentation(kCFAllocatorDefault,
                                                              bodyString, kCFStringEncodingUTF8, 0);
    
    CFStringRef url = CFSTR("http://www.apple.com");
    CFURLRef myURL = CFURLCreateWithString(kCFAllocatorDefault, url, NULL);
    CFStringRef requestMethod = CFSTR("GET");
    
    CFHTTPMessageRef myRequest = CFHTTPMessageCreateRequest(kCFAllocatorDefault,
                                                            requestMethod, myURL, kCFHTTPVersion1_1);
    CFHTTPMessageSetBody(myRequest, bodyData);
    CFHTTPMessageSetHeaderFieldValue(myRequest, headerFieldName, headerFieldValue);
    CFReadStreamRef myReadStream = CFReadStreamCreateForHTTPRequest(kCFAllocatorDefault, myRequest);
    CFReadStreamOpen(myReadStream);
     */
}

- (IBAction)onCancelButtonClick:(UIButton *)sender {
    [self.view removeFromSuperview];
}

@end
