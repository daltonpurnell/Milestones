//
//  EntryListViewController.h
//  Milestons
//
//  Created by Dalton on 5/2/15.
//  Copyright (c) 2015 Dalton. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Entry.h"
#import "Appearance.h"
#import "EntryController.h"
#import "AddEntryViewController.h"
#import "AddScrapbookViewController.h"
#import "CustomEntryCell.h"
#import "PhotoController.h"
#import "EntryListViewDataSource.h"
#import "CustomCollectionViewCell.h"
#import "UserController.h"
#import "ScrapbookController.h"

@import Parse;
@import ParseUI;
@import AddressBookUI;
@import MessageUI;
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

@property (nonatomic, strong) NSArray *entries;

//@property (strong, nonatomic)IBOutlet ADBannerView *adView;


- (void)updateWithSB:(Scrapbook *)scrapbook;


@end
