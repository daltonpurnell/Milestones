//
//  PFSignUpViewController.m
//  Milestons
//
//  Created by Dalton on 5/19/15.
//  Copyright (c) 2015 Dalton. All rights reserved.
//

#import "MySignUpViewController.h"
#import "MyLoginViewController.h"


@interface MySignUpViewController ()

@end

@implementation MySignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.signUpView setBackgroundColor:[UIColor colorWithRed:240/255.0 green:240/255.0 blue:255/255.0 alpha:1]];
    [self.signUpView setLogo:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"LaunchImage.png"]]];
    [self.signUpView.signUpButton setBackgroundColor:[UIColor colorWithRed:102/255.0 green:183/255.0 blue:235/255.0 alpha:1]];

    
    // Remove text shadow
    CALayer *layer = self.signUpView.usernameField.layer;
    layer.shadowOpacity = 0.0;
    layer = self.signUpView.passwordField.layer;
    layer.shadowOpacity = 0.0;
    layer = self.signUpView.additionalField.layer;
    layer.shadowOpacity = 0.0;
    
    // Set field text color
    [self.signUpView.usernameField setTextColor:[UIColor colorWithRed:74/255.0 green:75/255.0 blue:76/255.0 alpha:1]];
    [self.signUpView.passwordField setTextColor:[UIColor colorWithRed:74/255.0 green:75/255.0 blue:76/255.0 alpha:1]];
    [self.signUpView.additionalField setTextColor:[UIColor colorWithRed:74/255.0 green:75/255.0 blue:76/255.0 alpha:1]];
    
    [self.signUpView.usernameField setBackgroundColor:[UIColor colorWithRed:240/255.0 green:240/255.0 blue:255/255.0 alpha:1]];
    [self.signUpView.passwordField setBackgroundColor:[UIColor colorWithRed:240/255.0 green:240/255.0 blue:255/255.0 alpha:1]];
    [self.signUpView.additionalField setBackgroundColor:[UIColor colorWithRed:240/255.0 green:240/255.0 blue:255/255.0 alpha:1]];

}


@end
