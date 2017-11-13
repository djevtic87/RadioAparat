//
//  InfoPlayView.h
//  RadioAparat
//
//  Created by Dejan Jevtic on 11/10/17.
//  Copyright © 2017 Dejan Jevtic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+AFNetworking.h"

@interface InfoPlayView : UIView
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

-(void) updateViewWith:(AVPlayerItem*) playerItem;

@end
