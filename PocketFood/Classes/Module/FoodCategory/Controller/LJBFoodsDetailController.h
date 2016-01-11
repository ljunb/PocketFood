//
//  LJBFoodsDetailController.h
//  PocketFood
//
//  Created by qf on 15/11/21.
//  Copyright © 2015年 qf. All rights reserved.
//

#import "LJBBaseViewController.h"

@class LJBFoodGroupCategory;

@interface LJBFoodsDetailController : LJBBaseViewController

/**
 *  食物种类
 */
@property (nonatomic, copy) NSString * kind;

/**
 *  食物模型
 */
@property (nonatomic, strong) LJBFoodGroupCategory * model;


@end
