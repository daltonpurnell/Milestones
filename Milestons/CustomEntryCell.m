//
//  CustomEntryCell.m
//  Milestons
//
//  Created by Dalton on 5/11/15.
//  Copyright (c) 2015 Dalton. All rights reserved.
//

#import "CustomEntryCell.h"
//#import "EntryController.h"
//#import "ScrapbookController.h"
//#import "Entry.h"
//#import "PhotoController.h"
#import "CollectionViewDataSource.h"
#import "CustomCollectionViewCell.h"
#import "EntryListViewController.h"
//@import QuartzCore;

@interface CustomEntryCell () <UICollectionViewDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *backImageView;

@end

@implementation CustomEntryCell

- (void)awakeFromNib {
    // Initialization code
    self.collectionView.delegate = self;
    self.collectionViewDataSource = (CollectionViewDataSource *)self.collectionView.dataSource;
    
    // hide all buttons except edit
    self.doneButton.hidden = YES;
    self.cameraButton.hidden = YES;
    self.deleteButton.hidden = YES;
    self.cancelButton.hidden = YES;
    self.sideImageView.hidden = YES;
    

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
    
    self.titleTextField.text = [NSString stringWithFormat:@"%@", entry.titleOfEntry];
    
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

#pragma mark - Buttons

- (IBAction)editButtonTapped:(id)sender {
    // side image view
    self.sideImageView.hidden = NO;
    
    CGRect originalViewFrame = self.sideImageView.frame;
    self.sideImageView.frame = CGRectMake(self.contentView.frame.size.width + originalViewFrame.size.width,
                                       originalViewFrame.origin.y,
                                       originalViewFrame.size.width,
                                       originalViewFrame.size.height);
    
    [UIView animateWithDuration:0.75
                          delay:0.25
         usingSpringWithDamping:0.8
          initialSpringVelocity:2.0
                        options: UIViewAnimationOptionCurveLinear
     
                     animations:^{
                         self.sideImageView.frame = originalViewFrame;
                     }
                     completion:^(BOOL finished){
                     }];

    
    
    // done button
    self.doneButton.hidden = NO;
    
    CGRect originalButtonFrame = self.doneButton.frame;
    self.doneButton.frame = CGRectMake(self.contentView.frame.size.width + originalButtonFrame.size.width,
                                       originalButtonFrame.origin.y,
                                       originalButtonFrame.size.width,
                                       originalButtonFrame.size.height);
    
    [UIView animateWithDuration:0.75
                          delay:0.25
         usingSpringWithDamping:0.8
          initialSpringVelocity:2.0
                        options: UIViewAnimationOptionCurveLinear
     
                     animations:^{
                         self.doneButton.frame = originalButtonFrame;
                     }
                     completion:^(BOOL finished){
                     }];
    
    // camera button
    self.cameraButton.hidden = NO;
    
    CGRect originalCameraButtonFrame = self.cameraButton.frame;
    self.cameraButton.frame = CGRectMake(self.contentView.frame.size.width + originalCameraButtonFrame.size.width,
                                         originalCameraButtonFrame.origin.y,
                                         originalCameraButtonFrame.size.width,
                                         originalCameraButtonFrame.size.height);
    
    [UIView animateWithDuration:0.75
                          delay:0.45
         usingSpringWithDamping:0.8
          initialSpringVelocity:2.0
                        options: UIViewAnimationOptionCurveLinear
     
                     animations:^{
                         self.cameraButton.frame = originalCameraButtonFrame;
                     }
                     completion:^(BOOL finished){
                     }];
    
    // delete button
    self.deleteButton.hidden = NO;
    
    CGRect originalDeleteButtonFrame = self.deleteButton.frame;
    self.deleteButton.frame = CGRectMake(self.contentView.frame.size.width + originalDeleteButtonFrame.size.width,
                                         originalDeleteButtonFrame.origin.y,
                                         originalDeleteButtonFrame.size.width,
                                         originalDeleteButtonFrame.size.height);
    
    [UIView animateWithDuration:0.75
                          delay:0.55
         usingSpringWithDamping:0.8
          initialSpringVelocity:2.0
                        options: UIViewAnimationOptionCurveLinear
     
                     animations:^{
                         self.deleteButton.frame = originalDeleteButtonFrame;
                     }
                     completion:^(BOOL finished){
                     }];
    // cancel button
    self.cancelButton.hidden = NO;
    
    CGRect originalCancelButtonFrame = self.cancelButton.frame;
    self.cancelButton.frame = CGRectMake(self.contentView.frame.size.width + originalDeleteButtonFrame.size.width,
                                         originalCancelButtonFrame.origin.y,
                                         originalCancelButtonFrame.size.width,
                                         originalCancelButtonFrame.size.height);
    
    [UIView animateWithDuration:0.75
                          delay:0.35
         usingSpringWithDamping:0.8
          initialSpringVelocity:2.0
                        options: UIViewAnimationOptionCurveLinear
     
                     animations:^{
                         self.cancelButton.frame = originalCancelButtonFrame;
                     }
                     completion:^(BOOL finished){
                     }];
    
    
    self.titleTextField.enabled = YES;
    self.titleTextField.delegate = self;

}

- (IBAction)cameraButtonTapped:(id)sender {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:entryCameraButtonTappedNotificationKey object:nil userInfo:nil];
    
}

- (IBAction)cancelButtonTapped:(id)sender {
    
    // side image view animation
    [UIView transitionWithView:self.sideImageView
                      duration:0.4
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:NULL
                    completion:NULL];
    self.sideImageView.hidden = YES;
    
    // done button animation
    [UIView transitionWithView:self.doneButton
                      duration:0.4
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:NULL
                    completion:NULL];
    self.doneButton.hidden = YES;
    
    // camera button animation
    [UIView transitionWithView:self.cameraButton
                      duration:0.4
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:NULL
                    completion:NULL];
    self.cameraButton.hidden = YES;
    
    // delete button animation
    [UIView transitionWithView:self.deleteButton
                      duration:0.4
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:NULL
                    completion:NULL];
    self.deleteButton.hidden = YES;
    
    // cancel button animation
    [UIView transitionWithView:self.cancelButton
                      duration:0.4
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:NULL
                    completion:NULL];
    self.cancelButton.hidden = YES;
    
//    self.titleTextField.enabled = NO;

    
}

- (IBAction)doneButtonTapped:(id)sender {
    
    // side image view animation
    [UIView transitionWithView:self.sideImageView
                      duration:0.4
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:NULL
                    completion:NULL];
    self.sideImageView.hidden = YES;
    
    // done button animation
    [UIView transitionWithView:self.doneButton
                      duration:0.4
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:NULL
                    completion:NULL];
    self.doneButton.hidden = YES;
    
    // camera button animation
    [UIView transitionWithView:self.cameraButton
                      duration:0.4
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:NULL
                    completion:NULL];
    self.cameraButton.hidden = YES;
    
    // delete button animation
    [UIView transitionWithView:self.deleteButton
                      duration:0.4
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:NULL
                    completion:NULL];
    self.deleteButton.hidden = YES;
    
    // cancel button animation
    [UIView transitionWithView:self.cancelButton
                      duration:0.4
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:NULL
                    completion:NULL];
    self.cancelButton.hidden = YES;
    
    self.titleTextField.enabled = NO;
// save changes to parse
// reload tableview
    
}


@end
