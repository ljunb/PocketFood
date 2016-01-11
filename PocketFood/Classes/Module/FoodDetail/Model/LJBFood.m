//
//  LJBFood.m
//  PocketFood
//
//  Created by qf on 15/11/18.
//  Copyright © 2015年 qf. All rights reserved.
//

#import "LJBFood.h"
#import "LJBFoodUnits.h"


@implementation LJBFood

+ (NSDictionary *)objectClassInArray {
    return @{@"units":[LJBFoodUnits class]};
}

+ (NSDictionary *)replacedKeyFromPropertyName {
    return @{@"food_id":@"id"};
}

@end
