//
//  CustomEntryCell.m
//  Milestons
//
//  Created by Dalton on 5/11/15.
//  Copyright (c) 2015 Dalton. All rights reserved.
//

#import "CustomEntryCell.h"
#import "EntryController.h"
#import "ScrapbookController.h"
#import "Entry.h"
#import "PhotoController.h"

@implementation CustomEntryCell

- (void)awakeFromNib {
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    self.backgroundColor = [UIColor clearColor];


    // set number of image views to number of photos added
    
    for (int index = 0; index < [PhotoController sharedInstance].photos.count; index++) {
    
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%d", index + 1]];
    
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    
        imageView.frame = CGRectMake(index * self.contentView.bounds.size.width + 20, 20, self.scrollView.bounds.size.width - 40, self.contentView.bounds.size.height - 40);
        imageView.contentMode = UIViewContentModeScaleAspectFit;
    
        [self.scrollView addSubview:imageView];
    }
    
}

-(void)updateWithEntry:(Entry *)entry {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterShortStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    NSDate *date = entry.timestamp;
    NSString *formattedDate = [formatter stringFromDate:date];
    
    self.titleOfEntryLabel.text = [NSString stringWithFormat:@"%@", entry.titleOfEntry];
    
    self.timestampLabel.text = [NSString stringWithFormat:@"%@", formattedDate];
    
    self.descriptionLabel.text = [NSString stringWithFormat:@"%@", entry.descriptionOfEntry];
    
//    self.photoImageView.image = [UIImage imageWithData:entry.photos.getData];
    
//    self.photoImageView.file = 
    
//    [self.photoImageView loadInBackground];

    
}




#pragma mark - delete cell


- (IBAction)deleteButtonTapped:(id)sender  {
    [self.delegate deleteButtonTapped:self.indexPath];
    
}


@end
