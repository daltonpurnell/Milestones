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


@interface SettingsMenuViewController ()

@end

@implementation SettingsMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.view.backgroundColor = [UIColor colorWithRed:74/255.0 green:75/255.0 blue:76/255.0 alpha:1];

}

- (IBAction)logOutButtonTapped:(id)sender {
    
    [self presentLogOutAlert];
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
