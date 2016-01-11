//
//  LJBFoodNetworker.m
//  PocketFood
//
//  Created by qf on 15/11/18.
//  Copyright © 2015年 qf. All rights reserved.
//

#import "LJBFoodNetworker.h"
#import "LJBHTTPTool.h"

#import "LJBFood.h"
#import "LJBFoodMaterial.h"
#import "LJBFoodGroupCategory.h"

@implementation LJBFoodNetworker

+ (void)getFoodDataFromServerWithSuccess:(void (^)(id model))success
                                 failure:(void (^)(NSError *))failure
                            withFoodCode:(NSString *)code
                                foodType:(KFoodDataType)type {
    
    NSString * url;
    if (type == KFoodDataDetailType) {
        url = [NSString stringWithFormat:KFood_URL, code];
    } else {
        url = [NSString stringWithFormat:KFoodMaterialCook_URL, code];
    }
    
    [LJBHTTPTool getDataWithURL:url params:nil success:^(id response) {
        
        if (response) {
            
            id foodModel;
            if (type == KFoodDataDetailType) {
                foodModel = [LJBFood objectWithKeyValues:response];
            } else {
                foodModel = [LJBFoodMaterial objectWithKeyValues:response];
            }
            
            if (success) {
                success(foodModel);
            }
        }
        
    } failure:^(NSError *error) {
        
        if (failure) {
            failure(error);
        }
    }];
    
}

+ (void)getFoodCategoryDataFromServerWithSuccess:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure withParams:(NSDictionary *)params {
    
    [LJBHTTPTool getDataWithURL:KFoodCategory_URL params:params success:^(id response) {
        
        if (response) {
            
            NSArray * categories = [LJBFoodGroupCategory objectArrayWithKeyValuesArray:response[@"categories"]];
            
            if (success) {
                success(categories);
            }
        }
        
    } failure:^(NSError *error) {
        
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)getFoodsDataFromServerWithSuccess:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure withParams:(NSDictionary *)params {
    
    [LJBHTTPTool getDataWithURL:KFoods_URL params:params success:^(id response) {
        
        if (response) {
            
            NSArray * foods = [LJBFood objectArrayWithKeyValuesArray:response[@"foods"]];
            
            if (success) {
                success(foods);
            }
        }
        
    } failure:^(NSError *error) {
        
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)searchFoodsDataFromServerWithSuccess:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure withParams:(NSDictionary *)params {
    
    [LJBHTTPTool getDataWithURL:KSearch_URL params:params success:^(id response) {
        
        if (response) {
            
            NSArray * foods = [LJBFood objectArrayWithKeyValuesArray:response[@"foods"]];
            
            if (success) {
                success(foods);
            }
        }
        
    } failure:^(NSError *error) {
        
        if (failure) {
            failure(error);
        }
    }];
}

@end
