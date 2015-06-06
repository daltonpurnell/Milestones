 //
//  ScrapbookController.m
//  Milestons
//
//  Created by Dalton on 5/2/15.
//  Copyright (c) 2015 Dalton. All rights reserved.
//

#import "ScrapbookController.h"
#import "Scrapbook.h"

@interface ScrapbookController()

@property (nonatomic, strong) NSArray *scrapbooks;

@end

@implementation ScrapbookController

+ (ScrapbookController *) sharedInstance {
    static ScrapbookController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [ScrapbookController new];
        [sharedInstance loadScrapbooksFromParse:^(NSError *error) {
            // Nothing
        
            if (error) {
                NSLog(@"Error: %@", error);
            }
        }];
    });
    return sharedInstance;
}

#pragma mark - Create

- (Scrapbook *)createScrapbookWithTitle: (NSString *) title date:(NSDate *)timestamp photo:(UIImage *)image {
    
    Scrapbook *scrapbook = [Scrapbook object];
    
    scrapbook.titleOfScrapbook = title;
    scrapbook.timestamp = timestamp;

    //setup scrapbook image
    if (image) {
        PFFile *imageFile = [PFFile fileWithData:UIImageJPEGRepresentation(image,0.95)];
        scrapbook.photo = imageFile;
    }
    
    //setup scrapbook user:
    PFUser *user = [PFUser currentUser];
    scrapbook.user = user;
    scrapbook.ACL = [PFACL ACLWithUser:user];

    [scrapbook saveInBackground];
    
    NSMutableArray *mutableScrapbooks = [NSMutableArray arrayWithArray:self.scrapbooks];
    [mutableScrapbooks insertObject:scrapbook atIndex:0];
    self.scrapbooks = mutableScrapbooks;

    return scrapbook;
}


#pragma mark - Read

- (void)loadScrapbooksFromParse:(void (^)(NSError *error))completion {
    
    PFQuery *query = [Scrapbook query];
    
    PFUser *user = [PFUser currentUser];
    
    if (user) {
//        [query whereKey:@"user" equalTo:user];
        [query includeKey:@"entries"];
        
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
            if (!error) {
                self.scrapbooks = objects;
                completion(nil);
            } else {
                completion(error);
            }
        }];
    } else {
        NSLog(@"No user logged in");
    }
    
}


#pragma mark - Update

- (void)updateScrapbook:(Scrapbook *)scrapbook {
    
//    [scrapbook pinInBackground];
    [scrapbook saveInBackground];
    
}

- (void)addContributor:(PFUser *)addedContributor toScrapbook:(Scrapbook *)scrapbook {
    PFACL *currentACL = scrapbook.ACL;
    [currentACL setReadAccess:YES forUser:addedContributor];
    [currentACL setWriteAccess:YES forUser:addedContributor];
    scrapbook.ACL = currentACL;
    
    // Get all the entries for the scrapbook and update their ACLs to match the scrapbook ACL
//    for (Entry *entry in scrapbook.entries) {
//        entry.ACL = scrapbook.ACL;
//    }

}

#pragma mark - Delete

- (void)removeScrapbook:(Scrapbook *)scrapbook {
    NSMutableArray *mutableScrapbooks = [NSMutableArray arrayWithArray:self.scrapbooks];
    [mutableScrapbooks removeObject:scrapbook];
    self.scrapbooks = mutableScrapbooks;
//    [scrapbook unpinInBackground];
    [scrapbook deleteInBackground];
}


@end
