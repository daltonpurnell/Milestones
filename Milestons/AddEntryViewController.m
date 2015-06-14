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
#import "CollectionViewDataSource.h"
#import "CustomCollectionViewCell2.h"

@import MessageUI;
@import AVFoundation;
@import AudioToolbox;

@interface AddEntryViewController () <UITextFieldDelegate, UITextViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, AVAudioPlayerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic)AVAudioPlayer *audioPlayer;
@end

@implementation AddEntryViewController
@synthesize adView;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.adView.delegate = self;
    self.collectionView.delegate = self;
    
    self.collectionView.dataSource = self;
    self.titleTextField.delegate = self;
    
    self.descriptionTextView.delegate = self;
    [Appearance initializeAppearanceDefaults];
    
    self.images = [NSMutableArray new];
    self.descriptionTextView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Layer-1.png"]];

    requestingAd = NO;
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


//
//- (IBAction)shareButtonTapped:(id)sender {
//    
//    MFMailComposeViewController *mailViewController = [MFMailComposeViewController new];
//    mailViewController.mailComposeDelegate = self;
//    
//    [mailViewController setSubject:[NSString stringWithFormat:@"%@", self.entry.titleOfEntry]];
//    [mailViewController setMessageBody:[NSString stringWithFormat:@"%@", self.entry.descriptionOfEntry] isHTML:NO];
//    [self presentViewController:mailViewController animated:YES completion:nil];
//}


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
        [[EntryController sharedInstance] createEntryWithTitle:self.titleTextField.text description:self.descriptionTextView.text date:[NSDate date] inScrapbook:self.scrapbook completion:^(BOOL succeeded, Entry *entry) {
            if (succeeded) {
                // Save all images to parse
                self.didCreateEntry(entry);
                for (_image in _images) {
                     [[PhotoController sharedInstance]createPhotoWithImage:self.image inEntry:entry completion:^(BOOL succeeded, Photo *photo) {
                         //...
                     }];
                    NSString *pathAndFileName = [[NSBundle mainBundle] pathForResource:@"success" ofType:@"mp3"];
                    if ([[NSFileManager defaultManager] fileExistsAtPath:pathAndFileName])
                    {
                        self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:pathAndFileName] error:NULL];
                        
                        self.audioPlayer.delegate=self;
                        [self.audioPlayer prepareToPlay];
                        [self.audioPlayer play];
                        NSLog(@"File exists in BUNDLE");
                    }
                    else
                    {
                        NSLog(@"File not found");
                    }
                    
                }
                
                
                [self dismissViewControllerAnimated:YES completion:nil];
                
            } else {
                // Display error
            }
        }];
    }
}


- (void)updateWithScrapbook:(Scrapbook *)scrapbook {
    if (scrapbook) {
        self.scrapbook = scrapbook;
    }
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
        [[EntryController sharedInstance] createEntryWithTitle:self.titleTextField.text description:self.descriptionTextView.text date:[NSDate date] inScrapbook:self.entry.scrapbook completion:^(BOOL succeeded, Entry *entry) {
            // success
        }];
        
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

#pragma mark - text view delegate methods with animations


-(void)textViewDidBeginEditing:(UITextView *)textView
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    self.view.frame = CGRectMake(self.view.frame.origin.x, -160, self.view.frame.size.width, self.view.frame.size.height);
    [UIView commitAnimations];
    
}



- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.2];
        
        self.view.frame = CGRectMake(self.view.frame.origin.x, 0, self.view.frame.size.width, self.view.frame.size.height);
        [UIView commitAnimations];
        return NO;
    }
    
    return YES;
}


#pragma mark - Collection view data source methods

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    //create cell...
    CustomCollectionViewCell2 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];

    [cell updateWithImage:self.images[indexPath.row]];
    
    return cell;
    
    
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.images.count;
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


#pragma mark - interstitial delegate methods

////Interstitial iAd
//-(void)showFullScreenAd {
//    //Check if already requesting ad
//    if (requestingAd == NO) {
//        interstitial = [[ADInterstitialAd alloc] init];
//        interstitial.delegate = self;
//        self.interstitialPresentationPolicy = ADInterstitialPresentationPolicyManual;
//        [self requestInterstitialAdPresentation];
//        NSLog(@"interstitialAdREQUEST");
//        requestingAd = YES;
//    }//end if
//}
//
//-(void)interstitialAd:(ADInterstitialAd *)interstitialAd didFailWithError:(NSError *)error {
//    interstitial = nil;
//    requestingAd = NO;
//    NSLog(@"interstitialAd didFailWithERROR");
//    NSLog(@"%@", error);
//}
//
//-(void)interstitialAdDidLoad:(ADInterstitialAd *)interstitialAd {
//    NSLog(@"interstitialAdDidLOAD");
//    if (interstitialAd != nil && interstitial != nil && requestingAd == YES) {
//        [interstitial presentFromViewController:self];
//        NSLog(@"interstitialAdDidPRESENT");
//    }//end if
//}
//
//-(void)interstitialAdDidUnload:(ADInterstitialAd *)interstitialAd {
//    interstitial = nil;
//    requestingAd = NO;
//    NSLog(@"interstitialAdDidUNLOAD");
//}
//
//-(void)interstitialAdActionDidFinish:(ADInterstitialAd *)interstitialAd {
//    interstitial = nil;
//    requestingAd = NO;
//    NSLog(@"interstitialAdDidFINISH");
//}
//


@end
