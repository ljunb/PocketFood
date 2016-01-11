//
//  LJBFoodSingleTon.m
//  PocketFood
//
//  Created by qf on 15/11/20.
//  Copyright © 2015年 qf. All rights reserved.
//

#import "LJBFoodSingleTon.h"

@implementation LJBFoodSingleTon

static LJBFoodSingleTon * food = nil;
+ (instancetype)sharedFood {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        food = [[LJBFoodSingleTon alloc] init];
    });
    return food;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    
    if (food == nil) {
        food = [super allocWithZone:zone];
    }
    return food;
}

@end
