//
//  LJBFoodGroupCategory.h
//  PocketFood
//
//  Created by qf on 15/11/21.
//  Copyright © 2015年 qf. All rights reserved.
//  食物分类模型
/**
 *  "id": 2,
 "name": "肉蛋类",
 "image_url": "http://up.boohee.cn/house/u/food_library/category/2.png",
 "sub_category_count": 3,
 "sub_categories": [
 {},
 {},
 {}
 ],
 "description": null
 */

#import <Foundation/Foundation.h>

@interface LJBFoodGroupCategory : NSObject <MJKeyValue>

@property (nonatomic, copy) NSString * ID;

@property (nonatomic, copy) NSString * name;

@property (nonatomic, copy) NSString * image_url;

@property (nonatomic, strong) NSArray * sub_categories;

@property (nonatomic, copy) NSString * Description;



@end
