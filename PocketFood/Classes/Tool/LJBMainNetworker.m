//
//  LJBMainNetworker.m
//  PocketFood
//
//  Created by qf on 15/11/17.
//  Copyright © 2015年 qf. All rights reserved.
//

#import "LJBMainNetworker.h"
#import "LJBHTTPTool.h"

#import "LJBMainFood.h"
#import "LJBMainTopic.h"
#import "LJBTopicPage.h"

@implementation LJBMainNetworker

#pragma mark - 请求首页广告栏数据
+ (void)getBannerDataFromServerWithSuccess:(void (^)(NSArray *models))success failure:(void (^)(NSError *error))failure {
    
    [LJBHTTPTool getDataWithURL:KMainBanner_URL params:nil success:^(id response) {
        
        if (response) {
            
            NSMutableArray * models = [NSMutableArray array];
            
            [models addObject:[LJBMainFood objectWithKeyValues:response[@"banner"]]];
            
            [models addObjectsFromArray:[LJBMainFood objectArrayWithKeyValuesArray:response[@"others"]]];
            
            // 回传模型数组
            if (success) {
                success(models);
            }
            
        }
        
    } failure:^(NSError *error) {
        
        if (failure) {
            failure(error);
        }
    }];
}

#pragma mark - 请求首页专题数据
+ (void)getTopicDataFromServerWithSuccess:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure {
    
    [LJBHTTPTool getDataWithURL:KMainTopic_URL params:nil success:^(id response) {
        
        if (response) {
            
            NSMutableArray * topics = [NSMutableArray array];
            
            [topics addObjectsFromArray:[LJBMainTopic objectArrayWithKeyValuesArray:response[@"topics"]]];
            
            // 回传模型数组
            if (success) {
                success(topics);
            }
        }
        
    } failure:^(NSError *error) {
        
        if (failure) {
            failure(error);
        }
    }];
}

#pragma mark - 请求专题详情页数据
+ (void)getTopicPageDataFromServerWithSuccess:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure withTopicId:(NSString *)topicId {
    
    NSString * url = [NSString stringWithFormat:@"%@/%@", KMainTopic_URL, topicId];
    
    [LJBHTTPTool getDataWithURL:url params:nil success:^(id response) {
        
        if (response) {
            
            NSMutableArray * pages = [NSMutableArray array];
            
            [pages addObjectsFromArray:[LJBTopicPage objectArrayWithKeyValuesArray:response[@"topic"][@"pages"]]];
            
            if (success) {
                success(pages);
            }
        }
        
    } failure:^(NSError *error) {
        
        if (failure) {
            failure(error);
        }
    }];
}

#pragma mark - 请求关键词数据
+ (void)getKeywordsDataFromServerWithSuccess:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure {
    
    [LJBHTTPTool getDataWithURL:KKeywords_URL params:nil success:^(id response) {
        
        if (response) {
            
            if (success) {
                success(response[@"keywords"]);
            }
        }
        
    } failure:^(NSError *error) {
        
        if (failure) {
            failure(error);
        }
    }];
}
@end
