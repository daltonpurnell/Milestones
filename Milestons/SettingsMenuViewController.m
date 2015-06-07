//
//  SettingsMenuViewController.m
//  Milestons
//
//  Created by Dalton on 5/30/15.
//  Copyright (c) 2015 Dalton. All rights reserved.
//

#import "SettingsMenuViewController.h"
#import "SWRevealViewController.h"
#import "MyLoginViewController.h"
#import "MySignUpViewController.h"
#import "ScrapbookController.h"

@import Parse;
@import MessageUI;
@import ParseUI;
@import AddressBookUI;


@interface SettingsMenuViewController () <MFMailComposeViewControllerDelegate, PFSignUpViewControllerDelegate, PFLogInViewControllerDelegate>

@property (nonatomic, strong) PFUser *currentUser;

@end

@implementation SettingsMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.optionsList= [[NSArray alloc] initWithObjects: @"Send Feedback", @"Rate",
                  @"Log Out", nil];
    
    self.tableView.backgroundColor = [UIColor colorWithRed:74/255.0 green:75/255.0 blue:76/255.0 alpha:1];
    
}


-(void)presentLogOutAlert {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Are you sure you want to log out?" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        
        [self dismissViewControllerAnimated:YES completion:nil];
        [PFUser logOut];
            
            MyLoginViewController *logInViewController = [[MyLoginViewController alloc] init];
            [logInViewController setDelegate:self];
            [logInViewController setFields:PFLogInFieldsUsernameAndPassword
             | PFLogInFieldsSignUpButton
             | PFLogInFieldsLogInButton
             | PFLogInFieldsUsernameAndPassword];
            
            MySignUpViewController *signUpViewController = [[MySignUpViewController alloc] init];
            [signUpViewController setDelegate:self];
            [signUpViewController setFields:PFSignUpFieldsDefault
             | PFSignUpFieldsSignUpButton];
            
            [logInViewController setSignUpController:signUpViewController];
            
            [self presentViewController:logInViewController animated:YES completion:NULL];
        
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
}


#pragma mark - data source methods


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.optionsList count];
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"addContributors" forIndexPath:indexPath];
    
    cell.textLabel.text=[self.optionsList objectAtIndex:indexPath.row];
    cell.textLabel.textColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:255/255.0 alpha:1];
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        
        MFMailComposeViewController *mailViewController = [MFMailComposeViewController new];
        mailViewController.mailComposeDelegate = self;
        [self presentViewController:mailViewController animated:YES completion:nil];
        NSLog(@"Send Feedback");
    }
    
    if (indexPath.row == 1) {
        
        // Take user to app store (this doesn't seem to be working)
        {
            NSString *appStoreString = @"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa";
            appStoreString = [NSString stringWithFormat:@"%@/wa/viewContentsUserReviews?", appStoreString];
            appStoreString = [NSString stringWithFormat:@"%@type=Purple+Software&id=", appStoreString];
            
            // app id from itunesconnect
            appStoreString = [NSString stringWithFormat:@"%@997564176", appStoreString];
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:appStoreString]];
        }
        NSLog(@"Rate");
    }
    
    if (indexPath.row == 2) {
        [self presentLogOutAlert];
        NSLog(@"Log Out");
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
    
    [[ScrapbookController sharedInstance]loadScrapbooksFromParse:^(NSError *error) {
        // Nothing
    }];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


// for when the login attempt fails
- (void)logInViewController:(PFLogInViewController *)logInController didFailToLogInWithError:(NSError *)error {
    NSLog(@"Failed to log in...");
}

// For when the login view is dismissed
- (void)logInViewControllerDidCancelLogIn:(PFLogInViewController *)logInController {
    //[self.navigationController popViewControllerAnimated:YES];
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



#pragma mark - cell animation

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1
    CGRect originalCellFrame = [self.tableView rectForRowAtIndexPath:indexPath];
    
    // 2
    cell.frame = CGRectMake(0 - originalCellFrame.size.width,
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


@end
