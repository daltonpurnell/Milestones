//
//  PhotoController.m
//  Milestons
//
//  Created by Dalton on 5/2/15.
//  Copyright (c) 2015 Dalton. All rights reserved.
//

#import "PhotoController.h"
#import "Photo.h"
#import "Entry.h"

@interface PhotoController()

@property (nonatomic, strong) NSArray *photos;

@end


@implementation PhotoController

+ (PhotoController *)sharedInstance {
    static PhotoController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[PhotoController alloc] init];
        [sharedInstance loadThesePhotosFromParse:^(NSError *error) {
            // Nothing
        }];
    });
    return sharedInstance;
}

#pragma mark - Create

- (void)createPhoto:(UIImage *)myPhoto inEntry:(Entry *)entry {
    
    Photo *photo = [Photo object];
    
    PFFile *imageFile = [PFFile fileWithData:UIImageJPEGRepresentation(myPhoto,0.95)];
    
    [imageFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            if (succeeded) {
                photo[@"picture"] = myPhoto;
                photo[@"entry"] = entry;

                PFUser *user = [PFUser currentUser];
                photo.user = user;
                photo.ACL = [PFACL ACLWithUser:user];

                [photo saveInBackground];

            }else {
                NSLog(@"%@",error);
            }
        }
    }];
    
    NSMutableArray *mutablePhotos = [NSMutableArray arrayWithArray:self.photos];
    [mutablePhotos insertObject:photo atIndex:0];
    self.photos = mutablePhotos;
}


#pragma mark - Read


- (void)loadThesePhotosFromParse:(void (^)(NSError *error))completion {
    
    NSLog(@"Loading photos from Parse");
    PFQuery *query = [PFQuery queryWithClassName:@"Photo"];
    
    PFUser *user = [PFUser currentUser];
    [query whereKey:@"user" equalTo:user];
    
//    [query fromLocalDatastore];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
        if (!error) {
            self.photos = objects;
            completion(nil);
        } else {
            completion(error);
        }
    }];
    
}


#pragma mark - Update

- (void)updatePhoto:(Photo *)photo {
    
//    [photo pinInBackground];
    [photo saveInBackground];
    
}

#pragma mark - Delete

- (void)removePhoto:(Photo *)photo {
    
    NSMutableArray *mutablePhotos = [NSMutableArray arrayWithArray:self.photos];
    [mutablePhotos removeObject:photo];
    self.photos = mutablePhotos;
    
//    [photo unpinInBackground];
    [photo deleteInBackground];
}


@end
