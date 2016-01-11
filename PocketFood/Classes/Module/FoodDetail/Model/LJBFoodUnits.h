//
//  LJBFoodUnits.h
//  PocketFood
//
//  Created by qf on 15/11/19.
//  Copyright © 2015年 qf. All rights reserved.
//  食物热量模型
/**
 *  "amount": "1.0",
 "unit": "碗（小）",
 "weight": "200.0",
 "calory": "291.56"
 */

#import <Foundation/Foundation.h>

@interface LJBFoodUnits : NSObject
/**
 *  数量
 */
@property (nonatomic, copy) NSString * amount;

/**
 *  单位
 */
@property (nonatomic, copy) NSString * unit;

/**
 *  重量
 */
@property (nonatomic, copy) NSString * weight;

/**
 *  热量
 */
@property (nonatomic, copy) NSString * calory;

@end
