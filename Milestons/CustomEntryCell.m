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
@import QuartzCore;

@interface CustomEntryCell () <UICollectionViewDelegate> 
@property (weak, nonatomic) IBOutlet UIImageView *backImageView;

@end

@implementation CustomEntryCell

- (void)awakeFromNib {
    // Initialization code
    self.collectionView.delegate = self;
    self.collectionViewDataSource = (CollectionViewDataSource *)self.collectionView.dataSource;

    // round corners on back image view
    self.backImageView.clipsToBounds = YES;
    self.backImageView.layer.cornerRadius = 5/2.0f;
    
    
    // create drop shadow for description label
    self.descriptionLabel.layer.shadowColor = [UIColor grayColor].CGColor;
    self.descriptionLabel.layer.shadowOffset = CGSizeMake(0, 1);
    self.descriptionLabel.layer.shadowOpacity = 1;
    self.descriptionLabel.layer.shadowRadius = 1.0;
    self.descriptionLabel.clipsToBounds = NO;
    
    self.backImageView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"giftlyBackground.png"]];
    
    // create drop shadow for background image view
    self.backImageView.layer.shadowColor = [UIColor grayColor].CGColor;
    self.backImageView.layer.shadowOffset = CGSizeMake(0, 1);
    self.backImageView.layer.shadowOpacity = 1;
    self.backImageView.layer.shadowRadius = 1.0;
    self.backImageView.clipsToBounds = NO;
    
    // round corners on background image view
//    self.backImageView.clipsToBounds = YES;
//    self.backImageView.layer.cornerRadius = 5/2.0f;
    
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
    
    
        [[PhotoController sharedInstance] loadThesePhotosFromParseInEntry:entry completion:^(NSArray *photos, NSError *error) {
            self.collectionViewDataSource.photos = photos;
            NSLog(@"%lu", photos.count);
            [self.collectionView reloadData];
        }];
        

}




#pragma mark - delete cell


- (IBAction)deleteButtonTapped:(id)sender  {
    [self.delegate deleteButtonTapped:self.indexPath];
}


#pragma mark - cell animation

-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 1
    UICollectionViewLayoutAttributes *attributes = [self.collectionView layoutAttributesForItemAtIndexPath:indexPath];

    CGRect originalCellFrame = attributes.frame;
    
    // 2
    cell.frame = CGRectMake(self.collectionView.frame.size.width + originalCellFrame.size.width,
                            originalCellFrame.origin.y,
                            originalCellFrame.size.width,
                            originalCellFrame.size.height);
    // 3
    [UIView animateWithDuration:0.75
                          delay:0.85
         usingSpringWithDamping:0.8
          initialSpringVelocity:2.0
                        options: UIViewAnimationOptionCurveLinear
     // 4
                     animations:^{
                         cell.frame = originalCellFrame;
                     }
                     completion:^(BOOL finished){
                     }];
    
}


@end
