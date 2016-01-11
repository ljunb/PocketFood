//
//  LJBFoodIngredientCell.h
//  PocketFood
//
//  Created by qf on 15/11/19.
//  Copyright © 2015年 qf. All rights reserved.
//  食物营养cell

#import <UIKit/UIKit.h>

@class LJBFood;

@interface LJBFoodIngredientCell : UITableViewCell

/**
 *  工厂方法
 *
 *  @param tableView 需要显示的TableView
 *
 *  @return 返回自定义的食物热量cell
 */
+ (instancetype)cellWithTableView:(UITableView *)tableView;

/**
 *  根据食物模型和营养元素名称设置cell
 *
 *  @param foodModel  获得的食物模型
 *  @param ingredient cell对应的营养元素名称
 */
- (void)configCellWithFood:(LJBFood *)foodModel ingredient:(NSString *)ingredient;



@end
