//
//  MainTabBarControllerViewController.m
//  RadioAparat
//
//  Created by Dejan Jevtic on 11/12/17.
//  Copyright © 2017 Dejan Jevtic. All rights reserved.
//

#import "LastFm.h"
#import "MainTabBarControllerViewController.h"
#import "InfoPlayView.h"

@interface MainTabBarControllerViewController () {
    InfoPlayView *infoPlayView;
}

@end

@implementation MainTabBarControllerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect rect = self.view.frame;
    rect.size.height = self.tabBar.frame.size.height;
    rect.origin.y = self.view.frame.size.height - self.tabBar.frame.size.height - rect.size.height;
    
    infoPlayView = [[[NSBundle mainBundle] loadNibNamed:@"InfoPlayView" owner:nil options:nil] lastObject];
    infoPlayView.frame = rect;
    
    [self.view addSubview:infoPlayView];
    
    // Init AVPlayer
    //self.player = [AVPlayer playerWithURL:[[NSURL alloc] initWithString:@"http://ca3.rcast.net:8060/"]];
    
    AVPlayerItem* playerItem = [AVPlayerItem playerItemWithURL:[[NSURL alloc] initWithString:@"http://ca3.rcast.net:8060/"]];
    [playerItem addObserver:self forKeyPath:@"timedMetadata" options:NSKeyValueObservingOptionNew context:nil];
    self.player = [AVPlayer playerWithPlayerItem:playerItem] ;
    [self.player play];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) observeValueForKeyPath:(NSString*)keyPath ofObject:(id)object
                         change:(NSDictionary*)change context:(void*)context {
    
    if ([keyPath isEqualToString:@"timedMetadata"])
    {
        AVPlayerItem* playerItem = object;
        
        for (AVMetadataItem* metadata in playerItem.timedMetadata)
        {
            NSLog(@"\nkey: %@\nkeySpace: %@\ncommonKey: %@\nvalue: %@", [metadata.key description], metadata.keySpace, metadata.commonKey, metadata.stringValue);
        }
        AVMetadataItem* metadata = [playerItem.timedMetadata lastObject];
        infoPlayView.titleLabel.text = metadata.stringValue;
        
        //    Dodaj Jedan controller kao sub klasu YALFoldingTabBarController.
        //    Za dobavljanje slika i informacija o pesmi koristi.
        //    // Set the Last.fm session info
        
        [LastFm sharedInstance].apiKey = @"ce9a96e3f484167e5bd81c663610a568";
        [LastFm sharedInstance].apiSecret = @"e967e63c5ced2da3be1e939ddd1a49b9";
        //[LastFm sharedInstance].session = session;
        //[LastFm sharedInstance].username = username;
        
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
