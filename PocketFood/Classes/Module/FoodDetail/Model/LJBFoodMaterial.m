//
//  LJBFoodMaterial.m
//  PocketFood
//
//  Created by ljunb on 15/11/20.
//  Copyright © 2015年 qf. All rights reserved.
//

#import "LJBFoodMaterial.h"
#import "LJBCookStep.h"
#import "LJBMaterialCondiment.h"

@implementation LJBFoodMaterial

#pragma mark - 数组中的模型类型
+ (NSDictionary *)objectClassInArray {
    return @{@"condiments":[LJBMaterialCondiment class], @"steps":[LJBCookStep class]};
}

#pragma mark - 替代的key
+ (NSDictionary *)replacedKeyFromPropertyName {
    return @{@"food_id":@"id"};
}

@end
