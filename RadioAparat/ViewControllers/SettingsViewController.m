//
//  SettingsViewController.m
//  RadioAparat
//
//  Created by Dejan Jevtic on 11/10/17.
//  Copyright © 2017 Dejan Jevtic. All rights reserved.
//

#import "SettingsViewController.h"
@import Firebase;
@import FirebaseAuth;
@import GoogleSignIn;

@interface SettingsViewController ()

@end

@implementation SettingsViewController
@synthesize tableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    static NSString *MyIdentifier = @"AccountCell";
    
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
    FIRAuth *firebaseAuth = [FIRAuth auth];
    [cell.detailTextLabel setText:@""];
    switch (indexPath.row) {
        case 0:
            if (firebaseAuth.currentUser != nil) {
                [cell.detailTextLabel setText:firebaseAuth.currentUser.email];
            }
            [cell.textLabel setText:@"Account"];
            break;
        case 1:
            [cell.textLabel setText:@"Send Feedback"];
            break;
        case 2:
            [cell.textLabel setText:@"Please Rate RadioAparat"];
            break;
        case 3:
            [cell.textLabel setText:@"About"];
            [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
            break;
        default:
            break;
    }
    
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0: {
                FIRAuth *firebaseAuth = [FIRAuth auth];
                if (firebaseAuth.currentUser != nil) {
                    UIAlertController * view = [UIAlertController alertControllerWithTitle: nil
                                                                                   message: nil
                                                                            preferredStyle: UIAlertControllerStyleActionSheet];
                    
                    UIAlertAction* logOut = [UIAlertAction
                                         actionWithTitle:@"Log Out"
                                         style:UIAlertActionStyleDefault
                                         handler:^(UIAlertAction * action)
                                         {
                                             //Do some thing here
                                             FIRAuth *firebaseAuth = [FIRAuth auth];
                                             NSError* signOutError;
                                             BOOL status = [firebaseAuth signOut:&signOutError];
                                             if (!status) {
                                                 NSLog(@"Sign out error: %@", signOutError);
                                                 return;
                                             } else {
                                                 NSLog(@"User sign out.");
                                                 [self.tableView reloadData];
                                             }
                                             [view dismissViewControllerAnimated:YES completion:nil];
                                             
                                         }];
                    UIAlertAction* cancel = [UIAlertAction
                                             actionWithTitle:@"Cancel"
                                             style:UIAlertActionStyleDefault
                                             handler:^(UIAlertAction * action)
                                             {
                                                 [view dismissViewControllerAnimated:YES completion:nil];
                                             }];
                    
                    
                    [view addAction:logOut];
                    [view addAction:cancel];
                    [self presentViewController:view animated:YES completion:nil];
                }
            }
                break;
            case 1:
                [self performSegueWithIdentifier:@"showFeedback" sender:self];
                break;
            case 3:
                [self performSegueWithIdentifier:@"showAbout" sender:self];
                break;
            default:
                break;
        }
    }
    [self.tableView deselectRowAtIndexPath:indexPath animated:true];
}

//- (void)encodeWithCoder:(nonnull NSCoder *)aCoder { 
//    <#code#>
//}
//
//- (void)traitCollectionDidChange:(nullable UITraitCollection *)previousTraitCollection { 
//    <#code#>
//}
//
//- (void)preferredContentSizeDidChangeForChildContentContainer:(nonnull id<UIContentContainer>)container { 
//    <#code#>
//}
//
//- (CGSize)sizeForChildContentContainer:(nonnull id<UIContentContainer>)container withParentContainerSize:(CGSize)parentSize { 
//    <#code#>
//}
//
//- (void)systemLayoutFittingSizeDidChangeForChildContentContainer:(nonnull id<UIContentContainer>)container { 
//    <#code#>
//}
//
//- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(nonnull id<UIViewControllerTransitionCoordinator>)coordinator { 
//    <#code#>
//}
//
//- (void)willTransitionToTraitCollection:(nonnull UITraitCollection *)newCollection withTransitionCoordinator:(nonnull id<UIViewControllerTransitionCoordinator>)coordinator { 
//    <#code#>
//}
//
//- (void)didUpdateFocusInContext:(nonnull UIFocusUpdateContext *)context withAnimationCoordinator:(nonnull UIFocusAnimationCoordinator *)coordinator { 
//    <#code#>
//}
//
//- (void)setNeedsFocusUpdate { 
//    <#code#>
//}
//
//- (BOOL)shouldUpdateFocusInContext:(nonnull UIFocusUpdateContext *)context { 
//    <#code#>
//}
//
//- (void)updateFocusIfNeeded { 
//    <#code#>
//}

@end
