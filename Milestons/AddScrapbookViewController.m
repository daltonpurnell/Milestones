//
//  AddScrapbookViewController.m
//  Milestons
//
//  Created by Dalton on 5/2/15.
//  Copyright (c) 2015 Dalton. All rights reserved.
//

#import "AddScrapbookViewController.h"
#import "Appearance.h"
#import "ScrapbookController.h"

@import MessageUI;

@interface AddScrapbookViewController () <UITextFieldDelegate, MFMailComposeViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation AddScrapbookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self updateWithScrapbook:self.scrapbook];
    
    
    self.titleTextField.delegate = self;
    
    [Appearance initializeAppearanceDefaults];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)updateWithScrapbook:(Scrapbook *)scrapbook {
    self.titleTextField.text = scrapbook.titleOfScrapbook;
    
}
- (IBAction)cameraButtonTapped:(id)sender {
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
    }
    else
    {
        [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    }
    
    [imagePicker setDelegate:self];
    
    [self presentViewController:imagePicker animated:YES completion:nil];
    
    }



- (IBAction)videoButtonTapped:(id)sender {
    
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
    }
    else
    {
        [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    }
    
    [imagePicker setDelegate:self];
    
    [self presentViewController:imagePicker animated:YES completion:nil];

}



-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    finalImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    [self.imageView setImage:finalImage];
    
    // UIImageWriteToSavedPhotosAlbum(image, self, nil, nil);
    
    [self dismissViewControllerAnimated:YES completion:nil];

}



- (IBAction)shareButtonTapped:(id)sender {
    
    MFMailComposeViewController *mailViewController = [MFMailComposeViewController new];
    mailViewController.mailComposeDelegate = self;
    
    [mailViewController setSubject:[NSString stringWithFormat:@"%@", self.scrapbook.titleOfScrapbook]];
    
    [self presentViewController:mailViewController animated:YES completion:nil];
    
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
        
        [[ScrapbookController sharedInstance] updateScrapbook:self.scrapbook];
        
    } else {
        [[ScrapbookController sharedInstance] createScrapbookWithTitle:self.titleTextField.text date:[NSDate date]];
    }
    
        [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)presentAlertViewController {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Delete Draft" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        
        // write code to delete the draft here
//        [[ScrapbookController sharedInstance]deleteScrapbook:scrapbook];
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Save Draft" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        // write code to save the draft here
        
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:nil]];
    
    [self presentViewController:alertController animated:YES completion:nil];
}


-(void)presentDeleteAlertViewController {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Are you sure you want to delete?" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        
        // write code to delete the draft here
        
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

//-(void)textFieldDidEndEditing:(UITextField *)textField {
//    self.scrapbook = [[ScrapbookController sharedInstance] createScrapbookWithTitle:self.titleTextField.text];
//}


@end
