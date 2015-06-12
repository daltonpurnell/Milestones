//
//  SettingsMenuViewController.h
//  Milestons
//
//  Created by Dalton on 5/30/15.
//  Copyright (c) 2015 Dalton. All rights reserved.
//
#import <UIKit/UIKit.h>

@import MilestonesKit;

@interface SettingsMenuViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSArray *optionsList;



@end
