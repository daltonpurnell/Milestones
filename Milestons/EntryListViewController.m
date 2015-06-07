//
//  EntryListViewController.m
//  Milestons
//
//  Created by Dalton on 5/2/15.
//  Copyright (c) 2015 Dalton. All rights reserved.
//

#import "EntryListViewController.h"
#import "Appearance.h"
#import "EntryController.h"
#import "AddEntryViewController.h"
#import "AddScrapbookViewController.h"
#import "CustomEntryCell.h"
#import "PhotoController.h"
#import "EntryListViewDataSource.h"
#import "CustomCollectionViewCell.h"
#import "UserController.h"

@import Parse;
@import ParseUI;
@import AddressBookUI;
@import MessageUI;

@interface EntryListViewController () <UITableViewDelegate, deleteCellDelegate, ABPeoplePickerNavigationControllerDelegate, MFMailComposeViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UINavigationItem *navBar;
@property (nonatomic, strong) EntryListViewDataSource *tableDataSource;


@end

@implementation EntryListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    
    self.tableDataSource = (EntryListViewDataSource *)self.tableView.dataSource;
    if (self.scrapbook) {
        [self refreshTable];
    }
    
    self.navigationController.toolbarHidden = YES;
    
    self.navBar.title = [NSString stringWithFormat:@"%@", self.scrapbook.titleOfScrapbook];

    [Appearance initializeAppearanceDefaults];

    self.tableView.backgroundColor =  [UIColor colorWithRed:233/255.0 green:236/255.0 blue:243/255.0 alpha:1];
    
    self.refreshControl = [UIRefreshControl new];
    [self.refreshControl addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];
    
    self.navigationController.toolbarHidden = NO;
    
} 

- (void)updateWithSB:(Scrapbook *)scrapbook {
    self.scrapbook = scrapbook;
    
}



- (IBAction)addContributorButtonPressed:(id)sender {
    
    // Show ABPeoplePickerNavigationController
    ABPeoplePickerNavigationController *picker =
    [ABPeoplePickerNavigationController new];
    picker.peoplePickerDelegate = self;
    picker.predicateForEnablingPerson = [NSPredicate predicateWithFormat:@"emailAddresses.@count > 0"];
    picker.predicateForSelectionOfPerson = [NSPredicate predicateWithFormat:@"emailAddresses.@count = 1"];
    
    [self presentViewController:picker animated:YES completion:nil];
    
    NSLog(@"Add Contributors");
    
    
    // When we get the email address of someone back
    [[UserController sharedInstance] findUsersWithUsernameFromParse:@"emailAddressFromContacts" completion:^(PFUser *contributor, NSError *error) {
        if (!error) {
            if (contributor) {
                [[ScrapbookController sharedInstance] addContributor:contributor toScrapbook:self.scrapbook];
            } else {
                // Display message that the user does not have an account and offer to invite
                
                                [self presentInviteAlertViewController];
            }
        } else {
            // Let them know there was an error
            
            [[[UIAlertView alloc] initWithTitle:@"Error finding user"
                                        message:nil
                                       delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil] show];
            
            NSLog(@"Error finding user: %@", error);
        }
    }];
}


-(void)refreshTable {
    
    [self.refreshControl beginRefreshing];
    
    [[EntryController sharedInstance] loadTheseEntriesFromParseInScrapbook:self.scrapbook completion:^(NSArray *entries, NSError *error) {
        self.tableDataSource.entries = entries;
        [self.tableView reloadData];
        
        [self.refreshControl endRefreshing];
    }];
}


-(void)viewWillAppear:(BOOL)animated {
    
    [self.tableView reloadData];
}

#pragma mark - table view delegate method
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
        return 450;
}


#pragma mark - deleteCellDelegate method

- (void)deleteButtonTapped:(NSIndexPath *)indexPath {
        [self.tableView reloadData];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"presentAddEntry"]) {
        UINavigationController *navController = [segue destinationViewController];
        AddEntryViewController *addEntryViewController = navController.viewControllers.firstObject;
        addEntryViewController.didCreateEntry = ^(Entry *entry) {
            [self refreshTable];
        };
        [addEntryViewController updateWithScrapbook:self.scrapbook];
    }

}




#pragma mark - ab people picker delegate methods

- (void)peoplePickerNavigationControllerDidCancel:
(ABPeoplePickerNavigationController *)peoplePicker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (BOOL)peoplePickerNavigationController:
(ABPeoplePickerNavigationController *)peoplePicker
      shouldContinueAfterSelectingPerson:(ABRecordRef)person {
    
    [self displayPerson:person];
    [self dismissViewControllerAnimated:YES completion:^{
        MFMailComposeViewController *mailViewController = [MFMailComposeViewController new];
        mailViewController.mailComposeDelegate = self;
        
//        [mailViewController setToRecipients:(NSString *) emailValueSelected];
        
        [mailViewController setSubject:@"I want to add you as a contributor to my scrapbook!"];
        
        [mailViewController setMessageBody:@"Download MyMilestones to start contributing." isHTML:NO]; // part of string should be link to app store to download app
        
        [self presentViewController:mailViewController animated:YES completion:nil];
        NSLog(@"Invite friend");
    }];
    
    return YES;
}

- (BOOL)peoplePickerNavigationController:
(ABPeoplePickerNavigationController *)peoplePicker
      shouldContinueAfterSelectingPerson:(ABRecordRef)person
                                property:(ABPropertyID)property
                              identifier:(ABMultiValueIdentifier)identifier
{
    
    
    // Only inspect the value if it’s an email
    // get the email address
    if (property == kABPersonEmailProperty) {
        ABMultiValueRef emails = ABRecordCopyValue(person, property);
        CFStringRef emailValueSelected = ABMultiValueCopyValueAtIndex(emails, identifier);

        // Return to the main view controller and launch MFMailcompose
        [ self dismissViewControllerAnimated:YES completion:^{
            MFMailComposeViewController *mailViewController = [MFMailComposeViewController new];
            mailViewController.mailComposeDelegate = self;
            
//            [mailViewController setToRecipients:(NSString *) emailValueSelected];
            
            [mailViewController setSubject:@"I want to add you as a contributor to my scrapbook!"];
            
            [mailViewController setMessageBody:@"Login to MyMilestones to start contributing." isHTML:NO]; // part of string should be link to app store to download app
            
            [self presentViewController:mailViewController animated:YES completion:nil];
            NSLog(@"Invite friend");
        }];

        }
    
    return YES;
}


- (void)displayPerson:(ABRecordRef)person
{
    
}

#pragma mark - invite friend alert controller


-(void)presentInviteAlertViewController {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"This person does not have an account with us" message:@"Would you like to invite him/her to download the app?" preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {

        [self dismissViewControllerAnimated:YES completion:^{
            MFMailComposeViewController *mailViewController = [MFMailComposeViewController new];
            mailViewController.mailComposeDelegate = self;
            [self presentViewController:mailViewController animated:YES completion:nil];
            
//            [mailViewController setToRecipients:(NSString *) emailValueSelected];
            
            [mailViewController setSubject:@"I want to add you as a contributor to my scrapbook!"];
            
            [mailViewController setMessageBody:@"Download to MyMilestones to start contributing." isHTML:NO]; // part of string should be link to app store to download app
            
            NSLog(@"Invite friend");
    }];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDestructive handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
    }]];
}

@end
