//
//  LJBFoodSingleTon.h
//  PocketFood
//
//  Created by qf on 15/11/20.
//  Copyright © 2015年 qf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LJBFoodSingleTon : NSObject

@property (nonatomic, copy) NSString * foodCode;

/**
 *  食物单例，用来共享食物编码
 *
 *  @return 返回食物单例
 */
+ (instancetype)sharedFood;

@end
