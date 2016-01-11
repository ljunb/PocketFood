//
//  LJBMainFood.h
//  PocketFood
//
//  Created by qf on 15/11/17.
//  Copyright © 2015年 qf. All rights reserved.
//  主页广告栏图片模型
/*
 "food_name": "酿豆腐",
 "food_code": "niangdoufu",
 "food_id": 10281,
 "image_url": "http://up.boohee.cn/house/u/food_library/home_cover/30_stuffed_tofu.jpg
 */

#import <Foundation/Foundation.h>

@interface LJBMainFood : NSObject

/**
 *  食物名称
 */
@property (nonatomic, copy) NSString * food_name;

/**
 *  食物编码
 */
@property (nonatomic, copy) NSString * food_code;

/**
 *  食物id
 */
@property (nonatomic, copy) NSString * food_id;

/**
 *  食物图片url
 */
@property (nonatomic, copy) NSString * image_url;

@end
