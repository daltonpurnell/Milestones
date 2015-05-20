//
//  PFLoginViewController.m
//  Milestons
//
//  Created by Dalton on 5/19/15.
//  Copyright (c) 2015 Dalton. All rights reserved.
//

#import "PFLoginViewController.h"

@interface PFLoginViewController ()

@end

@implementation PFLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self.logInView setBackgroundColor:[UIColor colorWithRed:240/255.0 green:240/255.0 blue:255/255.0 alpha:1]];
    [self.logInView setLogo:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"LaunchImage.png"]]];
    
    // Set buttons appearance
//    [self.logInView.dismissButton setImage:[UIImage imageNamed:@"exit.png"] forState:UIControlStateNormal];
//    [self.logInView.dismissButton setImage:[UIImage imageNamed:@"exit_down.png"] forState:UIControlStateHighlighted];
    
    
//    [self.logInView.signUpButton setBackgroundImage:[UIImage imageNamed:@"signup.png"] forState:UIControlStateNormal];
//    [self.logInView.signUpButton setBackgroundImage:[UIImage imageNamed:@"signup_down.png"] forState:UIControlStateHighlighted];
//    [self.logInView.signUpButton setTitle:@"" forState:UIControlStateNormal];
//    [self.logInView.signUpButton setTitle:@"" forState:UIControlStateHighlighted];
    
    // Remove text shadow
    CALayer *layer = self.logInView.usernameField.layer;
    layer.shadowOpacity = 0.0;
    layer = self.logInView.passwordField.layer;
    layer.shadowOpacity = 0.0;
    
    // Set field text color
    [self.logInView.usernameField setTextColor:[UIColor colorWithRed:74/255.0 green:75/255.0 blue:76/255.0 alpha:1]];
    [self.logInView.passwordField setTextColor:[UIColor colorWithRed:74/255.0 green:75/255.0 blue:76/255.0 alpha:1]];
}



@end
