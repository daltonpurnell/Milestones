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


@import QuartzCore;
@interface CustomCollectionViewCell ()
@end


@implementation CustomCollectionViewCell


-(void)awakeFromNib {
    
    
    // create drop shadow for image view
    self.imageView.layer.shadowColor = [UIColor grayColor].CGColor;
    self.imageView.layer.shadowOffset = CGSizeMake(0, 1);
    self.imageView.layer.shadowOpacity = 1;
    self.imageView.layer.shadowRadius = 1.0;
    self.imageView.clipsToBounds = NO;
    
    isFullScreen = false;
    tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgToFullScreen)];
    tap.delegate = self;
}

-(void)updateWithPhoto:(Photo *)photo {
    
        self.imageView.file = photo.picture;
        [self.imageView loadInBackground];
}

#pragma mark - gesture recognizer delegate method

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch;
{
    BOOL shouldReceiveTouch = YES;
    
    if (gestureRecognizer == tap) {
        shouldReceiveTouch = (touch.view == self.imageView);
    }
    return shouldReceiveTouch;
}


-(void)imgToFullScreen{
    if (!isFullScreen) {
        [UIView animateWithDuration:0.5 delay:0 options:0 animations:^{
            //save previous frame
            prevFrame = self.imageView.frame;
            [self.imageView setFrame:[[UIScreen mainScreen] bounds]];
        }completion:^(BOOL finished){
            isFullScreen = true;
        }];
        return;
    } else {
        [UIView animateWithDuration:0.5 delay:0 options:0 animations:^{
            [self.imageView setFrame:prevFrame];
        }completion:^(BOOL finished){
            isFullScreen = false;
        }];
        return;
    }
}

@end
