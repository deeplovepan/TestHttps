//
//  TestHttpsViewController.m
//  TestHttps
//
//  Created by Peter Pan on 12/4/28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "TestHttpsViewController.h"

@interface TestHttpsViewController ()

@end

@implementation TestHttpsViewController

-(void)test:(id)sender
{
    NSString *str = @"https://www.deeplove.com/~peterpan/vk/vk.jpg";
    NSURL *url = [NSURL URLWithString:str];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:req delegate:self startImmediately:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    receiveData = [[NSMutableData alloc] init];
    
    UIButton *but = [[UIButton alloc] initWithFrame:CGRectMake(50, 50, 100, 30)];
    [self.view addSubview:but];
    but.backgroundColor = [UIColor blueColor];
    [but addTarget:self action:@selector(test:) forControlEvents:UIControlEventTouchUpInside];

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark - NSURLConnectionDataDelegate

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    [receiveData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
    NSLog(@"%s", __PRETTY_FUNCTION__);    
    UIImage *image = [[UIImage alloc] initWithData:receiveData];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 480, 300)];
    imageView.image = image;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:imageView];
    
}

#pragma mark - NSURLConnectionDelegate

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
}


- (void)connection:(NSURLConnection *)connection willSendRequestForAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];

}

- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
}


- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
    
    [challenge.sender continueWithoutCredentialForAuthenticationChallenge:challenge];
}


@end
