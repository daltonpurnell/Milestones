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

@end

@implementation EntryListViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [Appearance initializeAppearanceDefaults];
    
    
    // Not sure if this is the right code to load the entries belonging to the specific scrapbook
    [[EntryController sharedInstance]loadTheseEntriesFromParse];
    
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
