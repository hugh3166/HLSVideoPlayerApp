//
//  NetCommunicator.m
//  VideoApp
//
//  Created by Young on 11/22/14.
//  Copyright (c) 2014 Young. All rights reserved.
//

#import "NetManager.h"

@implementation NetManager

#pragma mark Singleton

+ (id)instance {
    static NetManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (id)init {
    if (self = [super init]) {
        // fields initialize
    }
    return self;
}

#pragma mark - Asynchronous HTTP Request

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    NSLog(@"NSURLConnection statusCode %ld", httpResponse.statusCode);
    if (httpResponse.statusCode != 200) {
    }
    
    long long length = [httpResponse expectedContentLength];
    NSLog(@"Response length: %lld", length);
    
    NSLog(@"Response: %@", response.description);
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSLog(@"Receive data: %@", data.description);
    [self dipatchResponse:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"NSURLConnection error %@", error);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // load finished
    NSLog(@"load finished");
}

- (void)connection:(NSURLConnection *)connection willSendRequestForAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    id <NSURLAuthenticationChallengeSender> sender = challenge.sender;
    NSURLProtectionSpace *protectionSpace = challenge.protectionSpace;
    
    // Should trust server
    if ([self shouldTrustProtectionSpace:protectionSpace]) {
        SecTrustRef trust = [protectionSpace serverTrust];
        NSURLCredential *credential = [NSURLCredential credentialForTrust:trust];
        [sender useCredential:credential forAuthenticationChallenge:challenge];
    } else {
        [sender cancelAuthenticationChallenge:challenge];
    }
}


- (BOOL)connectionShouldUseCredentialStorage:(NSURLConnection *)connection
{
    return YES;
}

- (BOOL) shouldTrustProtectionSpace:(NSURLProtectionSpace *)protectionSpace {
    // load the bundled client certificate
    NSString *certPath = [[NSBundle mainBundle] pathForResource:@"stream_server" ofType:@"cer"];
    NSData *certData = [[NSData alloc] initWithContentsOfFile:certPath];
    /*
     CFDataRef certDataRef = (__bridge_retained CFDataRef)certData;
     SecCertificateRef cert = SecCertificateCreateWithData(NULL, certDataRef);
     
     // Establish a chain of trust anchored on our bundled certificate.
     CFArrayRef certArrayRef = CFArrayCreate(NULL, (void *)&cert, 1, NULL);
     SecTrustRef serverTrust = protectionSpace.serverTrust;
     SecTrustSetAnchorCertificates(serverTrust, certArrayRef);
     
     // Verify that trust
     SecTrustResultType trustResult;
     SecTrustEvaluate(serverTrust, &trustResult);
     
     // Fix if result is a recoverable trust failure
     if (trustResult == kSecTrustResultRecoverableTrustFailure) {
     CFDataRef errDataRef = SecTrustCopyExceptions(serverTrust);
     SecTrustSetExceptions(serverTrust, errDataRef);
     SecTrustEvaluate(serverTrust, &trustResult);
     }
     
     // Did our custom trust chain evaluate successfully?
     return trustResult == kSecTrustResultUnspecified || trustResult == kSecTrustResultProceed;
     */
    
    NSString *localCertDataHash = [certData base64EncodedStringWithOptions: 0];
    
    // get server certificate
    SecTrustRef trust = [protectionSpace serverTrust];
    SecCertificateRef certificate = SecTrustGetCertificateAtIndex(trust, 0);
    NSData* serverCertificateData = (__bridge NSData *)SecCertificateCopyData(certificate);
    NSString *serverCertificateDataHash = [serverCertificateData base64EncodedStringWithOptions: 0];
    
    // compare server certificate with local certificate
    return [serverCertificateDataHash isEqualToString:localCertDataHash];
}

#pragma mark HTTP response processing

- (void) dipatchResponse:(NSData *)content {
    NSMutableDictionary * data = [[NSMutableDictionary alloc] init];
    [data setValue:content forKey:LOGIN_EVENT];
    NSNotification * result = [[NSNotification alloc] initWithName:LOGIN_EVENT object:self userInfo:data];
    [[NSNotificationCenter defaultCenter] postNotification: result];
}

@end
