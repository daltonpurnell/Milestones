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


@import Parse;
@import ParseUI;



@interface ScrapbookListViewController () <UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ScrapbookListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [Appearance initializeAppearanceDefaults];
    

}

-(void)viewWillAppear:(BOOL)animated {
    
    [self.tableView reloadData];
}


// Kind of confused on how this works, since i'm segueing from the scrapbook list to the list of entries that belongs to a particular scrapbook
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"showEntryList"]) {
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        EntryListViewController *entryListViewController = segue.destinationViewController;
        
        Scrapbook *scrapbook = [ScrapbookController sharedInstance].scrapbooks[indexPath.row];
        
//        entryListViewController.entry = entry;
        
        [[EntryController sharedInstance]loadTheseEntriesFromParse];
        
    }
}

@end
