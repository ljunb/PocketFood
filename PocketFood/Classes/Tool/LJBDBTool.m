//
//  LJBDBHelper.m
//  蝉游记
//
//  Created by qf on 15/11/11.
//  Copyright © 2015年 qf. All rights reserved.
//

#import "LJBDBTool.h"

@implementation LJBDBTool
{
    FMDatabase * _database;
}

static LJBDBTool * helper = nil;

+ (instancetype)sharedDatabase {

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helper = [[LJBDBTool alloc] init];
    });
    
    return helper;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {

    if (!helper) {
        helper = [super allocWithZone:zone];
    }
    return helper;
}


#pragma mark - over write init method
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self createDB];
    }
    return self;
}

#pragma mark - create db
- (void)createDB {
    
    if (!_database) {
        // 数据库路径
        NSString * path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/food.db"];
        
        // 实例化数据库
        _database = [FMDatabase databaseWithPath:path];
        
        if ([_database open]) {
            NSLog(@"Open db success!");
            [self createTable];
        }
    }
}

#pragma mark - create table
- (void)createTable {
    // 创建表
    NSString * t_food = @"create table if not exists t_food (id integer primary key autoincrement, name text, code text, calory text, health_light text, thumb_image_url text,  favorite text)";
    
    if ([_database executeUpdate:t_food]) {
        
        NSLog(@"Create t_food success!");
    }

}

#pragma mark - save data
- (BOOL)saveFood:(LJBFood *)model {
    
    NSString * save = @"insert into t_food (name, code, calory, health_light, thumb_image_url, favorite) values (?, ?, ?, ?, ?, ?)";
    
    BOOL isSuccess;
    @synchronized(self) {
    
        isSuccess = [_database executeUpdate:save, model.name, model.code, model.calory, model.health_light, model.thumb_image_url, model.favorite];
    }
    
    if (isSuccess) {
        NSLog(@"Insert data success!");
        return YES;
    } else {
        NSLog(@"Insert data failed!");
        return NO;
    }
}

#pragma mark - check isExists data
- (BOOL)isExistsFood:(NSString *)foodCode {
    
    NSString * query = @"select * from t_food where code = ?";
    
    FMResultSet * result;
    @synchronized(self) {
        
        result = [_database executeQuery:query, foodCode];
    }
    
    while ([result next]) {
        
        return YES;
    }
        
    return NO;
}

#pragma mark - return all datas from t_favorite
- (NSArray *)getAllFoods {
    
    NSString * query = @"select * from t_food";
    
    FMResultSet * result;
    
    @synchronized(self) {
        result = [_database executeQuery:query];
    }
    
    NSMutableArray * datas = [NSMutableArray array];
    
    while ([result next]) {
        
        LJBFood * model = [[LJBFood alloc] init];
        model.name = [result objectForColumnName:@"name"];
        model.code = [result objectForColumnName:@"code"];
        model.calory = [result objectForColumnName:@"calory"];
        model.health_light = [result objectForColumnName:@"health_light"];
        model.thumb_image_url = [result objectForColumnName:@"thumb_image_url"];
        model.favorite = [result objectForColumnName:@"favorite"];
        
        [datas addObject:model];
    }
    
    return datas;
}

- (BOOL)removeFood:(LJBFood *)model {
    
    NSString * del = @"delete from t_food where code = ?";
    
    BOOL isSuccess;
    
    @synchronized(self) {
        isSuccess = [_database executeUpdate:del, model.code];
    }
    
    if (isSuccess) {
        
        NSLog(@"Delete success!");
        
        return YES;
        
    } else {
        
        NSLog(@"Delete failed!");
        
        return NO;
    }
}

- (BOOL)removeAllFoods {
    
    NSString * del = @"delete from t_food";
    
    BOOL isSuccess;
    
    @synchronized(self) {
        isSuccess = [_database executeUpdate:del];
    }
    
    if (isSuccess) {
        NSLog(@"Delete all data success!");
        return YES;
    } else {
        NSLog(@"Delete all data failed!");
        return NO;
    }
}

@end
