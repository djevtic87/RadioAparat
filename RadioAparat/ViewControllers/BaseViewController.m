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
@synthesize tabBarController = _tabBarController;
@synthesize appDelegate = _appDelegate;

-(MainTabBarControllerViewController*) tabBarController {
    if (!_tabBarController) {
        AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        _tabBarController = (MainTabBarControllerViewController *) appDelegate.window.rootViewController;
    }
    return _tabBarController;
}

-(AppDelegate*) appDelegate {
    if (!_appDelegate) {
        _appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    }
    return _appDelegate;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if ((self.tabBarController.player.rate != 0) && (self.tabBarController.player.error == nil)) {
        [self.tabBarController.tabBarView changeExtraRightTabBarItemWithImage: [UIImage imageNamed:@"pause_icon"]];
    } else {
        [self.tabBarController.tabBarView changeExtraRightTabBarItemWithImage: [UIImage imageNamed:@"play_icon"]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tabBarDidSelectExtraRightItem:(YALFoldingTabBar *)tabBar {
    [self.tabBarController playPause];
}

- (void)tabBarDidSelectExtraLeftItem:(YALFoldingTabBar *)tabBar {
    if (![self.tabBarController like]) {
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@"Error"
                                     message:@"You already liked the song!"
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        //Add Buttons
        
        UIAlertAction* okButton = [UIAlertAction
                                    actionWithTitle:@"OK"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action) {
                                    }];
        
        //Add your buttons to alert controller
        
        [alert addAction:okButton];
        [self presentViewController:alert animated:YES completion:nil];
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
