//
//  InfoPlayView.m
//  RadioAparat
//
//  Created by Dejan Jevtic on 11/10/17.
//  Copyright © 2017 Dejan Jevtic. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "InfoPlayView.h"
#import "LastFm.h"

@implementation InfoPlayView {
    __weak IBOutlet UIButton *downButton;
}

@synthesize expanded = _expanded;

-(BOOL)expanded {
    return _expanded;
}

-(void) setExpanded:(BOOL)expanded {
    if (expanded) {
        [self.titleLabel setHidden:true];
        [downButton setHidden:false];
        self.bottomImageViewConstraint.constant = IMAGE_VIEW_CONSTANT * 10;
        self.topImageViewConstraint.constant = IMAGE_VIEW_CONSTANT * 4;
        self.leftImageViewConstraint.constant = IMAGE_VIEW_CONSTANT * 4;
        self.rightImageViewConstraint.constant = IMAGE_VIEW_CONSTANT * 4;
        [self layoutIfNeeded];
    } else {
        [self.titleLabel setHidden:false];
        [downButton setHidden:true];
        self.topImageViewConstraint.constant = IMAGE_VIEW_CONSTANT;
        self.bottomImageViewConstraint.constant = IMAGE_VIEW_CONSTANT;
        self.leftImageViewConstraint.constant = self.leftImageViewConstraintConstant;
        self.rightImageViewConstraint.constant = IMAGE_VIEW_CONSTANT;
        [self layoutIfNeeded];
    }
    _expanded = expanded;
}

- (IBAction)downButtonPressed:(id)sender {
}

-(void) updateViewWith:(AVPlayerItem*) playerItem {
    //        for (AVMetadataItem* metadata in playerItem.timedMetadata)
    //        {
    //            NSLog(@"\nkey: %@\nkeySpace: %@\ncommonKey: %@\nvalue: %@", [metadata.key description], metadata.keySpace, metadata.commonKey, metadata.stringValue);
    //        }
    AVMetadataItem* metadata = [playerItem.timedMetadata lastObject];
    self.titleLabel.text = metadata.stringValue;
    self.titleLableLarge.text = metadata.stringValue;
    
    [LastFm sharedInstance].apiKey = @"ce9a96e3f484167e5bd81c663610a568";
    [LastFm sharedInstance].apiSecret = @"e967e63c5ced2da3be1e939ddd1a49b9";
    //[LastFm sharedInstance].session = session;
    //[LastFm sharedInstance].username = username;
    
    NSString* metadataStringValue = metadata.stringValue; // @"Goribor-Burle";
    
    NSString* artist = @"";
    NSString* song = @"";
    NSUInteger index = [metadataStringValue rangeOfString:@"-"].location;
    if (index != NSNotFound) {
        artist = [metadataStringValue substringToIndex:index];
        song = [metadataStringValue substringFromIndex:index + 1];
        artist = [artist stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]];
        song = [song stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]];
        NSLog(@"Getting image for: %@ - %@", artist, song);
    } else {
        NSLog(@"Error getting artist and track info.");
    }
    
    [[LastFm sharedInstance] getInfoForTrack:song artist:artist successHandler:^(NSDictionary *result) {
        NSLog(@"result: %@", result);
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
                                                                   }
                                                                   completion:NULL];
                                               }
                                               failure:NULL];
        
    } failureHandler:^(NSError *error) {
        [self.imageView setImage:[UIImage imageNamed:@"RadioAparat.png"]];
        NSLog(@"Error getting track info: %@", error.description);
    }];
    
    [self setHidden:false];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
