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
@property (weak, nonatomic) IBOutlet UINavigationItem *navBar;

@end

@implementation EntryListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.toolbarHidden = YES;
    
// set title on navbar to title of current scrapbook
    
//    self.navigationController.navigationBar.titleTextAttribute
    
    self.navBar.title = [NSString stringWithFormat:@"%@", self.scrapbook.titleOfScrapbook];

    [Appearance initializeAppearanceDefaults];
    
        self.tableView.rowHeight = 350;
    
    [[EntryController sharedInstance]loadTheseEntriesFromParse:^(NSError *error) {
        [self.tableView reloadData];
        
    }];

    
}


-(void)refreshTable {
    
    [self.refreshControl beginRefreshing];
    
    [[EntryController sharedInstance]loadTheseEntriesFromParse:^(NSError *error) {
        [self.tableView reloadData];
        [self.refreshControl endRefreshing];
        
    }];
    
}


-(void)viewWillAppear:(BOOL)animated {
    
    [self.tableView reloadData];
}

//
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    // Get the new view controller using [segue destinationViewController].
//    if ([segue.identifier isEqualToString:@"presentAddEntry"]) {
//        
//        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
//        
//        AddEntryViewController *addEntryViewController = segue.destinationViewController;
//        
//        Entry *entry = [EntryController sharedInstance].entries[indexPath.row];
//        
//        addEntryViewController.entry = entry;
//    }
//}

@end
