//
//  ScrapbookListViewController.m
//  Milestons
//
//  Created by Dalton on 5/2/15.
//  Copyright (c) 2015 Dalton. All rights reserved.
//

#import "ScrapbookListViewController.h"
#import "Appearance.h"
#import "AddScrapbookViewController.h"
#import "ScrapbookController.h"
#import "EntryListViewController.h"
#import "EntryController.h"
#import "CustomScrapbookCell.h"
#import "MyLoginViewController.h"
#import "MySignUpViewController.h"

@import Parse;
@import ParseUI;

@interface ScrapbookListViewController () <UITableViewDelegate, PFSignUpViewControllerDelegate, PFLogInViewControllerDelegate, deleteCellDelegate>

@property (nonatomic, strong) PFUser *currentUser;

@end

@implementation ScrapbookListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [Appearance initializeAppearanceDefaults];

//        self.tableView.backgroundColor = [UIColor colorWithRed:232/255 green:236/255 blue:243/255 alpha:1];
    
    self.refreshControl = [UIRefreshControl new];
    [self.refreshControl addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];
    
    [[ScrapbookController sharedInstance]loadScrapbooksFromParse:^(NSError *error) {
        [self.tableView reloadData];
        
    }];
    
#pragma mark - login view
    
    PFUser *currentUser = [PFUser currentUser];
    if (!currentUser) { // No user logged in
        
        MyLoginViewController *logInViewController = [[MyLoginViewController alloc] init];
        [logInViewController setDelegate:self];
        [logInViewController setFields:PFLogInFieldsUsernameAndPassword
                | PFLogInFieldsSignUpButton
                | PFLogInFieldsDismissButton
                | PFLogInFieldsSignUpButton
                | PFLogInFieldsLogInButton
                | PFLogInFieldsUsernameAndPassword];
        
        MySignUpViewController *signUpViewController = [[MySignUpViewController alloc] init];
        [signUpViewController setDelegate:self];
        [signUpViewController setFields:PFSignUpFieldsDefault
         | PFSignUpFieldsAdditional
         | PFSignUpFieldsAdditional
         | PFSignUpFieldsSignUpButton];
        
        [logInViewController setSignUpController:signUpViewController];
        
        [self presentViewController:logInViewController animated:YES completion:NULL];
    }
}


#pragma mark - login delegate methods

// Sent to the delegate to determine whether the log in request should be submitted to the server.
- (BOOL)logInViewController:(PFLogInViewController *)logInController shouldBeginLogInWithUsername:(NSString *)username password:(NSString *)password {
    // Check if both fields are completed
    if (username && password && username.length != 0 && password.length != 0) {
        return YES; // Begin login process
    }
    
    [[[UIAlertView alloc] initWithTitle:@"Missing Information"
                                message:@"Make sure you fill out all of the information!"
                               delegate:nil
                      cancelButtonTitle:@"OK"
                      otherButtonTitles:nil] show];
    return NO; // Interrupt login process
}



- (void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user {
    self.currentUser = user;
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


// for when the login attempt fails
- (void)logInViewController:(PFLogInViewController *)logInController didFailToLogInWithError:(NSError *)error {
    NSLog(@"Failed to log in...");
}

// For when the login view is dismissed
- (void)logInViewControllerDidCancelLogIn:(PFLogInViewController *)logInController {
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - signup delegate methods

- (BOOL)signUpViewController:(PFSignUpViewController *)signUpController shouldBeginSignUp:(NSDictionary *)info {
    BOOL informationComplete = YES;
    
    // loop through all of the submitted data
    for (id key in info) {
        NSString *field = [info objectForKey:key];
        if (!field || field.length == 0) { // check completion
            informationComplete = NO;
            break;
        }
    }
    
    // Display an alert if a field wasn't completed
    if (!informationComplete) {
        [[[UIAlertView alloc] initWithTitle:@"Missing Information"
                                    message:@"Make sure you fill out all of the information!"
                                   delegate:nil
                          cancelButtonTitle:@"ok"
                          otherButtonTitles:nil] show];
    }
    
    return informationComplete;
}



- (void)signUpViewController:(PFSignUpViewController *)signUpController didSignUpUser:(PFUser *)user {
    self.currentUser = user;
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}



- (void)signUpViewController:(PFSignUpViewController *)signUpController didFailToSignUpWithError:(NSError *)error {
    NSLog(@"Failed to sign up...");
}



- (void)signUpViewControllerDidCancelSignUp:(PFSignUpViewController *)signUpController {
    NSLog(@"User dismissed the signUpViewController");
}



#pragma mark - loading table view with correct data

-(void)refreshTable {
    
    [self.refreshControl beginRefreshing];
    
    [[ScrapbookController sharedInstance]loadScrapbooksFromParse:^(NSError *error) {
        [self.tableView reloadData];
        [self.refreshControl endRefreshing];
        
    }];
    
}


-(void)viewWillAppear:(BOOL)animated {
    
    [self.tableView reloadData];
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"showEntryList"]) {
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Scrapbook *myScrapbook = [ScrapbookController sharedInstance].scrapbooks[indexPath.row];
        
        EntryListViewController *entryListViewController = segue.destinationViewController;
        
        entryListViewController.scrapbook = myScrapbook;
        
        [[EntryController sharedInstance] loadTheseEntriesFromParse:^(NSError *error) {
            [self.tableView reloadData];
            
        }];
        
    }

}


#pragma mark - deleteCellDelegate method

- (void)deleteButtonTapped:(NSIndexPath *)indexPath {
    
//    [self presentDeleteAlertViewController];
    
//    [self.tableView reloadData];
}

//
//-(void)presentDeleteAlertViewController {
//    
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Are you sure you want to delete?" message:@"This will delete this scrapbook and all entries inside it" preferredStyle:UIAlertControllerStyleAlert];
//    
//    [alertController addAction:[UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
//
//        // delete scrapbook here
//
//        [self dismissViewControllerAnimated:YES completion:nil];
//        
//    }]];
//    
//    [alertController addAction:[UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDefault handler:nil]];
//    [self presentViewController:alertController animated:YES completion:nil];
//}



@end
