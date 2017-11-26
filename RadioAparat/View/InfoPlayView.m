//
//  InfoPlayView.m
//  RadioAparat
//
//  Created by Dejan Jevtic on 11/10/17.
//  Copyright © 2017 Dejan Jevtic. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "InfoPlayView.h"
#import "LastFm.h"

@implementation InfoPlayView {
}

@synthesize expanded = _expanded;

-(BOOL)expanded {
    return _expanded;
}

-(void) setExpanded:(BOOL)expanded {
    if (expanded) {
        // Expand view.
        self.alpha = 1.0;
        [self.titleLabel setHidden:true];
        [self.downButton setHidden:false];
        [self.shareButton setHidden:false];
        [self.radioAparatLabel setHidden:false];
        self.bottomImageViewConstraint.constant = IMAGE_VIEW_CONSTANT * 10;
        self.topImageViewConstraint.constant = IMAGE_VIEW_CONSTANT * 4;
        self.leftImageViewConstraint.constant = IMAGE_VIEW_CONSTANT * 4;
        self.rightImageViewConstraint.constant = IMAGE_VIEW_CONSTANT * 4;
        [self layoutIfNeeded];
    } else {
        // Show small view
        self.alpha = .95;
        [self.titleLabel setHidden:false];
        [self.downButton setHidden:true];
        [self.shareButton setHidden:true];
        [self.radioAparatLabel setHidden:true];
        self.topImageViewConstraint.constant = IMAGE_VIEW_CONSTANT;
        self.bottomImageViewConstraint.constant = IMAGE_VIEW_CONSTANT;
        self.leftImageViewConstraint.constant = self.leftImageViewConstraintConstant;
        self.rightImageViewConstraint.constant = IMAGE_VIEW_CONSTANT;
        [self layoutIfNeeded];
    }
    _expanded = expanded;
}

-(void)updateNowPlayingInfoCenter:(NSString*)title forArtist:(NSString*)artist forAlbumTitle:(NSString*)albumTitle forImage:(UIImage*)artwork {
    NSMutableDictionary *songInfo = [[NSMutableDictionary alloc] init];
    MPMediaItemArtwork *albumArt = [[MPMediaItemArtwork alloc] initWithBoundsSize:CGSizeMake(100, 100) requestHandler:^(CGSize size) { return artwork; }];
    
    [songInfo setObject:title forKey:MPMediaItemPropertyTitle];
    [songInfo setObject:artist forKey:MPMediaItemPropertyArtist];
    [songInfo setObject:albumTitle forKey:MPMediaItemPropertyAlbumTitle];
    [songInfo setObject:albumArt forKey:MPMediaItemPropertyArtwork];
    
    [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:songInfo];
}

-(void) updateViewWith:(AVPlayerItem*) playerItem {
    AVMetadataItem* metadata = [playerItem.timedMetadata lastObject];
    self.titleLabel.text = metadata.stringValue;
    self.titleLableLarge.text = metadata.stringValue;
    self.titleLabel.scrollDuration = 12.0;
    self.titleLableLarge.scrollDuration = 12.0;
    
    [LastFm sharedInstance].apiKey = @"ce9a96e3f484167e5bd81c663610a568";
    [LastFm sharedInstance].apiSecret = @"e967e63c5ced2da3be1e939ddd1a49b9";
    //[LastFm sharedInstance].session = session;
    //[LastFm sharedInstance].username = username;
    
    NSString* metadataStringValue = metadata.stringValue; // @"Goribor-Burle";
    NSLog(@"metadataStringValue: %@", metadataStringValue);
    
    NSString* artist;
    NSString* song;
    NSUInteger index = [metadataStringValue rangeOfString:@"-"].location;
    if (index != NSNotFound) {
        artist = [metadataStringValue substringToIndex:index];
        song = [metadataStringValue substringFromIndex:index + 1];
        artist = [artist stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]];
        song = [song stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]];
        NSLog(@"Getting image for: %@ - %@", artist, song);
    }
    
    // Update song and artist info.
    if (artist == nil || song == nil) {
        artist = @"";
        song = @"";
    }
    
    [[LastFm sharedInstance] getInfoForTrack:song artist:artist successHandler:^(NSDictionary *result) {
        NSLog(@"result: %@", result);
        NSString* title = [result objectForKey:@"name"];
        NSString* artist = [result objectForKey:@"artist"];
        NSString* albumTitle = [result objectForKey:@"album"];
        __weak UIImageView *weakImageView = self.imageView;
        [self.imageView setImageWithURLRequest:[NSURLRequest requestWithURL:[result objectForKey:@"image"]]
                                      placeholderImage:[UIImage imageNamed:@"RadioAparat.png"]
                                               success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                                   UIImageView *strongImageView = weakImageView; // make local strong reference to protect against race conditions
                                                   if (!strongImageView) return;
                                                   
                                                   [UIView transitionWithView:strongImageView
                                                                     duration:0.3
                                                                      options:UIViewAnimationOptionTransitionCrossDissolve
                                                                   animations:^{
                                                                       strongImageView.image = image;
                                                                       [self updateNowPlayingInfoCenter:title forArtist:artist forAlbumTitle:albumTitle forImage:image];
                                                                   }
                                                                   completion:NULL];
                                               }
                                               failure:NULL];
        
    } failureHandler:^(NSError *error) {
        UIImage* image = [UIImage imageNamed:@"RadioAparat.png"];
        [self.imageView setImage:image];
        [self updateNowPlayingInfoCenter:metadataStringValue forArtist:@"" forAlbumTitle:@"" forImage:image];
        NSLog(@"Error getting track info: %@", error.description);
    }];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
