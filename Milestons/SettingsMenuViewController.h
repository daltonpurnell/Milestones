//
//  SettingsMenuViewController.h
//  Milestons
//
//  Created by Dalton on 5/30/15.
//  Copyright (c) 2015 Dalton. All rights reserved.
//

#import "ViewController.h"
#import "SWRevealViewController.h"
#import "MyLoginViewController.h"
#import "MySignUpViewController.h"
#import "ScrapbookController.h"
#import "Appearance.h"

@import Parse;
@import MessageUI;
@import ParseUI;
@import AddressBookUI;

@interface SettingsMenuViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSArray *optionsList;



@end
