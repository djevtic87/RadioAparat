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
#import "Song.h"

@implementation InfoPlayView {
    Song *currentSong;
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

-(void) updateViewWith:(AVPlayerItem*) playerItem {
    AVMetadataItem* metadata = [playerItem.timedMetadata lastObject];
    self.titleLabel.text = metadata.stringValue;
    self.titleLableLarge.text = metadata.stringValue;
    self.titleLabel.scrollDuration = 12.0;
    self.titleLableLarge.scrollDuration = 12.0;
    
    currentSong = [[Song alloc] initWithMetadata: metadata.stringValue];
    
    [currentSong setSongImageInImageView:self.imageView];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
