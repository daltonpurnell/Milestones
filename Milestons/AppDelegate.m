//
//  AppDelegate.m
//  Milestons
//
//  Created by Dalton on 5/2/15.
//  Copyright (c) 2015 Dalton. All rights reserved.
//

#import "AppDelegate.h"
#import "Appearance.h"
//#import "ScrapbookController.h"
#import "ScrapbookListViewController.h"
//#import "EntryController.h"
//#import "PhotoController.h"

@import Parse;
@import ParseUI;
@import AVFoundation;
@import AudioToolbox;

@interface AppDelegate () <AVAudioPlayerDelegate>
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [Appearance initializeAppearanceDefaults];
    
    // Initialize Parse.
    [Parse setApplicationId:@"ZP4dc4didhOZFuurMoswvziSSuuc1aHByCsZT5MC"
                  clientKey:@"hJsfouL4Wk8drBFrQBHqrnUks83QscDHtl9y26fm"];
    
    [Scrapbook registerSubclass];
    [Entry registerSubclass];
    [Photo registerSubclass];
    
    [PFImageView class];
    
//    [Parse enableLocalDatastore];
    
    // [Optional] Track statistics around application opens.
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
//    [PFUser enableAutomaticUser];
    PFACL *defaultACL = [PFACL ACL];
    [PFACL setDefaultACL:defaultACL withAccessForCurrentUser:YES];
    
// play launch sound
    NSString *pathAndFileName = [[NSBundle mainBundle] pathForResource:@"New Notification 02" ofType:@"wav"];
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

// local notifications
    UILocalNotification *localNotification = [launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
    if (localNotification) {
        application.applicationIconBadgeNumber = 0;
        
    }
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound) categories:nil]];
        
        [application registerForRemoteNotifications];
    }
    
    else {
        
        [application registerForRemoteNotificationTypes:(UIRemoteNotificationType)(UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound)];
        
    }
}


- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    
    UIAlertController *notificationAlert = [UIAlertController alertControllerWithTitle:@"You were notified" message:notification.alertBody preferredStyle:UIAlertControllerStyleAlert];
    
    [notificationAlert addAction:[UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:nil]];
    
    [self.window.rootViewController presentViewController:notificationAlert animated:YES completion:nil];
    
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
