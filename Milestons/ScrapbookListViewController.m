//
//  ScrapbookListViewController.m
//  Milestons
//
//  Created by Dalton on 5/2/15.
//  Copyright (c) 2015 Dalton. All rights reserved.
//

#import "ScrapbookListViewController.h"
#import "Appearance.h"
#import "AddScrapbookViewController.h"
#import "ScrapbookController.h"
#import "EntryListViewController.h"
#import "EntryController.h"
#import "CustomScrapbookCell.h"

@import Parse;
@import ParseUI;

@interface ScrapbookListViewController () <UITableViewDelegate>

@end

@implementation ScrapbookListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [Appearance initializeAppearanceDefaults];
    
    // this is not working right
    if ([ScrapbookController sharedInstance].scrapbooks.count == 0) {
        
        self.tableView.rowHeight = self.view.frame.size.height;
        
        CustomScrapbookCell *customCell = [CustomScrapbookCell new];
        customCell.titleOfScrapbookLabel.hidden = YES;
        customCell.timestampLabel.hidden = YES;
        customCell.photoImageView.hidden = YES;
        
        customCell.instructionsLabel.hidden = NO;
        
    }
    else {
    
        self.tableView.rowHeight = 250;
        
        CustomScrapbookCell *customCell = [CustomScrapbookCell new];
        customCell.titleOfScrapbookLabel.hidden = NO;
        customCell.timestampLabel.hidden = NO;
        customCell.photoImageView.hidden = NO;
    
        customCell.instructionsLabel.hidden = YES;
        
    }
    
    self.refreshControl = [UIRefreshControl new];
    [self.refreshControl addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];
    
    [[ScrapbookController sharedInstance]loadScrapbooksFromParse:^(NSError *error) {
        [self.tableView reloadData];
        
    }];
    
}

-(void)refreshTable {
    
    [self.refreshControl beginRefreshing];
    
    [[ScrapbookController sharedInstance]loadScrapbooksFromParse:^(NSError *error) {
        [self.tableView reloadData];
        [self.refreshControl endRefreshing];
        
    }];
    
}

-(void)viewWillAppear:(BOOL)animated {
    
    [self.tableView reloadData];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"showEntryList"]) {
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Scrapbook *myScrapbook = [ScrapbookController sharedInstance].scrapbooks[indexPath.row];
        
        EntryListViewController *entryListViewController = segue.destinationViewController;
        
        entryListViewController.scrapbook = myScrapbook;
        
        [[EntryController sharedInstance] loadTheseEntriesFromParse:^(NSError *error) {
            [self.tableView reloadData];
            
        }];
        
    }

}

    
    
@end
