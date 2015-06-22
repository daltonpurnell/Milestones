//
//  CustomScrapbookCell.m
//  Milestons
//
//  Created by Dalton on 5/11/15.
//  Copyright (c) 2015 Dalton. All rights reserved.
//

#import "CustomScrapbookCell.h"
#import "EntryController.h"
#import "ScrapbookController.h"
#import "ScrapbookListViewController.h"
@import QuartzCore;

@interface CustomScrapbookCell () <UITextFieldDelegate>

@end

@implementation CustomScrapbookCell

- (void)awakeFromNib {
    
    self.backgroundColor = [UIColor clearColor];
    self.backImageView.backgroundColor = [UIColor whiteColor];
    self.contributorsLabel.hidden = YES;
    
// hide all buttons except edit
    self.doneButton.hidden = YES;
    self.cameraButton.hidden = YES;
    self.deleteButton.hidden = YES;
    self.cancelButton.hidden = YES;
    
    // set text field to non editable
    self.titleTextField.enabled = NO;
    self.titleTextField.textColor = [UIColor darkGrayColor];
    
   // round corners on back image view
    self.backImageView.clipsToBounds = YES;
    self.backImageView.layer.cornerRadius = 5/2.0f;
    
    // create drop shadow for back image view
    self.backImageView.layer.shadowColor = [UIColor grayColor].CGColor;
    self.backImageView.layer.shadowOffset = CGSizeMake(0, 1);
    self.backImageView.layer.shadowOpacity = 1;
    self.backImageView.layer.shadowRadius = 1.0;
    self.backImageView.clipsToBounds = NO;
    
    // create drop shadow for image view
    self.photoImageView.layer.shadowColor = [UIColor grayColor].CGColor;
    self.photoImageView.layer.shadowOffset = CGSizeMake(0, 1);
    self.photoImageView.layer.shadowOpacity = 1;
    self.photoImageView.layer.shadowRadius = 1.0;
    self.photoImageView.clipsToBounds = NO;
    
    [self registerForNotifications];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

-(void)updateWithScrapbook:(Scrapbook *)scrapbook {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterShortStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    NSDate *date = scrapbook.timestamp;
    NSString *formattedDate = [formatter stringFromDate:date];
    
    self.titleTextField.text = [NSString stringWithFormat:@"%@", scrapbook.titleOfScrapbook];
    self.timestampLabel.text = [NSString stringWithFormat:@"%@", formattedDate];
    self.contributorsLabel.text = [NSString stringWithFormat:@"%lu Contributors", (unsigned long)scrapbook.contributors.count];
    
    self.photoImageView.file = scrapbook.photo;
    
    [self.photoImageView loadInBackground];

}

#pragma mark - buttons

- (IBAction)deleteButtonTapped:(id)sender  {
    [self.delegate deleteButtonTapped:self.indexPath];

}


- (IBAction)editButtonTapped:(id)sender {
    
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
                          delay:0.35
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
                          delay:0.45
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
    self.cancelButton.frame = CGRectMake(0 - originalCancelButtonFrame.size.width,
                                         originalCancelButtonFrame.origin.y,
                                         originalCancelButtonFrame.size.width,
                                         originalCancelButtonFrame.size.height);
    
    [UIView animateWithDuration:0.75
                          delay:0.25
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
    
    [[NSNotificationCenter defaultCenter] postNotificationName:cameraButtonTappedNotificationKey object:nil userInfo:nil];

}


- (IBAction)doneButtonTapped:(id)sender {
    
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
    self.scrapbook.titleOfScrapbook = self.titleTextField.text;
    self.scrapbook.timestamp = [NSDate date];
    
    PFFile *imageFile = [PFFile fileWithData:UIImageJPEGRepresentation(self.imageView.image,0.95)];
    
    self.scrapbook.photo = imageFile;
    [[ScrapbookController sharedInstance] updateScrapbook:self.scrapbook];
    
    
    // reload tableview
    
}

- (IBAction)cancelButtonTapped:(id)sender {
    
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
}


#pragma mark - nsnotifications methods

-(void)registerForNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(respondToImagePicked:) name:imagePickedKey object:nil];
    
}

-(void)respondToImagePicked:(NSNotification *)notification {

    self.photoImageView.file = self.scrapbook.photo;
    
    [self.photoImageView loadInBackground];
    NSLog(@"set image view");
}


-(void)unregisterForNotifications {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:imagePickedKey object:nil];
}

-(void)dealloc {
    
    [self unregisterForNotifications];
}

#pragma mark - text field delegate method

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.titleTextField resignFirstResponder];
    return YES;
}




@end
