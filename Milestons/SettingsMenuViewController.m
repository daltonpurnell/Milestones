//
//  SettingsMenuViewController.m
//  Milestons
//
//  Created by Dalton on 5/30/15.
//  Copyright (c) 2015 Dalton. All rights reserved.
//

#import "SettingsMenuViewController.h"
#import "SWRevealViewController.h"
#import "StoreViewController.h"
@import Parse;


@interface SettingsMenuViewController () <UITableViewDelegate>

@end

@implementation SettingsMenuViewController {
    NSArray *menuItems;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.view.backgroundColor = [UIColor colorWithRed:74/255.0 green:75/255.0 blue:76/255.0 alpha:1];
    menuItems = @[@"Add Contributors", @"Send Feedback", @"Rate", @"Log Out"];

}

- (IBAction)logOutButtonTapped:(id)sender {
    
    [self presentLogOutAlert];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return menuItems.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *CellIdentifier = [menuItems objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showStore"]) {
//        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        StoreViewController *storeViewController = [segue destinationViewController];
//        [menuItems objectAtIndex:indexPath.row]]
        [self presentViewController:storeViewController animated:YES completion:nil];
    }

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


@end
