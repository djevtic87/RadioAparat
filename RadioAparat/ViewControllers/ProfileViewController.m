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
    
    self.appDelegate.userDatabase.tableViewToRefreshOnNewData = self.tableView;
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
    static NSString *MyIdentifier = @"SongCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    /*
     *   If the cell is nil it means no cell was available for reuse and that we should
     *   create a new one.
     */
    if (cell == nil) {
        
        /*
         *   Actually create a new cell (with an identifier so that it can be dequeued).
         */
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }

    Song *song = [self.appDelegate.userDatabase getSongForIndex:indexPath.row];
    [cell.textLabel setText:song.metadataStringValue];
    [song setSongImageInImageView:cell.imageView];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.appDelegate.userDatabase numberOfStoredSongs];
}

@end
