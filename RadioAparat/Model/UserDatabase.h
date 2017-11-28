//
//  UserDatabase.h
//  RadioAparat
//
//  Created by Dejan Jevtic on 11/26/17.
//  Copyright © 2017 Dejan Jevtic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "Song.h"

@interface UserDatabase : NSObject
@property (weak, nonatomic) UITableView *tableViewToRefreshOnNewData;

-(NSUInteger) numberOfStoredSongs;
-(Song*) getSongForIndex:(NSUInteger)index;

// metadata e.g. Yaeji - Raingurl
- (void) storeSongForMetadata:(NSString*)metadata;

@end
