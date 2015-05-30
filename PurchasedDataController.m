//
//  PurchasedDataController.m
//  SimpleStore
//
//  Created by Caleb Hicks on 3/17/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "PurchasedDataController.h"
#import "StorePurchaseController.h"


static NSString * const unlockContributorsKey = @"contributorsUnlocked";
static NSString * const adsRemovedKey = @"adsRemoved";


@interface PurchasedDataController ()


@property (assign, nonatomic) BOOL unlockContributors;
@property (assign, nonatomic) BOOL adsRemoved;


@end

@implementation PurchasedDataController

+ (PurchasedDataController *)sharedInstance {
    static PurchasedDataController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [PurchasedDataController new];
        [sharedInstance registerForNotifications];
        [sharedInstance loadFromDefaults];
    });
    return sharedInstance;
}

- (void)registerForNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(purchaseNotification:) name:kInAppPurchaseCompletedNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(purchaseNotification:) name:kInAppPurchaseRestoredNotification object:nil];
}

#pragma mark - Properties to/from NSUserDefaults

- (void)loadFromDefaults {
        
    self.unlockContributors = [[NSUserDefaults standardUserDefaults] integerForKey:unlockContributorsKey];
    NSLog(@"%d", self.unlockContributors);
    
    if (!self.unlockContributors) {
        self.unlockContributors = 0;
    }
    
}

- (void)setUnlockContributors:(BOOL)unlockContributors {
    _unlockContributors = unlockContributors;
    
    [[NSUserDefaults standardUserDefaults] setInteger:unlockContributors forKey:unlockContributorsKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    NSLog(@"%d", self.unlockContributors);
}

//
//- (void)setAdsRemoved:(BOOL)adsRemoved {
//    _adsRemoved = adsRemoved;
//    
//    [[NSUserDefaults standardUserDefaults] setBool:adsRemoved forKey:kAdsRemovedKey];
//    [[NSUserDefaults standardUserDefaults] synchronize];

//    NSLog(@"%d", self.adsRemoved);
//}

#pragma mark - Handle Purchase Notification

- (void)purchaseNotification:(NSNotification *)notification {
    
    NSString *productIdentifer = notification.userInfo[kProductIDKey];
//    
//    if ([productIdentifer isEqualToString:@"com.devmtn.SimpleStore.removeads"]) {
//        self.adsRemoved = YES;
//    }
    
    if ([productIdentifer isEqualToString:@ "com.dalton.Milestones.UnlockEverything"]) {
        NSLog(@"%d", self.unlockContributors);
        self.unlockContributors = YES;
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kPurchasedContentUpdated object:nil userInfo:nil];
    
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
