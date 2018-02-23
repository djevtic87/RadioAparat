//
//  ChatViewController.m
//  RadioAparat
//
//  Created by Dejan Jevtic on 11/10/17.
//  Copyright © 2017 Dejan Jevtic. All rights reserved.
//

#import "ChatViewController.h"

@interface ChatViewController ()

@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.productURL = @"https://www.rumbletalk.com/client/chat.php?eC71@d@:";
    
    NSURL *url = [NSURL URLWithString:self.productURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    
    _webView = [[WKWebView alloc] init];
    [_webView loadRequest:request];
    CGRect frame = self.view.frame;
    frame.origin.y = [UIApplication sharedApplication].statusBarFrame.size.height;
    //frame.size.height = frame.size.height - self.tabBarController.tabBar.frame.size.height - self.tabBarController.tabBar.frame.size.height / 2;
    frame.size.height = frame.size.height - 2 * self.tabBarController.tabBar.frame.size.height;
    _webView.frame = frame;
    _webView.scrollView.scrollEnabled = false;
    [self.view addSubview:_webView];
}

@end
