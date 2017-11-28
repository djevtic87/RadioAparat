//
//  InfoPlayView.h
//  RadioAparat
//
//  Created by Dejan Jevtic on 11/10/17.
//  Copyright © 2017 Dejan Jevtic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MarqueeLabel/MarqueeLabel.h"

#define IMAGE_VIEW_CONSTANT 10.0
#define VIEW_ANIMATION_TIME .3

@interface InfoPlayView : UIView
@property (weak, nonatomic) IBOutlet MarqueeLabel *titleLabel;
@property (weak, nonatomic) IBOutlet MarqueeLabel *titleLableLarge;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topImageViewConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomImageViewConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightImageViewConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftImageViewConstraint;
@property (weak, nonatomic) IBOutlet UIButton *downButton;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UILabel *radioAparatLabel;

@property (nonatomic, assign) BOOL expanded;
@property (nonatomic, assign) CGFloat leftImageViewConstraintConstant;

-(void) updateViewWith:(AVPlayerItem*) playerItem;

@end
