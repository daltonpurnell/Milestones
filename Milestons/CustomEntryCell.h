//
//  CustomEntryCell.h
//  Milestons
//
//  Created by Dalton on 5/11/15.
//  Copyright (c) 2015 Dalton. All rights reserved.
//

#import <UIKit/UIKit.h>

//#import "EntryController.h"
//#import "PhotoController.h"
#import "CollectionViewDataSource.h"

@import MilestonesKit;

//@import ParseUI;

@protocol deleteCellDelegate;

@interface CustomEntryCell : UITableViewCell
@property (nonatomic, strong) id <deleteCellDelegate>delegate;


@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UILabel *timestampLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) CollectionViewDataSource *collectionViewDataSource;
@property (strong, nonatomic) Entry *entry;

@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property (weak, nonatomic) IBOutlet UIButton *cameraButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;
@property (weak, nonatomic) IBOutlet UIImageView *sideImageView;

@property (strong, nonatomic) NSIndexPath *indexPath;

-(void)updateWithEntry:(Entry *)entry;

@end

@protocol deleteCellDelegate <NSObject>

- (IBAction)deleteButtonTapped:(NSIndexPath *)indexPath;

@end