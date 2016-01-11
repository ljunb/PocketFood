//
//  LJBFoodGroupCategory.m
//  PocketFood
//
//  Created by qf on 15/11/21.
//  Copyright © 2015年 qf. All rights reserved.
//

#import "LJBFoodGroupCategory.h"
#import "LJBFoodGroupSubCategory.h"

@implementation LJBFoodGroupCategory

+ (NSDictionary *)objectClassInArray {
    
    return @{@"sub_categories":[LJBFoodGroupSubCategory class]};
}

+ (NSDictionary *)replacedKeyFromPropertyName {
    return @{@"ID":@"id", @"Description":@"description"};
}

@end
