//
//  LJBHTTPTool.h
//  PocketFood
//
//  Created by qf on 15/11/17.
//  Copyright © 2015年 qf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LJBHTTPTool : NSObject

/**
 *  请求网络数据方法
 */
+ (void)getDataWithURL:(NSString *)url
                params:(NSDictionary *)params
               success:(void(^)(id response))success
               failure:(void(^)(NSError * error))failure;

@end
