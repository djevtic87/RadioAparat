//
//  UserDatabase.m
//  RadioAparat
//
//  Created by Dejan Jevtic on 11/26/17.
//  Copyright © 2017 Dejan Jevtic. All rights reserved.
//

#import "UserDatabase.h"
@import FirebaseDatabase;
@import FirebaseAuth;

@interface UserDatabase ()
@property (nonatomic, retain) FIRDatabaseReference *databaseReferenceForUser;
@property (nonatomic, retain) NSMutableArray *likedSongs;
@property (nonatomic, retain) NSMutableArray *tableViewToReloadOnNewData;
@end

@implementation UserDatabase
@synthesize databaseReferenceForUser = _databaseReferenceForUser;
@synthesize tableViewToRefreshOnNewData;

-(FIRDatabaseReference*)databaseReferenceForUser {
    if (!_databaseReferenceForUser) {
        FIRAuth *firebaseAuth = [FIRAuth auth];
        if (firebaseAuth.currentUser != nil) {
            _databaseReferenceForUser = [[FIRDatabase database].reference child:firebaseAuth.currentUser.uid];
        } else {
            _databaseReferenceForUser = nil;
        }
    }
    return _databaseReferenceForUser;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.likedSongs = [[NSMutableArray alloc] init];
        [self.databaseReferenceForUser observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
            //NSLog(@"new data: %@" ,[snapshot.value description]);
            id value = snapshot.value;
            if (snapshot.value != nil && ![value isKindOfClass:[NSNull class]]) {
                self.likedSongs = value;
                if (self.tableViewToRefreshOnNewData != nil) {
                    [self.tableViewToRefreshOnNewData reloadData];
                }
                NSLog(@"Liked songs: %lu", self.likedSongs.count);
            } else {
                NSLog(@"Can not get liked songs.");
            }
        }];
    }
    return self;
}

- (NSArray* ) storedSongsForUser {
    return [self.likedSongs copy];
}

- (void) storeSong:(NSString*) song {
    [self.likedSongs addObject:song];
    [self.databaseReferenceForUser setValue:self.likedSongs];
}

@end
