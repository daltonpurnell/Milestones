//
//  CustomCollectionViewCell.m
//  Milestons
//
//  Created by Dalton on 5/30/15.
//  Copyright (c) 2015 Dalton. All rights reserved.
//

#import "CustomCollectionViewCell.h"
#import "PhotoController.h"
#import "EntryController.h"

@implementation CustomCollectionViewCell

-(void)updateWithPhoto:(Photo *)photo {
    self.imageView.file = photo.picture;

}

@end
