//
//  SettingsMenuViewController.m
//  Milestons
//
//  Created by Dalton on 5/30/15.
//  Copyright (c) 2015 Dalton. All rights reserved.
//

#import "SettingsMenuViewController.h"
#import "SWRevealViewController.h"
@import Parse;
@import MessageUI;


@interface SettingsMenuViewController () <MFMailComposeViewControllerDelegate>

@end

@implementation SettingsMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.optionsList= [[NSArray alloc] initWithObjects: @"Add Contributors", @"Send Feedback", @"Rate",
                  @"Log Out", nil];
    
    self.tableView.backgroundColor = [UIColor colorWithRed:74/255.0 green:75/255.0 blue:76/255.0 alpha:1];
    
}


-(void)presentLogOutAlert {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Are you sure you want to log out?" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        
        [self dismissViewControllerAnimated:YES completion:nil];
        [PFUser logOut];
        
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
        NSLog(@"Add Contributors");
    }
    
    if (indexPath.row == 1) {
        
        MFMailComposeViewController *mailViewController = [MFMailComposeViewController new];
        mailViewController.mailComposeDelegate = self;
        [self presentViewController:mailViewController animated:YES completion:nil];
        NSLog(@"Send Feedback");
    }
    
    if (indexPath.row == 2) {
        
        // Take user to app store
//        {
//            NSString *appStoreString = @"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa";
//            appStoreString = [NSString stringWithFormat:@"%@/wa/viewContentsUserReviews?", appStoreString];
//            appStoreString = [NSString stringWithFormat:@"%@type=Purple+Software&id=", appStoreString];
//            
//            // app id from itunesconnect
//            appStoreString = [NSString stringWithFormat:@"%@yourAppIDHere", appStoreString];
//            
//            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:appStoreString]];
//        }
        NSLog(@"Rate");
    }
    
    if (indexPath.row == 3) {
        [self presentLogOutAlert];
        NSLog(@"Log Out");
    }
    
}

@end
