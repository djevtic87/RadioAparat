//
//  MainTabBarControllerViewController.h
//  RadioAparat
//
//  Created by Dejan Jevtic on 11/12/17.
//  Copyright © 2017 Dejan Jevtic. All rights reserved.
//

#import <FoldingTabBar/FoldingTabBar.h>
#import <AVFoundation/AVFoundation.h>
#import "YALFoldingTabBarController.h"
#import "UserDatabase.h"


@interface MainTabBarControllerViewController : YALFoldingTabBarController

-(void) showInfoView:(BOOL)show;

-(void)playPause;
-(BOOL)likeCurrentSong;

-(BOOL)isAudioPlaying;

@end
