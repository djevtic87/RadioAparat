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
    //https://www.rumbletalk.com/client/chat.php?eC71@d@:
    
    NSURL *url = [NSURL URLWithString:self.productURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    
    _webView = [[WKWebView alloc] init];
    [_webView loadRequest:request];
    CGRect frame = self.view.frame;
    frame.origin.y = [UIApplication sharedApplication].statusBarFrame.size.height;
    //self.tabBar.frame.size.height
    frame.size.height = frame.size.height - self.tabBarController.tabBar.frame.size.height - self.tabBarController.tabBar.frame.size.height / 2;
    _webView.frame = frame;
    _webView.scrollView.scrollEnabled = false;
    [self.view addSubview:_webView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
