//
//  ProgramViewController.m
//  RadioAparat
//
//  Created by Dejan Jevtic on 11/10/17.
//  Copyright © 2017 Dejan Jevtic. All rights reserved.
//

#import "ProgramViewController.h"

@interface ProgramViewController ()

@end

@implementation ProgramViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // self.productURL = @"http://www.radioaparat.com/program-raspored";
    self.productURL = @"https://google-calendar.galilcloud.wixapps.net/?cacheKiller=1512212302416&compId=comp-j1h4rdij&deviceType=desktop&height=863&instance=oWYUR_hTpOzta1PCzMj0v5taozuut4A3bW1o7hTTnRI.eyJpbnN0YW5jZUlkIjoiMjY5NzE4ZjAtN2M4Zi00OGVhLWEyNjEtZTUyYjI1YWRiNGI5IiwiYXBwRGVmSWQiOiIxMjlhY2I0NC0yYzhhLTgzMTQtZmJjOC03M2Q1Yjk3M2E4OGYiLCJzaWduRGF0ZSI6IjIwMTctMTItMDJUMTA6NTg6MjEuMjQ1WiIsInVpZCI6bnVsbCwiaXBBbmRQb3J0IjoiMTg4LjIuMTkuMTM1LzU3NzQ0IiwidmVuZG9yUHJvZHVjdElkIjpudWxsLCJkZW1vTW9kZSI6ZmFsc2UsImFpZCI6IjdjYWNkZTEzLTJhYjMtNDZlZi1iM2NjLWMzN2I1NDMxNTIwNyIsImJpVG9rZW4iOiI4MGE2Nzc3Yi02ZmUyLTA5ZmItMjQ2ZC01NTliMDIwZGY5NGEiLCJzaXRlT3duZXJJZCI6IjI1YmM4OTYwLTBhMDMtNDhhOS1hYjc4LTg0ODcwN2U1ODQ4ZSJ9&locale=en&pageId=rq9im&viewMode=mobile&vsi=77af0099-6da9-4bd1-bbd5-c1c3cc0d002e&width=980";
    
    NSURL *url = [NSURL URLWithString:self.productURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    
    _webView = [[WKWebView alloc] init];
    [_webView loadRequest:request];
    CGRect frame = self.view.frame;
    frame.origin.y = [UIApplication sharedApplication].statusBarFrame.size.height;
    _webView.frame = frame;
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
