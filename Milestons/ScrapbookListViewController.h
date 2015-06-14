//
//  ScrapbookListViewController.h
//  Milestons
//
//  Created by Dalton on 5/2/15.
//  Copyright (c) 2015 Dalton. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Scrapbook.h"
#import "Photo.h"
@import iAd;
static NSString *const cellDeletedNotificationKey = @"cell deleted";
static NSString *const cameraButtonTappedNotificationKey = @"camera button tapped";
static NSString * const imagePickedKey = @"image picked";

@interface ScrapbookListViewController : UITableViewController
//< ADBannerViewDelegate> {
//    ADBannerView *adView;
//}

@property (weak, nonatomic) IBOutlet UIBarButtonItem *addScrapbookButton;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *options;

@property (strong, nonatomic) Scrapbook *scrapbook;

@property (strong, nonatomic) Photo *photo;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *settingsButton;

//@property (strong, nonatomic)IBOutlet ADBannerView *adView;

@end
