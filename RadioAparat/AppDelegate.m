//
//  AppDelegate.m
//  RadioAparat
//
//  Created by Dejan Jevtic on 11/10/17.
//  Copyright © 2017 Dejan Jevtic. All rights reserved.
//

#import "AppDelegate.h"
//model
#import "YALTabBarItem.h"

//controller
#import "YALFoldingTabBarController.h"

//helpers
#import "YALAnimatingTabBarConstants.h"
#import "InfoPlayView.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    [self setupYALTabBarControllerAndAudioPlayer];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)setupYALTabBarControllerAndAudioPlayer {
    YALFoldingTabBarController *tabBarController = (YALFoldingTabBarController *) self.window.rootViewController;
    
    //prepare leftBarItems
    YALTabBarItem *item1 = [[YALTabBarItem alloc] initWithItemImage:[UIImage imageNamed:@"nearby_icon"]
                                                      leftItemImage:nil
                                                     rightItemImage:[UIImage imageNamed:@"play_icon"]];
    YALTabBarItem *item2 = [[YALTabBarItem alloc] initWithItemImage:[UIImage imageNamed:@"chats_icon"]
                                                      leftItemImage:[UIImage imageNamed:@"new_chat_icon"]
                                                     rightItemImage:[UIImage imageNamed:@"play_icon"]];

    tabBarController.leftBarItems = @[item1, item2];
    
    //prepare rightBarItems
    YALTabBarItem *item3 = [[YALTabBarItem alloc] initWithItemImage:[UIImage imageNamed:@"profile_icon"]
                                                      leftItemImage:[UIImage imageNamed:@"edit_icon"]
                                                     rightItemImage:[UIImage imageNamed:@"play_icon"]];
    YALTabBarItem *item4 = [[YALTabBarItem alloc] initWithItemImage:[UIImage imageNamed:@"settings_icon"]
                                                      leftItemImage:nil
                                                     rightItemImage:[UIImage imageNamed:@"play_icon"]];
    
    tabBarController.rightBarItems = @[item3, item4];
    
    tabBarController.centerButtonImage = [UIImage imageNamed:@"plus_icon"];
    
    tabBarController.selectedIndex = 0;
    
    //customize tabBarView
    tabBarController.tabBarView.extraTabBarItemHeight = 60.f;//YALExtraTabBarItemsDefaultHeight;
    tabBarController.tabBarView.offsetForExtraTabBarItems = YALForExtraTabBarItemsDefaultOffset;
    tabBarController.tabBarView.backgroundColor = [UIColor colorWithRed:94.f/255.f green:91.f/255.f blue:149.f/255.f alpha:1.f];
    tabBarController.tabBarView.tabBarColor = [UIColor colorWithRed:72.f/255.f green:211.f/255.f blue:178.f/255.f alpha:1.f];
    tabBarController.tabBarViewHeight = YALTabBarViewDefaultHeight;
    tabBarController.tabBarView.tabBarViewEdgeInsets = YALTabBarViewHDefaultEdgeInsets;
    tabBarController.tabBarView.tabBarItemsEdgeInsets = YALTabBarViewItemsDefaultEdgeInsets;
    
    CGRect rect = tabBarController.view.frame;
    rect.size.height = tabBarController.tabBar.frame.size.height;
    rect.origin.y = tabBarController.view.frame.size.height - tabBarController.tabBar.frame.size.height - rect.size.height;
    
    InfoPlayView *infoPlayView = [[[NSBundle mainBundle] loadNibNamed:@"InfoPlayView" owner:nil options:nil] lastObject];
    infoPlayView.frame = rect;
    
    [tabBarController.view addSubview:infoPlayView];
    
    //
    self.player = [AVPlayer playerWithURL:[[NSURL alloc] initWithString:@"http://ca3.rcast.net:8060/"]];
    
    Dodaj Jedan controller kao sub klasu YALFoldingTabBarController.
    Za dobavljanje slika i informacija o pesmi koristi.
    // Set the Last.fm session info
    [LastFm sharedInstance].apiKey = @"xxx";
    [LastFm sharedInstance].apiSecret = @"xxx";
    [LastFm sharedInstance].session = session;
    [LastFm sharedInstance].username = username;
    
    // Get artist info
    [[LastFm sharedInstance] getInfoForArtist:@"Pink Floyd" successHandler:^(NSDictionary *result) {
        NSLog(@"result: %@", result);
    } failureHandler:^(NSError *error) {
        NSLog(@"error: %@", error);
    }];
    
    // Scrobble a track
    [[LastFm sharedInstance] sendScrobbledTrack:@"Wish You Were Here" byArtist:@"Pink Floyd" onAlbum:@"Wish You Were Here" withDuration:534 atTimestamp:(int)[[NSDate date] timeIntervalSince1970] successHandler:^(NSDictionary *result) {
        NSLog(@"result: %@", result);
    } failureHandler:^(NSError *error) {
        NSLog(@"error: %@", error);
    }];
}


@end
