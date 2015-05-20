//
//  CustomScrapbookCell.m
//  Milestons
//
//  Created by Dalton on 5/11/15.
//  Copyright (c) 2015 Dalton. All rights reserved.
//

#import "CustomScrapbookCell.h"

#import "EntryController.h"

@implementation CustomScrapbookCell

- (void)awakeFromNib {
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)updateWithScrapbook:(Scrapbook *)scrapbook {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterShortStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    NSDate *date = scrapbook.timestamp;
    NSString *formattedDate = [formatter stringFromDate:date];
    
    self.titleOfScrapbookLabel.text = [NSString stringWithFormat:@"%@", scrapbook.titleOfScrapbook];
    self.timestampLabel.text = [NSString stringWithFormat:@"%@", formattedDate];
}

@end
