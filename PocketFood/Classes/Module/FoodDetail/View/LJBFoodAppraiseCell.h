//
//  LJBFoodAppraiseCell.h
//  PocketFood
//
//  Created by qf on 15/11/18.
//  Copyright © 2015年 qf. All rights reserved.
//  食物评价

#import <UIKit/UIKit.h>

@class LJBFood;

@interface LJBFoodAppraiseCell : UITableViewCell

/**
 *  食物模型
 */
@property (nonatomic, strong) LJBFood * model;

/**
 *  食物原料与做法block
 */
@property (nonatomic, copy) void(^FoodMaterialAction)();

/**
 *  工厂方法
 *
 *  @param tableView 需要显示的TableView
 *
 *  @return 返回自定义的食物评价cell
 */
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
