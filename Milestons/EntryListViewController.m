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
#import "AddScrapbookViewController.h"


@import Parse;
@import ParseUI;


@interface EntryListViewController () <UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *editEntry;

@end

@implementation EntryListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.toolbarHidden = NO;

    [Appearance initializeAppearanceDefaults];
    
        self.tableView.rowHeight = 350;
    
    self.editEntry.tintColor = [UIColor colorWithRed:226/255.0 green:170/255.0 blue:253/255.0 alpha:1];
        
    [[EntryController sharedInstance]loadTheseEntriesFromParse];
    
}


-(void)viewWillAppear:(BOOL)animated {
    
    [self.tableView reloadData];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    if ([segue.identifier isEqualToString:@"presentAddEntry"]) {
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        AddEntryViewController *addEntryViewController = segue.destinationViewController;
        
        Entry *entry = [EntryController sharedInstance].entries[indexPath.row];
        
        addEntryViewController.entry = entry;
    }
}

@end
