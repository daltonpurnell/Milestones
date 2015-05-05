//
//  LoginViewController.m
//  Milestons
//
//  Created by Dalton on 5/4/15.
//  Copyright (c) 2015 Dalton. All rights reserved.
//

#import "LoginViewController.h"
#import "Appearance.h"

@import Parse;
@import ParseUI;


@interface LoginViewController () <PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate>

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [Appearance initializeAppearanceDefaults];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)loginButtonTapped:(id)sender {
    
    PFLogInViewController *logIn = [PFLogInViewController new];
    logIn.delegate = self;
    [self presentViewController:logIn animated:YES completion:nil];
    
}


- (IBAction)signUpButtonTapped:(id)sender {
    
    PFSignUpViewController *signUp = [PFSignUpViewController new];
    signUp.delegate = self;
    [self presentViewController:signUp animated:YES completion:nil];
}



// Delegate methods for authentication view controllers

- (void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)signUpViewController:(PFSignUpViewController *)signUpController didSignUpUser:(PFUser *)user {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}




@end
