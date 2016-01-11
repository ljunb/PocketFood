//
//  LJBBaseFoodCategoryController.h
//  PocketFood
//
//  Created by qf on 15/11/20.
//  Copyright © 2015年 qf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LJBBaseViewController.h"

@interface LJBFoodCategoryController : LJBBaseViewController

/**
 *  需要显示的模型数组
 */
@property (nonatomic, strong) NSMutableArray * items;

/**
 *  item类型
 */
@property (nonatomic, assign) KFoodCategoryItemType itemType;

/**
 *  分类
 */
@property (nonatomic, copy) NSString * category;

@end
