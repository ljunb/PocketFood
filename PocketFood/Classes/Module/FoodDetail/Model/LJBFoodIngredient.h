//
//  LJBFoodIngredient.h
//  PocketFood
//
//  Created by qf on 15/11/18.
//  Copyright © 2015年 qf. All rights reserved.
//  食物营养

/**
 *  "ingredient": {
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

 */

#import <Foundation/Foundation.h>

@interface LJBFoodIngredient : NSObject

@property (nonatomic, copy) NSString * calory;
@property (nonatomic, copy) NSString * protein;
@property (nonatomic, copy) NSString * fat;
@property (nonatomic, copy) NSString * carbohydrate;
@property (nonatomic, copy) NSString * fiber_dietary;
@property (nonatomic, copy) NSString * vitamin_a;
@property (nonatomic, copy) NSString * vitamin_c;
@property (nonatomic, copy) NSString * vitamin_e;
@property (nonatomic, copy) NSString * carotene;
@property (nonatomic, copy) NSString * thiamine;
@property (nonatomic, copy) NSString * lactoflavin;
@property (nonatomic, copy) NSString * niacin;
@property (nonatomic, copy) NSString * cholesterol;
@property (nonatomic, copy) NSString * magnesium;
@property (nonatomic, copy) NSString * calcium;
@property (nonatomic, copy) NSString * iron;
@property (nonatomic, copy) NSString * zinc;
@property (nonatomic, copy) NSString * copper;
@property (nonatomic, copy) NSString * manganese;
@property (nonatomic, copy) NSString * kalium;
@property (nonatomic, copy) NSString * phosphor;
@property (nonatomic, copy) NSString * natrium;
@property (nonatomic, copy) NSString * selenium;

@end
