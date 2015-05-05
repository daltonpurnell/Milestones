//
//  EntryListViewController.m
//  Milestons
//
//  Created by Dalton on 5/2/15.
//  Copyright (c) 2015 Dalton. All rights reserved.
//

#import "EntryListViewController.h"
#import "Appearance.h"
#import "EntryController.h"
#import "AddEntryViewController.h"

@import Parse;
@import ParseUI;


@interface EntryListViewController () <UITableViewDelegate>

@end

@implementation EntryListViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [Appearance initializeAppearanceDefaults];
    
    
//    // Parse test
//    PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
//    testObject[@"foo"] = @"bar";
//    [testObject saveInBackground];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    AddEntryViewController *addEntryViewController = [AddEntryViewController new];
    [addEntryViewController updateWithEntry:[EntryController sharedInstance].entries[indexPath.row]];
    
}

@end
