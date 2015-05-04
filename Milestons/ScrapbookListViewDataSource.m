//
//  ScrapbookListViewDataSource.m
//  Milestons
//
//  Created by Dalton on 5/2/15.
//  Copyright (c) 2015 Dalton. All rights reserved.
//

#import "ScrapbookListViewDataSource.h"
#import "ScrapbookController.h"

@implementation ScrapbookListViewDataSource


#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return [ScrapbookController sharedInstance].scrapbooks.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    

    Scrapbook *scrapbook = [ScrapbookController sharedInstance].scrapbooks[indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"scrapbookCell"];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterShortStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    NSDate *date = scrapbook.timestamp;
    NSString *formattedDate = [formatter stringFromDate:date];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", scrapbook.titleOfScrapbook, formattedDate];
    
    return cell;
}



@end
