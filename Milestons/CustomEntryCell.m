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
#import "CollectionViewDataSource.h"
#import "CustomCollectionViewCell.h"

@interface CustomEntryCell () <UICollectionViewDelegate> 

@end

@implementation CustomEntryCell

- (void)awakeFromNib {
    // Initialization code
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self.collectionViewDataSource;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    self.backgroundColor = [UIColor clearColor];
    
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
    
    self.descriptionLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Layer-1.png"]];
    
//    self.collectionViewDataSource = (CollectionViewDataSource *)self.collectionView.dataSource;
    
        [[PhotoController sharedInstance] loadThesePhotosFromParseInEntry:entry completion:^(NSArray *photos, NSError *error) {
            self.collectionViewDataSource.photos = photos;
            [self.collectionView reloadData];
        }];
        

}




#pragma mark - delete cell


- (IBAction)deleteButtonTapped:(id)sender  {
    [self.delegate deleteButtonTapped:self.indexPath];
    
}


@end
