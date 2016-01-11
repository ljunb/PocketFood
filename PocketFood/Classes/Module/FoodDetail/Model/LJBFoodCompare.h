//
//  LJBFoodCompare.h
//  PocketFood
//
//  Created by qf on 15/11/19.
//  Copyright © 2015年 qf. All rights reserved.
//
/**
 *  "unit1": "杯",
 "target_name": "牛奶",
 "target_image_url": "http://up.boohee.cn/house/u/food_library/compare/milk.png",
 "amount0": "1",
 "unit0": "杯",
 "amount1": "1.1"
 */

#import <Foundation/Foundation.h>

@interface LJBFoodCompare : NSObject

@property (nonatomic, copy) NSString * amount0;

@property (nonatomic, copy) NSString * unit0;

@property (nonatomic, copy) NSString * amount1;

@property (nonatomic, copy) NSString * unit1;

@property (nonatomic, copy) NSString * target_image_url;

@property (nonatomic, copy) NSString * target_name;

@end
