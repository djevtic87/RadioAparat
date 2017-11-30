//
//  ProfileViewController.m
//  RadioAparat
//
//  Created by Dejan Jevtic on 11/10/17.
//  Copyright © 2017 Dejan Jevtic. All rights reserved.
//

#import "ProfileViewController.h"
#import "BaseViewController.h"
#import "YALFoldingTabBar.h"
#import "UserDatabase.h"
#import "AppDelegate.h"
#import "MainTabBarControllerViewController.h"
#import "Song.h"

@import Firebase;
@import FirebaseAuth;
@import GoogleSignIn;

@interface ProfileViewController ()

@end

@implementation ProfileViewController
@synthesize tableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [GIDSignIn sharedInstance].clientID = [FIRApp defaultApp].options.clientID;
    [GIDSignIn sharedInstance].delegate = self;
    [GIDSignIn sharedInstance].uiDelegate = self;
    
    // Set tableView that will be refreshed on like.
    self.appDelegate.userDatabase.tableViewToRefreshOnNewData = self.tableView;
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    FIRAuth *firebaseAuth = [FIRAuth auth];
    if (firebaseAuth.currentUser != nil) {
        [self.signInButton setHidden:true];
        [self.tableView setHidden:false];
    } else {
        [self.signInButton setHidden:false];
        [self.tableView setHidden:true];
    }
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)signIn:(GIDSignIn *)signIn didSignInForUser:(GIDGoogleUser *)user withError:(NSError *)error {
    if (error == nil) {
        GIDAuthentication *authentication = user.authentication;
        FIRAuthCredential *credential = [FIRGoogleAuthProvider credentialWithIDToken:authentication.idToken accessToken:authentication.accessToken];
        
        [[FIRAuth auth] signInWithCredential:credential completion:^(FIRUser * _Nullable user, NSError * _Nullable error) {
            if (user) {
                [self.signInButton setHidden:true];
                [self.tableView setHidden:false];
            } else {
                [self.signInButton setHidden:false];
                [self.tableView setHidden:true];
            }
        }];
    } else {
        NSLog(@"Error: %@", error.localizedDescription);
        [self.signInButton setHidden:false];
        [self.tableView setHidden:true];
    }
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    static NSString * reuseIdentifier = @"programmaticCell";
    MGSwipeTableCell * cell = [self.tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[MGSwipeTableCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    }
    
    NSLog(@"tableView indexPath.row: %ld, total: %lu", (long)indexPath.row, (unsigned long)[self.appDelegate.userDatabase numberOfStoredSongs]);
    if (indexPath.row < [self.appDelegate.userDatabase numberOfStoredSongs]) {
        Song *song = [self.appDelegate.userDatabase getSongForIndex:indexPath.row];
        
        cell.textLabel.text = song.metadataStringValue;
        if (song.album && ![song.album isEqualToString:@""]) {
            cell.detailTextLabel.text = song.album;
        } else {
            cell.detailTextLabel.text = @"RadioAparat";
        }
        
        [song setSongImageInImageView:cell.imageView];
        cell.delegate = self; //optional
        
        cell.rightButtons = @[[MGSwipeButton buttonWithTitle:@"Delete" backgroundColor:[UIColor redColor]]];
        cell.rightSwipeSettings.transition = MGSwipeTransition3D;
    } else {
        cell.textLabel.text = @"";
        cell.detailTextLabel.text =  @"";
        cell.imageView.image = nil;
        cell.rightButtons = [[NSArray alloc] init];
    }

    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.appDelegate.userDatabase numberOfStoredSongs] + EXTRA_CELLS_IN_TABLEVIEW;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:true];
}

/**
 * Called when the user clicks a swipe button or when a expandable button is automatically triggered
 * @return YES to autohide the current swipe buttons
 **/
-(BOOL) swipeTableCell:(MGSwipeTableCell*) cell tappedButtonAtIndex:(NSInteger) index direction:(MGSwipeDirection)direction fromExpansion:(BOOL) fromExpansion {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    NSLog(@"tappedButtonAtIndex: %ld, row: %lu", (long)index, indexPath.row);
    
    [self.appDelegate.userDatabase deleteSongForIndex:indexPath.row];
    
    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    return true;
}

@end
