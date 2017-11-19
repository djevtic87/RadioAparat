//
//  BaseViewController.m
//  RadioAparat
//
//  Created by Dejan Jevtic on 11/10/17.
//  Copyright © 2017 Dejan Jevtic. All rights reserved.
//

#import "BaseViewController.h"
#import "YALFoldingTabBar.h"
#import "AppDelegate.h"
#import "MainTabBarControllerViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    MainTabBarControllerViewController *tabBarController = (MainTabBarControllerViewController *) appDelegate.window.rootViewController;
    
    if ((tabBarController.player.rate != 0) && (tabBarController.player.error == nil)) {
        [tabBarController.tabBarView changeExtraRightTabBarItemWithImage: [UIImage imageNamed:@"pause_icon"]];
    } else {
        [tabBarController.tabBarView changeExtraRightTabBarItemWithImage: [UIImage imageNamed:@"play_icon"]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tabBarDidSelectExtraRightItem:(YALFoldingTabBar *)tabBar {
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    MainTabBarControllerViewController *tabBarController = (MainTabBarControllerViewController *) appDelegate.window.rootViewController;
    if ((tabBarController.player.rate != 0) && (tabBarController.player.error == nil)) {
        [tabBarController.player pause];
        [tabBar changeExtraRightTabBarItemWithImage: [UIImage imageNamed:@"play_icon"]];
        [tabBarController showInfoView:false];
    } else {
        [tabBarController.player play];
        [tabBar changeExtraRightTabBarItemWithImage: [UIImage imageNamed:@"pause_icon"]];
        [tabBarController showInfoView:true];
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
