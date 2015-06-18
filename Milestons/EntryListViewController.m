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
#import "ScrapbookController.h"
#import "InviteController.h"

@import Parse;
@import ParseUI;
@import AddressBookUI;
@import MessageUI;
@import AVFoundation;

@interface EntryListViewController () <UITableViewDelegate, ABPeoplePickerNavigationControllerDelegate, MFMailComposeViewControllerDelegate, AVAudioPlayerDelegate>

@property (weak, nonatomic) IBOutlet UINavigationItem *navBar;
@property (nonatomic, strong) EntryListViewDataSource *tableDataSource;
@property (nonatomic, strong) NSString *emailSaved;

@end

@implementation EntryListViewController
//@synthesize adView;

- (void)viewDidLoad {
    [super viewDidLoad];
 
    
    self.tableDataSource = (EntryListViewDataSource *)self.tableView.dataSource;
    if (self.scrapbook) {
        [self refreshTable];
    }
    
    self.navigationController.toolbarHidden = YES;
    
    self.navBar.title = [NSString stringWithFormat:@"%@", self.scrapbook.titleOfScrapbook];

    [Appearance initializeAppearanceDefaults];
//    self.adView.delegate = self;

    self.tableView.backgroundColor =  [UIColor colorWithRed:233/255.0 green:236/255.0 blue:243/255.0 alpha:1];

    self.refreshControl = [UIRefreshControl new];
    [self.refreshControl addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];
    
    self.navigationController.toolbarHidden = NO;
    
    [self registerForNotifications];
    
} 

- (void)updateWithSB:(Scrapbook *)scrapbook {
    self.scrapbook = scrapbook;
    
}



- (IBAction)addContributorButtonPressed:(id)sender {
    
    // Show ABPeoplePickerNavigationController
    ABPeoplePickerNavigationController *picker = [ABPeoplePickerNavigationController new];
    picker.peoplePickerDelegate = self;
    picker.displayedProperties = @[@(kABPersonEmailProperty)];
    picker.predicateForEnablingPerson = [NSPredicate predicateWithFormat:@"emailAddresses.@count > 0"];
    picker.predicateForSelectionOfPerson = [NSPredicate predicateWithFormat:@"emailAddresses.@count = 1"];

    [self presentViewController:picker animated:YES completion:nil];
    
    NSLog(@"Add Contributors");

}



#pragma mark ABPeoplePickerNavigationControllerDelegate methods

// A selected person is returned with this method.
- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker didSelectPerson:(ABRecordRef)person
{
    [self didSelectPerson:person identifier:kABMultiValueInvalidIdentifier];
}


// A selected person and property is returned with this method.
- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker didSelectPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier
{
    [self didSelectPerson:person identifier:identifier];
}


- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker
{
}

#pragma mark - ABPeoplePickerNavigationController helper methods

- (void)didSelectPerson:(ABRecordRef)person identifier:(ABMultiValueIdentifier)identifier
{

    // When we get the email address of someone back
//        [[UserController sharedInstance] findUsersWithUsernameFromParse:@"emailAddressFromContacts" completion:^(PFUser *contributor, NSError *error) {
//        if (!error) {
//            if (contributor) {
//                [[ScrapbookController sharedInstance] addContributor:contributor toScrapbook:self.scrapbook];
//            } else
//            {
                // have user invite friend to contribute
                NSString *emailAddress = @"no email address";
                ABMultiValueRef emails = ABRecordCopyValue(person, kABPersonEmailProperty);
                if (emails)
                {
                    if (ABMultiValueGetCount(emails) > 0)
                    {
                        CFIndex index = 0;
                        if (identifier != kABMultiValueInvalidIdentifier)
                        {
                            index = ABMultiValueGetIndexForIdentifier(emails, identifier);
                        }
                        emailAddress = CFBridgingRelease(ABMultiValueCopyValueAtIndex(emails, index));
                    }
                    CFRelease(emails);
                }

                
                MFMailComposeViewController *mailViewController = [MFMailComposeViewController new];
                mailViewController.mailComposeDelegate = self;
                [self presentViewController:mailViewController animated:YES completion:nil];
                
                [mailViewController setToRecipients:@[emailAddress]];

                [mailViewController setSubject:@"Contribute to my scrapbook!"];
                
                [mailViewController setMessageBody:@"I would like to add you as a contributor to my scrapbook! Download or log in to MyMilestones to start contributing." isHTML:NO]; // part of string should be link to app store to download app
                [self presentViewController:mailViewController animated:YES completion:nil];
                NSLog(@"Invite");
    
    
    self.emailSaved = emailAddress;
            }






#pragma mark - load tableview with correct data
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


#pragma mark - navigation

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




#pragma mark - cell animation

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1
    
    CGRect originalCellFrame = [self.tableView rectForRowAtIndexPath:indexPath];
    
    // 2
    cell.frame = CGRectMake(self.tableView.frame.size.width + originalCellFrame.size.width,
                            originalCellFrame.origin.y,
                            originalCellFrame.size.width,
                            originalCellFrame.size.height);
    // 3
    [UIView animateWithDuration:0.75
                          delay:0.25
         usingSpringWithDamping:0.8
          initialSpringVelocity:2.0
                        options: UIViewAnimationOptionCurveLinear
     // 4
                     animations:^{
                         cell.frame = originalCellFrame;
                     }
                     completion:^(BOOL finished){
                     }];
    
}


//#pragma mark - banner view delegate methods
//
//-(void)bannerViewDidLoadAd:(ADBannerView *)banner {
//    
//    adView.hidden = NO;
//    NSLog(@"Banner showing");
//}
//
//-(void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error {
//    
//    adView.hidden = YES;
//    NSLog(@"Banner hidden. No ad to show");
//}
//

#pragma mark - nsnotifications methods

-(void)registerForNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(respondToCellDeletion:) name:entryCellDeletedNotificationKey object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(respondToCameraButtonTapped:) name:entryCameraButtonTappedNotificationKey object:nil];
    
}

-(void)respondToCellDeletion:(NSNotification *)notification {
    [self.tableView reloadData];
    
}

- (void)respondToCameraButtonTapped:(NSNotification *)notification {
    
    {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        
        UIAlertController *photoActionSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            
        }];
        
        [photoActionSheet addAction:cancelAction];
        
        UIAlertAction *cameraRollAction = [UIAlertAction actionWithTitle:@"From Library" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            imagePicker.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:imagePicker animated:YES completion:nil];
        }];
        
        [photoActionSheet addAction:cameraRollAction];
        
        UIAlertAction *takePictureAction = [UIAlertAction actionWithTitle:@"Take Picture" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            if ([UIImagePickerController isSourceTypeAvailable:
                 UIImagePickerControllerSourceTypeCamera] == YES) {
                
                imagePicker.sourceType =  UIImagePickerControllerSourceTypeCamera;
                imagePicker.cameraDevice = UIImagePickerControllerCameraDeviceRear;
                imagePicker.allowsEditing = YES;
                
                [self presentViewController:imagePicker animated:YES completion:nil];
                
            } else {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Camera Not Available on Device" message:@"This device does not have a camera option. Please choose photo from library." preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *dismissAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                }];
                
                [alert addAction:dismissAction];
                
                [self presentViewController:alert animated:YES completion:nil];
            }
        }];
        
        [photoActionSheet addAction:takePictureAction];
        
        [self presentViewController:photoActionSheet animated:YES completion:nil];
        
    }
    
}


-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    [picker dismissViewControllerAnimated:YES completion:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:entryImagePickedKey object:nil];
    
    //    customScrapbookCell.photoImageView.image = image;
    
}

-(void)unregisterForNotifications {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:entryCellDeletedNotificationKey object:nil];
}

-(void)dealloc {
    
    [self unregisterForNotifications];
}




#pragma mark - mfmailcompose delegate method

- (void)mailComposeController:(MFMailComposeViewController*)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError*)error
{
    if(error) NSLog(@"ERROR - mailComposeController: %@", [error localizedDescription]);
    
    if (result == MFMailComposeResultSent || result == MFMailComposeResultSaved) {
        // call look up method with email
        [self lookUpEmail];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
    return;
}

-(void)lookUpEmail {
    // When we get the email address of someone back
    [[UserController sharedInstance] findUsersWithUsernameFromParse:self.emailSaved completion:^(PFUser *contributor, NSError *error) {
        if (!error) {
            if (contributor) {
                [[ScrapbookController sharedInstance] addContributor:contributor toScrapbook:self.scrapbook];
            } else {
                // create invite for email and scrapbook
                [[InviteController sharedInstance]createInviteWithEmail:self.emailSaved forScrapbook:self.scrapbook];
            }
        } else {
            // Let them know there was an error
            
            [[[UIAlertView alloc] initWithTitle:@"Error adding contributor"
                                        message:@"Please try again"
                                       delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil] show];
            
            NSLog(@"Error finding user: %@", error);
        }
    }];
    
    self.emailSaved = nil;
}


@end
