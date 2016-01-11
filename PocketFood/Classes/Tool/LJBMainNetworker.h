//
//  LJBMainNetworker.h
//  PocketFood
//
//  Created by qf on 15/11/17.
//  Copyright © 2015年 qf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LJBMainNetworker : NSObject

/**
 *  请求首页广告栏数据
 *
 *  @param success 请求成功后返回模型数组
 *  @param failure 请求失败后返回错误数据
 */
+ (void)getBannerDataFromServerWithSuccess:(void(^)(NSArray *models))success
                                   failure:(void(^)(NSError *error))failure;

/**
 *  请求首页专题数据
 *
 *  @param success 请求成功后返回模型数组
 *  @param failure 请求成功后返回错误信息
 */
+ (void)getTopicDataFromServerWithSuccess:(void(^)(NSArray *models))success
                                  failure:(void(^)(NSError *error))failure;

/**
 *  请求专题详情页数据
 *
 *  @param success 请求成功后返回模型数组
 *  @param failure 请求失败后返回错误信息
 */
+ (void)getTopicPageDataFromServerWithSuccess:(void(^)(NSArray *models))success
                                      failure:(void(^)(NSError *error))failure
                                  withTopicId:(NSString *)topicId;

/**
 *  请求搜索关键词
 *
 *  @param success 请求成功后返回关键字数组
 *  @param failure 请求失败后返回错误信息
 */
+ (void)getKeywordsDataFromServerWithSuccess:(void(^)(NSArray *keywords))success
                                     failure:(void(^)(NSError *error))failure;

@end
