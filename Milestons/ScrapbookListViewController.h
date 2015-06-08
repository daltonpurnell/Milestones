//
//  ScrapbookListViewController.h
//  Milestons
//
//  Created by Dalton on 5/2/15.
//  Copyright (c) 2015 Dalton. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Scrapbook.h"
@import iAd;
static NSString *const cellDeletedNotificationKey = @"cell deleted";


@interface ScrapbookListViewController : UITableViewController < ADBannerViewDelegate> {
    ADBannerView *adView;
}

@property (weak, nonatomic) IBOutlet UIBarButtonItem *addScrapbookButton;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *options;

@property (strong, nonatomic) Scrapbook *scrapbook;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *settingsButton;

@property (retain, nonatomic)IBOutlet ADBannerView *adView;

@end
