//
//  AddEntryViewController.h
//  
//
//  Created by Dalton on 5/2/15.
//
//

#import <UIKit/UIKit.h>
#import "Entry.h"

@interface AddEntryViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (strong, nonatomic) Entry *entry;

//-(void)updateWithEntry:(Entry *)entry;

@end
