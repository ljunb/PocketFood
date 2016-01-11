//
//  LJBFoodNetworker.h
//  PocketFood
//
//  Created by qf on 15/11/18.
//  Copyright © 2015年 qf. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LJBFood;

@interface LJBFoodNetworker : NSObject

/**
 *  请求食物详细数据
 *
 *  @param success 请求成功后返回模型数组
 *  @param failure 请求失败后返回错误数据
 */
+ (void)getFoodDataFromServerWithSuccess:(void(^)(id model))success
                                 failure:(void(^)(NSError *error))failure
                            withFoodCode:(NSString *)code
                                foodType:(KFoodDataType)type;

/**
 *  请求食物分类数据
 *
 *  @param success 请求成功后返回模型数组
 *  @param failure 请求失败后返回错误数据
 *  @param params  请求参数
 */
+ (void)getFoodCategoryDataFromServerWithSuccess:(void (^)(NSArray *categories))success
                                         failure:(void (^)(NSError *error))failure
                                      withParams:(NSDictionary *)params;

/**
 *  请求食物大全数据
 *
 *  @param success 请求成功后返回模型数组
 *  @param failure 请求失败后返回错误数据
 *  @param params  请求参数
 */
+ (void)getFoodsDataFromServerWithSuccess:(void (^)(NSArray *foods))success
                                  failure:(void (^)(NSError *error))failure
                               withParams:(NSDictionary *)params;

/**
 *  搜索食物大全数据
 *
 *  @param success 请求成功后返回模型数组
 *  @param failure 请求失败后返回错误数据
 *  @param params  请求参数
 */
+ (void)searchFoodsDataFromServerWithSuccess:(void (^)(NSArray *foods))success
                                     failure:(void (^)(NSError *error))failure
                                  withParams:(NSDictionary *)params;

@end
