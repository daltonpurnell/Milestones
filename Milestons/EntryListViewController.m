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
#import "CustomEntryCell.h"
#import "PhotoController.h"
#import "EntryListViewDataSource.h"


@import Parse;
@import ParseUI;


@interface EntryListViewController () <UITableViewDelegate, deleteCellDelegate>
@property (weak, nonatomic) IBOutlet UINavigationItem *navBar;
@property (nonatomic, strong) EntryListViewDataSource *tableDataSource;

@end

@implementation EntryListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableDataSource = (EntryListViewDataSource *)self.tableView.dataSource;
    if (self.scrapbook) {
        self.tableDataSource.scrapbook = self.scrapbook;
    }
    
    self.navigationController.toolbarHidden = YES;
    
    self.navBar.title = [NSString stringWithFormat:@"%@", self.scrapbook.titleOfScrapbook];

    [Appearance initializeAppearanceDefaults];
// self.view.backgroundColor = [UIColor colorWithRed:232/255 green:236/255 blue:243/255 alpha:1];
    
    self.tableView.rowHeight = 350;
    
    self.refreshControl = [UIRefreshControl new];
    [self.refreshControl addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];
    
    [[EntryController sharedInstance]loadTheseEntriesFromParse:^(NSError *error) {
        [self.tableView reloadData];
        
    }];
    
    [[PhotoController sharedInstance]loadThesePhotosFromParse:^(NSError *error) {
        [self.tableView reloadData];
        
    }];

}

- (void)updateWithSB:(Scrapbook *)scrapbook {
    self.scrapbook = scrapbook;
    
}

-(void)refreshTable {
    
    [self.refreshControl beginRefreshing];
    
    [[EntryController sharedInstance]loadTheseEntriesFromParse:^(NSError *error) {
        [self.tableView reloadData];
        [self.refreshControl endRefreshing];
        
    }];
    
    [[PhotoController sharedInstance]loadThesePhotosFromParse:^(NSError *error) {
        [self.tableView reloadData];
        [self.refreshControl endRefreshing];
    }];
    
}


-(void)viewWillAppear:(BOOL)animated {
    
    [self.tableView reloadData];
}

#pragma mark - log out

- (IBAction)logOutButtonTapped:(id)sender {
    
    [PFUser logOut];
    
}



#pragma mark - deleteCellDelegate method

- (void)deleteButtonTapped:(NSIndexPath *)indexPath {

    //    [self.tableView reloadData];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"presentAddEntry"]) {
        UINavigationController *navController = [segue destinationViewController];
        AddEntryViewController *addEntryViewController = navController.viewControllers.firstObject;
        [addEntryViewController updateWithScrapbook:self.scrapbook];
    }

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
