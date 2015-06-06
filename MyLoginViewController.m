//
//  PFLoginViewController.m
//  Milestons
//
//  Created by Dalton on 5/19/15.
//  Copyright (c) 2015 Dalton. All rights reserved.
//

#import "MyLoginViewController.h"
#import "MySignUpViewController.h"

@interface MyLoginViewController ()

@end

@implementation MyLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self.logInView setBackgroundColor:[UIColor colorWithRed:240/255.0 green:240/255.0 blue:255/255.0 alpha:1]];
    [self.logInView setLogo:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"LaunchImage.png"]]];

    
    [self.logInView.logInButton setBackgroundColor:[UIColor colorWithRed:74/255.0 green:75/255.0 blue:76/255.0 alpha:1]];
    [self.logInView.signUpButton setBackgroundColor:[UIColor colorWithRed:102/255.0 green:183/255.0 blue:235/255.0 alpha:1]];
    
    // Remove text shadow
    CALayer *layer = self.logInView.usernameField.layer;
    layer.shadowOpacity = 0.0;
    layer = self.logInView.passwordField.layer;
    layer.shadowOpacity = 0.0;
    
    // Set field text color
    [self.logInView.usernameField setTextColor:[UIColor colorWithRed:74/255.0 green:75/255.0 blue:76/255.0 alpha:1]];
    [self.logInView.passwordField setTextColor:[UIColor colorWithRed:74/255.0 green:75/255.0 blue:76/255.0 alpha:1]];
    
    
    // Set text field background color
    [self.logInView.usernameField setBackgroundColor:[UIColor colorWithRed:240/255.0 green:240/255.0 blue:255/255.0 alpha:1]];
    [self.logInView.passwordField setBackgroundColor:[UIColor colorWithRed:240/255.0 green:240/255.0 blue:255/255.0 alpha:1]];
}



@end
