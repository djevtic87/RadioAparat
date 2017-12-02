//
//  UserDatabase.m
//  RadioAparat
//
//  Created by Dejan Jevtic on 11/26/17.
//  Copyright © 2017 Dejan Jevtic. All rights reserved.
//

#import "UserDatabase.h"
#import "Song.h"
#import "ProfileViewController.h"

@import FirebaseDatabase;
@import FirebaseAuth;

@interface UserDatabase ()
@property (nonatomic, retain) FIRDatabaseReference *databaseReferenceForUser;
// Array of liked songs
@property (nonatomic, retain) NSMutableArray *likedSongs;
@property (nonatomic, assign) BOOL doNotUpdateTableView;
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
        self.doNotUpdateTableView = false;
        self.likedSongs = [[NSMutableArray alloc] init];
        [self.databaseReferenceForUser observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
            NSLog(@"new data: %@" ,[snapshot.value description]);
            id value = snapshot.value;
            if (snapshot.value != nil && ![value isKindOfClass:[NSNull class]]) {
                [self.likedSongs removeAllObjects];
                NSArray* songs = value;
                for (NSString* s in songs) {
                    Song* song = [[Song alloc] initWithMetadata:s];
                    [self.likedSongs addObject:song];
                }
                if (self.tableViewToRefreshOnNewData != nil) {
                    if (self.doNotUpdateTableView) {
                        self.doNotUpdateTableView = false;
                    } else {
                        [self.tableViewToRefreshOnNewData reloadData];
                    }
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
    if (self.likedSongs.count >= MAX_NUMBER_OF_LIKED_SONGS) {
        return false;
    }
    
    NSMutableArray* songsToStore = [[NSMutableArray alloc] init];
    for (Song* s in self.likedSongs) {
        [songsToStore addObject:s.metadataStringValue];
    }
    
    if ([songsToStore containsObject:metadata]) {
        return false;
    }
    
    NSUInteger section = 0;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.likedSongs.count inSection:section];

    // New liked song to be added.
    Song* songToAdd = [[Song alloc] initWithMetadata:metadata];
    
    // Add new song into the stored songs.
    // We need to add this song before we insert new tableView cell.
    [self.likedSongs addObject:songToAdd];
    [songsToStore addObject:songToAdd.metadataStringValue];
    
    // Update insert new song into the tableView.
    [self.tableViewToRefreshOnNewData beginUpdates];
    [self.tableViewToRefreshOnNewData insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.tableViewToRefreshOnNewData endUpdates];
    
    // Do not refresh tableView;
    self.doNotUpdateTableView = true;
    
    // Update firebase database.
    [self.databaseReferenceForUser setValue:songsToStore];

    return true;
}

- (void) deleteSongForIndex:(NSUInteger)index {
    NSMutableArray* songsToStore = [[NSMutableArray alloc] init];
    [self.likedSongs removeObjectAtIndex:index];
    for (Song* s in self.likedSongs) {
        [songsToStore addObject:s.metadataStringValue];
    }
    
    self.doNotUpdateTableView = true;
    
    [self.databaseReferenceForUser setValue:songsToStore];
}

@end
