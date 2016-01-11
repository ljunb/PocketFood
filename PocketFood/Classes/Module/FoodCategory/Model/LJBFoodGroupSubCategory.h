//
//  LJBFoodGroupSubCategory.h
//  PocketFood
//
//  Created by qf on 15/11/21.
//  Copyright © 2015年 qf. All rights reserved.
//  食物二级分类
/**
 *  "id": 13,
 "name": "包装谷薯",
 "image_url": null
 */

#import <Foundation/Foundation.h>

@interface LJBFoodGroupSubCategory : NSObject <MJKeyValue>

@property (nonatomic, copy) NSString * ID;

@property (nonatomic, copy) NSString * name;

@property (nonatomic, copy) NSString * image_url;

@end
