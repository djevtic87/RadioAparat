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
    if ([self isAudioPlaying]) {
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
-(BOOL) isAudioPlaying {
    return [self.tabBarController isAudioPlaying];
}

- (void)tabBarDidSelectExtraLeftItem:(YALFoldingTabBar *)tabBar {
    BOOL showAlert = false;
    NSString *msg;
    NSString *title;
    if ([self.appDelegate.userDatabase numberOfStoredSongs] < MAX_NUMBER_OF_LIKED_SONGS) {
        if (![self.tabBarController likeCurrentSong]) {
            msg = @"You already liked the song!";
            title = @"Error";
            showAlert = true;
        }
    } else {
        msg = [NSString stringWithFormat:@"You can not like more then %d songs.", MAX_NUMBER_OF_LIKED_SONGS];
        title = @"Maximum number of liked songs.";
        showAlert = true;
    }
    

    
    if (showAlert) {
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:title
                                     message:msg
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
