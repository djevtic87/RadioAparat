//
//  MainTabBarControllerViewController.m
//  RadioAparat
//
//  Created by Dejan Jevtic on 11/12/17.
//  Copyright © 2017 Dejan Jevtic. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import "MainTabBarControllerViewController.h"
#import "InfoPlayView.h"


@interface MainTabBarControllerViewController () {
    InfoPlayView *infoPlayView;
}

@end

@implementation MainTabBarControllerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Add info view.
    CGRect rect = self.view.frame;
    rect.size.height = self.tabBar.frame.size.height;
    rect.origin.y = self.view.frame.size.height - self.tabBar.frame.size.height - rect.size.height;
    
    infoPlayView = [[[NSBundle mainBundle] loadNibNamed:@"InfoPlayView" owner:nil options:nil] lastObject];
    infoPlayView.frame = rect;
    
    [self.view addSubview:infoPlayView];
    
    // Alloc radio player.
    AVPlayerItem* playerItem = [AVPlayerItem playerItemWithURL:[[NSURL alloc] initWithString:@"http://ca3.rcast.net:8060/"]];
    [playerItem addObserver:self forKeyPath:@"timedMetadata" options:NSKeyValueObservingOptionNew context:nil];
    self.player = [AVPlayer playerWithPlayerItem:playerItem] ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) observeValueForKeyPath:(NSString*)keyPath ofObject:(id)object
                         change:(NSDictionary*)change context:(void*)context {
    
    // Get track info data.
    if ([keyPath isEqualToString:@"timedMetadata"])
    {
        AVPlayerItem* playerItem = object;
        [infoPlayView updateViewWith:playerItem];
    }
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
