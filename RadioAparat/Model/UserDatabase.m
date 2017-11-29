//
//  UserDatabase.m
//  RadioAparat
//
//  Created by Dejan Jevtic on 11/26/17.
//  Copyright © 2017 Dejan Jevtic. All rights reserved.
//

#import "UserDatabase.h"
#import "Song.h"

@import FirebaseDatabase;
@import FirebaseAuth;

@interface UserDatabase ()
@property (nonatomic, retain) FIRDatabaseReference *databaseReferenceForUser;
// Array of liked songs
@property (nonatomic, retain) NSMutableArray *likedSongs;
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

- (instancetype)init {
    self = [super init];
    if (self) {
        [self.databaseReferenceForUser observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
            //NSLog(@"new data: %@" ,[snapshot.value description]);
            id value = snapshot.value;
            if (snapshot.value != nil && ![value isKindOfClass:[NSNull class]]) {
                self.likedSongs = [[NSMutableArray alloc] init];
                NSArray* songs = value;
                for (NSString* s in songs) {
                    Song* song = [[Song alloc] initWithMetadata:s];
                    [self.likedSongs addObject:song];
                }
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

-(NSUInteger) numberOfStoredSongs {
    return [self.likedSongs count];
}

-(Song*) getSongForIndex:(NSUInteger)index {
    return [self.likedSongs objectAtIndex:index];
}

- (BOOL) storeSongForMetadata:(NSString*)metadata {
    NSMutableArray* songsToStore = [[NSMutableArray alloc] init];
    for (Song* s in self.likedSongs) {
        [songsToStore addObject:s.metadataStringValue];
    }
    
    if ([songsToStore containsObject:metadata]) {
        return false;
    }
    
    [songsToStore addObject:metadata];

    [self.databaseReferenceForUser setValue:songsToStore];
    return true;
}
@end
