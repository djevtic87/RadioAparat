//
//  ProfileViewController.h
//  RadioAparat
//
//  Created by Dejan Jevtic on 11/10/17.
//  Copyright © 2017 Dejan Jevtic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "MGSwipeTableCell/MGSwipeTableCell.h"

@import FirebaseAuth;
@import GoogleSignIn;

#define EXTRA_CELLS_IN_TABLEVIEW 2

@interface ProfileViewController : BaseViewController <GIDSignInDelegate, GIDSignInUIDelegate, UITableViewDelegate, UITableViewDataSource, MGSwipeTableCellDelegate>
@property (weak, nonatomic) IBOutlet GIDSignInButton *signInButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
