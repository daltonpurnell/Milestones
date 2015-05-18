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
    
    // this is not working right
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
    
    self.refreshControl = [UIRefreshControl new];
    [self.refreshControl addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];
    
    [[ScrapbookController sharedInstance]loadScrapbooksFromParse:^(NSError *error) {
        [self.tableView reloadData];
        
    }];
    
    
    PFUser *currentUser = [PFUser currentUser];
    if (!currentUser) {
        
        PFLogInViewController *logIn = [PFLogInViewController new];
        logIn.delegate = self;
        logIn.signUpController.delegate = self;
        [self presentViewController:logIn animated:YES completion:nil];
        
    }
    
}


#pragma mark - login view controller delegate methods

- (void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user {
    self.currentUser = user;
    
    [self addUserData];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)signUpViewController:(PFSignUpViewController *)signUpController didSignUpUser:(PFUser *)user {
    self.currentUser = user;
    
    [self addUserData];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
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
