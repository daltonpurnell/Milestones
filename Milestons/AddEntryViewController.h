//
//  AddEntryViewController.h
//  
//
//  Created by Dalton on 5/2/15.
//
//

#import <UIKit/UIKit.h>
#import "Entry.h"

@interface AddEntryViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UICollectionViewDelegate>

@property (strong, nonatomic) Entry *entry;
@property (strong, nonatomic) Scrapbook *scrapbook;

@property (strong, nonatomic) NSMutableArray *images;
@property (strong, nonatomic) UIImage *image;


//-(void)updateWithEntry:(Entry *)entry;
- (void)updateWithScrapbook:(Scrapbook *)scrapbook;

@end
