//
//  EntryListViewController.h
//  Milestons
//
//  Created by Dalton on 5/2/15.
//  Copyright (c) 2015 Dalton. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Entry.h"

@import iAd;
static NSString *const entryCellDeletedNotificationKey = @"cell deleted";
static NSString *const entryCameraButtonTappedNotificationKey = @"camera button tapped";
static NSString * const entryImagePickedKey = @"image picked";


@interface EntryListViewController : UITableViewController
//<ADBannerViewDelegate> {
//    ADBannerView *adView;
//}

@property (strong, nonatomic) Entry *entry;
@property (strong, nonatomic) Scrapbook *scrapbook;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addContributorsButton;

@property (nonatomic, strong) NSArray *entries;

//@property (strong, nonatomic)IBOutlet ADBannerView *adView;


- (void)updateWithSB:(Scrapbook *)scrapbook;


@end
