//
//  CustomEntryCell.h
//  Milestons
//
//  Created by Dalton on 5/11/15.
//  Copyright (c) 2015 Dalton. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomEntryCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleOfEntryLabel;
@property (weak, nonatomic) IBOutlet UILabel *timestampLabel;

@end
