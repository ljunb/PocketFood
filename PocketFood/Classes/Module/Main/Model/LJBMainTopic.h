//
//  LJBMainTopic.h
//  PocketFood
//
//  Created by qf on 15/11/17.
//  Copyright © 2015年 qf. All rights reserved.
//  首页专题
/**
 "id": 44,
 "title": "暖心西式浓汤",
 "sub_title": "一盅浓汤慰己，怎畏秋意渐深",
 "page_count": 6,
 "image_url": "http://up.boohee.cn/house/u/food_library/topic_cover/vol_40_v2.png",
 "big_image_url": "http://up.boohee.cn/house/u/food_library/topic_cover/vol_40_fullscreen_v2.jpg"
 */

#import <Foundation/Foundation.h>

@interface LJBMainTopic : NSObject <MJKeyValue>

/**
 *  菜式id
 */
@property (nonatomic, copy) NSString * topic_id;

/**
 *  菜式名称
 */
@property (nonatomic, copy) NSString * title;

/**
 *  菜式描述
 */
@property (nonatomic, copy) NSString * sub_title;

/**
 *  页数
 */
@property (nonatomic, copy) NSString * page_count;

/**
 *  图片URL
 */
@property (nonatomic, copy) NSString * image_url;

/**
 *  图片URL（满屏）
 */
@property (nonatomic, copy) NSString * big_image_url;

@end
