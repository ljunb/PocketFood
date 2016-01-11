//
//  LJBFood.h
//  PocketFood
//
//  Created by qf on 15/11/18.
//  Copyright © 2015年 qf. All rights reserved.
//  食物详情
/**
 *  "id": 17074,
 "code": "congyouyunai_",
 "name": "葱油芋艿",
 "calory": "88",
 "weight": "100",
 "health_light": 1,
 "is_liquid": false,
 "thumb_image_url": "http://s.boohee.cn/house/upload_food/2008/7/26/107147_1217046093mid.jpg",
 "large_image_url": "http://s.boohee.cn/house/upload_food/2008/7/26/107147_1217046093.jpg",
 "uploader": "",
 "appraise": "烩
 烩制菜肴常带有浓汤，而汤汁中混有较多的油脂和盐分，减肥时应避免食用过多汤汁。
 芋头
 芋头热量较低，减肥期间推荐作为粗粮代替主食食用。",
 "protein": "1.8",
 "fat": "2.9",
 "fiber_dietary": "0.8",
 "carbohydrate": "14.4",
 "compare": { },
 "recipe": false,
 "units": [ ],
 "ingredient": {
    "calory": "88",
    "protein": "1.8",
    "fat": "2.9",
     "carbohydrate": "14.4",
     "fiber_dietary": "0.8",
     "vitamin_a": "",
     "vitamin_c": "",
     "vitamin_e": "",
     "carotene": "",
     "thiamine": "",
     "lactoflavin": "",
     "niacin": "",
     "cholesterol": "",
     "magnesium": "",
     "calcium": "",
     "iron": "",
     "zinc": "",
     "copper": "",
     "manganese": "",
     "kalium": "",
     "phosphor": "",
     "natrium": "",
     "selenium": ""
 },
 "lights": {
     "calory": "低热量",
     "protein": "",
     "carbohydrate": "",
     "fat": "低脂肪",
     "fiber_dietary": ""
 }
 */

#import <Foundation/Foundation.h>

@class LJBFoodIngredient;
@class LJBFoodLights;
@class LJBFoodCompare;

@interface LJBFood : NSObject <MJKeyValue>
/**
 *  食物id
 */
@property (nonatomic, copy) NSString * food_id;
/**
 *  食物编码
 */
@property (nonatomic, copy) NSString * code;
/**
 *  食物名称
 */
@property (nonatomic, copy) NSString * name;
/**
 *  热量
 */
@property (nonatomic, copy) NSString * calory;
/**
 *  重量
 */
@property (nonatomic, copy) NSString * weight;
@property (nonatomic, copy) NSString * health_light;
@property (nonatomic, copy) NSString * is_liquid;
@property (nonatomic, copy) NSString * thumb_image_url;
@property (nonatomic, copy) NSString * large_image_url;
@property (nonatomic, copy) NSString * appraise;
@property (nonatomic, copy) NSString * protein;
@property (nonatomic, copy) NSString * fat;
@property (nonatomic, copy) NSString * fiber_dietary;
@property (nonatomic, copy) NSString * carbohydrate;
@property (nonatomic, copy) NSString * recipe;
@property (nonatomic, copy) NSString * uploader;

@property (nonatomic, copy) NSString * favorite;

/**
 *  食物评价高度
 */
@property (nonatomic, assign) CGFloat appraiseHeight;

/**
 *  所含能量
 */
@property (nonatomic, strong) NSArray * units;

@property (nonatomic, strong) LJBFoodIngredient * ingredient;
@property (nonatomic, strong) LJBFoodLights * lights;
@property (nonatomic, strong) LJBFoodCompare * compare;

@end
