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

@import Parse;
@import ParseUI;

@interface ScrapbookListViewController () <UITableViewDelegate, PFSignUpViewControllerDelegate, PFLogInViewControllerDelegate>

@property (nonatomic, strong) PFUser *currentUser;

@end

@implementation ScrapbookListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [Appearance initializeAppearanceDefaults];
    
    self.refreshControl = [UIRefreshControl new];
    [self.refreshControl addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];
    
    [[ScrapbookController sharedInstance]loadScrapbooksFromParse:^(NSError *error) {
        [self.tableView reloadData];
        
    }];
    
#pragma mark - empty state
    
    // This is not working right...
    if ([ScrapbookController sharedInstance].scrapbooks.count == 0) {
        
        self.tableView.rowHeight = self.view.frame.size.height - 64;
        
        CustomScrapbookCell *customCell = [CustomScrapbookCell new];
        customCell.titleOfScrapbookLabel.hidden = YES;
        customCell.timestampLabel.hidden = YES;
        customCell.photoImageView.hidden = YES;
        
        customCell.instructionsLabel.hidden = NO;
        
    }
    else {
        
        self.tableView.rowHeight = 250;
        
        CustomScrapbookCell *customCell = [CustomScrapbookCell new];
        customCell.titleOfScrapbookLabel.hidden = NO;
        customCell.timestampLabel.hidden = NO;
        customCell.photoImageView.hidden = NO;
        
        customCell.instructionsLabel.hidden = YES;
        
    }
    
#pragma mark - login view
    
    PFUser *currentUser = [PFUser currentUser];
    if (!currentUser) { // No user logged in
        
        // Create the log in view controller
        PFLogInViewController *logInViewController = [[PFLogInViewController alloc] init];
        [logInViewController setDelegate:self];
        
        // Create the sign up view controller
        PFSignUpViewController *signUpViewController = [[PFSignUpViewController alloc] init];
        [signUpViewController setDelegate:self]; 
        
        // Assign our sign up controller to be displayed from the login controller
        [logInViewController setSignUpController:signUpViewController];
        
        // Present the log in view controller
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
    
    [self addUserData];
    
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


- (void)addUserData {
    
    PFQuery *query = [PFQuery queryWithClassName:@"yourData"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        if ([objects count] == 0) {
            
            PFObject *yourData = [PFObject objectWithClassName:@"yourData"];
            yourData[@"dictionaryKey"] = @"dictionaryValue";
            
            // If there is a current user you can set that user as the only user that can access this object:
            if (self.currentUser) {
                yourData.ACL = [PFACL ACLWithUser:self.currentUser];
            }
            
            [yourData saveInBackground];
            
        } else {
            
            NSLog(@"You already stored your data");
        }
        
    }];
    
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
    
    [self addUserData];
    
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

    
    
@end
