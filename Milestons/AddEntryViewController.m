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



@import MessageUI;


@interface AddEntryViewController () <UITextFieldDelegate, MFMailComposeViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation AddEntryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.titleTextField.delegate = self;
    
//    [self updateWithEntry:self.entry];
    
    [Appearance initializeAppearanceDefaults];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)updateWithEntry:(Entry *)entry {
    if (!entry) {
        return;
    }
    self.titleTextField.text = entry.titleOfEntry;
    
}

- (IBAction)cameraButtonTapped:(id)sender {
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    
    [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
    
    [imagePicker setDelegate:self];
    
    [self presentViewController:imagePicker animated:YES completion:nil];
    
//    [self presentCameraAlertViewController];
    
}

- (IBAction)videoButtonTapped:(id)sender {
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    
    [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    
    [imagePicker setDelegate:self];
    
    [self presentViewController:imagePicker animated:YES completion:nil];
    
//    [self presentPhotoAlertViewController];
    
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

//- (IBAction)doneButtonTapped:(id)sender {
//    
//    if (self.entry) {
//        
//        self.entry.titleOfEntry = self.titleTextField.text;
//        self.entry.descriptionOfEntry = self.descriptionTextView.text;
//        self.entry.timestamp = [NSDate date];
//        
//        [[EntryController sharedInstance] updateEntry:self.entry];
//        
//    } else {
//        [[EntryController sharedInstance] createEntryWithTitle:self.titleTextField.text description:self.descriptionTextView.text date:[NSDate date] inScrapbook:self.entry.scrapbook];
//    }
//    
//        [self dismissViewControllerAnimated:YES completion:nil];
//}


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
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:nil]];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

//#pragma mark - permission to access photos
//
//- (void) presentPhotoAlertViewController {
//    
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
//    
//    [alertController addAction:[UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:nil]];
//
//    [alertController addAction:[UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//            
//            [self dismissViewControllerAnimated:YES completion:nil];
//    }]];
//    
//    [self presentViewController:alertController animated:YES completion:nil];
//    
//}

//
//#pragma mark - permission to access camera
//
//- (void) presentCameraAlertViewController {
//    
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
//    
//    [alertController addAction:[UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:nil]];
//    
//    [alertController addAction:[UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//        
//        [self dismissViewControllerAnimated:YES completion:nil];
//    }]];
//    
//    [self presentViewController:alertController animated:YES completion:nil];
//    
//}


#pragma mark - text field delegate method

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [self.titleTextField resignFirstResponder];
    
    return YES;
    
}


@end
