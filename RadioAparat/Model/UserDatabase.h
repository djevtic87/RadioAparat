//
//  UserDatabase.h
//  RadioAparat
//
//  Created by Dejan Jevtic on 11/26/17.
//  Copyright © 2017 Dejan Jevtic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface UserDatabase : NSObject

- (NSArray*) storedSongsForUser;
- (void) storeSong:(NSString*) song;

@property (weak, nonatomic) UITableView *tableViewToRefreshOnNewData;

@end
