//
//  BaseViewController.h
//  RadioAparat
//
//  Created by Dejan Jevtic on 11/10/17.
//  Copyright © 2017 Dejan Jevtic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainTabBarControllerViewController.h"
#import "AppDelegate.h"

@interface BaseViewController : UIViewController
@property (nonatomic, weak) MainTabBarControllerViewController *tabBarController;
@property (nonatomic, weak) AppDelegate *appDelegate;
@end
