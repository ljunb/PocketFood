//
//  LJBMaterialCondiments.h
//  PocketFood
//
//  Created by qf on 15/11/20.
//  Copyright © 2015年 qf. All rights reserved.
//  原料
/**
 *   "condiments": [
 {
 "name": "水磨糯米粉",
 "amount": "100克"
 },
 */
#import <Foundation/Foundation.h>

@interface LJBMaterialCondiment : NSObject

@property (nonatomic, copy) NSString * name;

@property (nonatomic, copy) NSString * amount;

@end
