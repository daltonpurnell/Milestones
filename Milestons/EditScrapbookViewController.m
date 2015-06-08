//
//  EditEntryViewController.m
//  Milestons
//
//  Created by Dalton on 6/8/15.
//  Copyright (c) 2015 Dalton. All rights reserved.
//

#import "EditScrapbookViewController.h"
#import "Appearance.h"
#import "ScrapbookController.h"

@import ParseUI;
@import QuartzCore;
@interface EditScrapbookViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation EditScrapbookViewController
@synthesize adView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    self.titleTextField.delegate = self;
    self.adView.delegate = self;
    
    [Appearance initializeAppearanceDefaults];
    self.view.backgroundColor = [UIColor colorWithRed:233/255.0 green:236/255.0 blue:243/255.0 alpha:1];
    
    
    // create drop shadow for image view
    self.imageView.layer.shadowColor = [UIColor grayColor].CGColor;
    self.imageView.layer.shadowOffset = CGSizeMake(0, 1);
    self.imageView.layer.shadowOpacity = 1;
    self.imageView.layer.shadowRadius = 1.0;
    self.imageView.clipsToBounds = NO;
    
}


-(void)updateWithScrapbook:(Scrapbook *)scrapbook {
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - buttons

- (IBAction)cameraButtonTapped:(id)sender {
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    
    UIAlertController *photoActionSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }];
    
    [photoActionSheet addAction:cancelAction];
    
    UIAlertAction *cameraRollAction = [UIAlertAction actionWithTitle:@"From Library" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        imagePicker.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }];
    
    [photoActionSheet addAction:cameraRollAction];
    
    UIAlertAction *takePictureAction = [UIAlertAction actionWithTitle:@"Take Picture" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        if ([UIImagePickerController isSourceTypeAvailable:
             UIImagePickerControllerSourceTypeCamera] == YES) {
            
            imagePicker.sourceType =  UIImagePickerControllerSourceTypeCamera;
            imagePicker.cameraDevice = UIImagePickerControllerCameraDeviceRear;
            imagePicker.allowsEditing = YES;
            
            [self presentViewController:imagePicker animated:YES completion:nil];
            
        } else {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Camera Not Available on Device" message:@"This device does not have a camera option. Please choose photo from library." preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *dismissAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            }];
            
            [alert addAction:dismissAction];
            
            [self presentViewController:alert animated:YES completion:nil];
        }
    }];
    
    [photoActionSheet addAction:takePictureAction];
    
    [self presentViewController:photoActionSheet animated:YES completion:nil];
}



-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    [picker dismissViewControllerAnimated:YES completion:nil];
    self.imageView.image = image;
}



- (IBAction)deleteButtonTapped:(id)sender {
    [self presentDeleteAlertViewController];
}


- (IBAction)cancelButtonTapped:(id)sender {
    [self presentAlertViewController];
}


- (IBAction)doneButtonTapped:(id)sender {
    
    
    if (self.scrapbook) {
        
        self.scrapbook.titleOfScrapbook = self.titleTextField.text;
        self.scrapbook.timestamp = [NSDate date];
        
        PFFile *imageFile = [PFFile fileWithData:UIImageJPEGRepresentation(self.imageView.image,0.95)];
        
        self.scrapbook.photo = imageFile;
        [[ScrapbookController sharedInstance] updateScrapbook:self.scrapbook];
        
    } else {
        [[ScrapbookController sharedInstance] createScrapbookWithTitle:self.titleTextField.text date:[NSDate date] photo:self.imageView.image];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}




-(void)presentAlertViewController {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Delete Draft" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        
        // write code to delete the draft here
        //        [[ScrapbookController sharedInstance]removeScrapbook:scrapbook];
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Save Draft" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        // write code to save the draft here
        [[ScrapbookController sharedInstance] createScrapbookWithTitle:self.titleTextField.text date:[NSDate date] photo:self.imageView.image];
        
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
    
    [self presentViewController:alertController animated:YES completion:nil];
}




-(void)presentDeleteAlertViewController {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Are you sure you want to delete?" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        
        // write code to delete the draft here
        [[ScrapbookController sharedInstance]removeScrapbook:self.scrapbook];
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
}


#pragma mark - text field delegate method

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.titleTextField resignFirstResponder];
    return YES;
}



#pragma mark - banner view delegate methods

-(void)bannerViewDidLoadAd:(ADBannerView *)banner {
    
    adView.hidden = NO;
    NSLog(@"Banner showing");
}

-(void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error {
    
    adView.hidden = YES;
    NSLog(@"Banner hidden. No ad to show");
}



@end