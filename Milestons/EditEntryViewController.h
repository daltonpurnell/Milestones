//
//  EditEntryViewController.h
//  Milestons
//
//  Created by Dalton on 6/8/15.
//  Copyright (c) 2015 Dalton. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Entry.h"

@import iAd;

@interface EditEntryViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UICollectionViewDelegate, ADBannerViewDelegate> {
    ADBannerView *adView;
}

@property (strong, nonatomic) Entry *entry;
@property (strong, nonatomic) Scrapbook *scrapbook;

@property (strong, nonatomic) NSMutableArray *images;
@property (strong, nonatomic) UIImage *image;

@property (copy, nonatomic) void (^didCreateEntry)(Entry *entry);
@property (copy, nonatomic) void (^didCreatePhoto)(Photo *photo);

@property (strong, nonatomic)IBOutlet ADBannerView *adView;


- (void)updateWithScrapbook:(Scrapbook *)scrapbook;

@end
