//
//  LJBDBHelper.h
//  蝉游记
//
//  Created by qf on 15/11/11.
//  Copyright © 2015年 qf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "LJBFood.h"

@interface LJBDBTool : NSObject

/** 单例*/
+ (instancetype)sharedDatabase;

/** 是否存在*/
- (BOOL)isExistsFood:(NSString *)foodCode;

/** 缓存数据*/
- (BOOL)saveFood:(LJBFood *)model;

/** 删除数据*/
- (BOOL)removeFood:(LJBFood *)model;

/** 读取所有数据*/
- (NSArray *)getAllFoods;

/** 删除所有数据*/
- (BOOL)removeAllFoods;

@end
