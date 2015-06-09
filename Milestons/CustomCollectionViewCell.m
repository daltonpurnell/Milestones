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
#import "CollectionViewDataSource.h"
#import "EXPhotoViewer.h"
#import "EntryListViewController.h"

@import QuartzCore;

@interface CustomCollectionViewCell ()
@end


@implementation CustomCollectionViewCell


-(void)awakeFromNib {
    
    // create drop shadow for image view (this doesn't seem to be working)
    self.imageView.layer.shadowColor = [UIColor grayColor].CGColor;
    self.imageView.layer.shadowOffset = CGSizeMake(0, 1);
    self.imageView.layer.shadowOpacity = 1;
    self.imageView.layer.shadowRadius = 1.0;
    self.imageView.clipsToBounds = NO;
    
    [self registerForNotifications];
    
}

-(void)updateWithPhoto:(Photo *)photo {
    
        self.imageView.file = photo.picture;
        [self.imageView loadInBackground];
}



- (IBAction)imageTapped:(id)sender {
    
    [EXPhotoViewer showImageFrom:self.imageView];
}



#pragma mark - nsnotifications methods

-(void)registerForNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(respondToImagePicked:) name:entryImagePickedKey object:nil];
    
}

-(void)respondToImagePicked:(NSNotification *)notification {
    
    //        self.imageView.image = image;
    NSLog(@"set image view");
}


-(void)unregisterForNotifications {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:entryImagePickedKey object:nil];
}

-(void)dealloc {
    
    [self unregisterForNotifications];
}

@end
