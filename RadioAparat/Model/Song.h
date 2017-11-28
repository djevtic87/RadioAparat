//
//  Song.h
//  RadioAparat
//
//  Created by Dejan Jevtic on 11/28/17.
//  Copyright © 2017 Dejan Jevtic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>

@interface Song : NSObject
@property (nonatomic, strong) NSString* title;
@property (nonatomic, strong) NSString* artist;
@property (nonatomic, strong) NSString* album;
@property (nonatomic, strong) NSString* metadataStringValue;
@property (nonatomic, strong) NSURL* imageURL;
@property (nonatomic, strong) UIImage* songImage;

- (instancetype) initWithMetadata:(NSString*) metadata;

-(void) setSongImageInImageView:(UIImageView* )imageView;

@end
