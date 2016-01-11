//
//  LJBFoodLights.h
//  PocketFood
//
//  Created by qf on 15/11/18.
//  Copyright © 2015年 qf. All rights reserved.
//  食物备注
/**
 *  "lights": {
 "calory": "低热量",
 "protein": "",
 "carbohydrate": "",
 "fat": "低脂肪",
 "fiber_dietary": ""
 }
 */

#import <Foundation/Foundation.h>

@interface LJBFoodLights : NSObject

@property (nonatomic, copy) NSString * calory;
@property (nonatomic, copy) NSString * protein;
@property (nonatomic, copy) NSString * fat;
@property (nonatomic, copy) NSString * carbohydrate;
@property (nonatomic, copy) NSString * fiber_dietary;

@end
