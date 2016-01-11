//
//  LJBTopicPage.h
//  PocketFood
//
//  Created by qf on 15/11/18.
//  Copyright © 2015年 qf. All rights reserved.
//
/**
 "food_name": "都叫月饼，大有不同",
 "food_code": "kafeibingpiyuebing",
 "food_id": 90626,
 "description": "中秋无论怎么过，总归都是月饼是个主角之一。如今月饼五花八门，不仅有各种不同口味，还能满足健康低脂的需求。
 
 传统的莲蓉、豆沙、五仁…创新的水果、冰皮、冰淇淋…云南的鲜花、火腿…无一不挑逗着吃货们的味蕾。小编最喜欢的是水果与抹茶冰皮月饼，相对低脂（吃货的自我安慰而已），你们呢？
 ",
 "image_url": "http://up.boohee.cn/house/u/food_library/topic_image/214_ice_mooncake.jpg",
 "page_url": "http://food.boohee.com/fb/v1/topic_pages/257.html"
 */

#import <Foundation/Foundation.h>

@interface LJBTopicPage : NSObject <MJKeyValue>

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
 *  食物描述
 */
@property (nonatomic, copy) NSString * Description;

/**
 *  食物图片URL
 */
@property (nonatomic, copy) NSString * image_url;

@property (nonatomic, copy) NSString * page_url;

@end
