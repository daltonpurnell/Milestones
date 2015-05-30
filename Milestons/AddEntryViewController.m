//
//  AddEntryViewController.m
//  
//
//  Created by Dalton on 5/2/15.
//
//

#import "AddEntryViewController.h"
#import "Appearance.h"
#import "EntryController.h"
#import "Entry.h"
#import "PhotoController.h"



@import MessageUI;


@interface AddEntryViewController () <UITextFieldDelegate, MFMailComposeViewControllerDelegate, UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;


@end

@implementation AddEntryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleTextField.delegate = self;
    self.descriptionTextView.delegate = self;
    [Appearance initializeAppearanceDefaults];
    
    
     // set number of image views to number of photos added

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



- (IBAction)videoButtonTapped:(id)sender {
    
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
    
    UIAlertAction *takePictureAction = [UIAlertAction actionWithTitle:@"Record Video" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        if ([UIImagePickerController isSourceTypeAvailable:
             UIImagePickerControllerSourceTypeCamera] == YES) {
            
            imagePicker.sourceType =  UIImagePickerControllerSourceTypeCamera;
            imagePicker.cameraDevice = UIImagePickerControllerCameraDeviceRear;
            imagePicker.allowsEditing = YES;
            
            [self presentViewController:imagePicker animated:YES completion:nil];
            
        } else {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Camera Not Available on Device" message:@"This device does not have a camera option. Please choose video from library." preferredStyle:UIAlertControllerStyleAlert];
            
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
    
//    UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    // Set Image
//    self.imageView.image = image;

    // collection view
    
    [picker dismissViewControllerAnimated:YES completion:nil];

}



- (IBAction)shareButtonTapped:(id)sender {
    
    MFMailComposeViewController *mailViewController = [MFMailComposeViewController new];
    mailViewController.mailComposeDelegate = self;
    
    [mailViewController setSubject:[NSString stringWithFormat:@"%@", self.entry.titleOfEntry]];
    [mailViewController setMessageBody:[NSString stringWithFormat:@"%@", self.entry.descriptionOfEntry] isHTML:NO];
    [self presentViewController:mailViewController animated:YES completion:nil];
}


- (IBAction)deleteButtonTapped:(id)sender {
    [self presentDeleteAlertViewController];
}

- (IBAction)cancelButtonTapped:(id)sender {
    [self presentAlertViewController];
}


- (IBAction)doneButtonTapped:(id)sender {
    
    if (self.entry) {
        
        self.entry.titleOfEntry = self.titleTextField.text;
        self.entry.descriptionOfEntry = self.descriptionTextView.text;
        self.entry.timestamp = [NSDate date];
        
        [[EntryController sharedInstance] updateEntry:self.entry];
        
    } else {
        [[EntryController sharedInstance] createEntryWithTitle:self.titleTextField.text description:self.descriptionTextView.text date:[NSDate date] inScrapbook:self.scrapbook];
    }
    
    // TODO: Add photos to entry. As photos are selected, save them to an array, then pass in the array of images to the PhotoController and save them to the entry.

    
        [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)updateWithScrapbook:(Scrapbook *)scrapbook {
    if (scrapbook) {
        self.scrapbook = scrapbook;
    }
}



#pragma mark - delete button alert controller

-(void)presentDeleteAlertViewController {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Are you sure you want to delete?" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        
        // write code to delete draft here

        
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
}



#pragma mark - cancel button action sheet alert controller

-(void)presentAlertViewController {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Delete Draft" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        
        // write code to delete the draft here
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Save Draft" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        // write code to save the draft here
        [[EntryController sharedInstance] createEntryWithTitle:self.titleTextField.text description:self.descriptionTextView.text date:[NSDate date] inScrapbook:self.entry.scrapbook];
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
}



#pragma mark - text field delegate method

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.titleTextField resignFirstResponder];
    return YES;
    
}

#pragma mark - text view delegate method

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}

@end
