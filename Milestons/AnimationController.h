//
//  AnimationController.h
//  Milestons
//
//  Created by Dalton on 6/6/15.
//  Copyright (c) 2015 Dalton. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;


@protocol AnimationController <UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) NSTimeInterval presentationDuration;

@property (nonatomic, assign) NSTimeInterval dismissalDuration;

@property (nonatomic, assign) BOOL isPresenting;

@end

@interface AnimationController : NSObject


@end
