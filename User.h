//
//  User.h
//  Milestons
//
//  Created by Dalton on 5/17/15.
//  Copyright (c) 2015 Dalton. All rights reserved.
//

#import <Foundation/Foundation.h>

@import Parse;

@interface User : PFObject <PFSubclassing>

@property(nonatomic, strong)NSString *userId;
@property(nonatomic, strong)NSString *name;
@property(nonatomic, strong)NSString *email;


+ (NSString *)parseClassName;

@end
