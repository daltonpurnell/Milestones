//
//  EntryListViewDataSource.m
//  Milestons
//
//  Created by Dalton on 5/2/15.
//  Copyright (c) 2015 Dalton. All rights reserved.
//

#import "EntryListViewDataSource.h"
#import "EntryController.h"
#import "CustomEntryCell.h"
#import <QuartzCore/QuartzCore.h>


@implementation EntryListViewDataSource


#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
   return [EntryController sharedInstance].entries.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    Entry *entry = [EntryController sharedInstance].entries[indexPath.row];
    
    CustomEntryCell *customCell = [tableView dequeueReusableCellWithIdentifier:@"entryCell"];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterShortStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    NSDate *date = entry.timestamp;
    NSString *formattedDate = [formatter stringFromDate:date];
    
    customCell.titleOfEntryLabel.text = [NSString stringWithFormat:@"%@", entry.titleOfEntry];
    
    customCell.timestampLabel.text = [NSString stringWithFormat:@"%@", formattedDate];
    
//    customCell.photoImageView.image = [UIImage imageWithData:]
    
    return customCell;
}


-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        Entry *entry = [EntryController sharedInstance].entries[indexPath.row];
        
        [[EntryController sharedInstance] removeEntry:entry];
        
        
        [tableView reloadData];
        
    }
}

#pragma mark - Make image view into a circle

-(void)setRoundedView:(UIImageView *)roundedView toDiameter:(float)newSize;
{
    CGPoint saveCenter = roundedView.center;
    CGRect newFrame = CGRectMake(roundedView.frame.origin.x, roundedView.frame.origin.y, newSize, newSize);
    roundedView.frame = newFrame;
    roundedView.layer.cornerRadius = newSize / 2.0;
    roundedView.center = saveCenter;
}


@end
