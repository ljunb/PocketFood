//
//  LJBFoodCaloryCell.h
//  PocketFood
//
//  Created by qf on 15/11/19.
//  Copyright © 2015年 qf. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LJBFoodUnits;

@interface LJBFoodCaloryCell : UITableViewCell

/**
 *  工厂方法
 *
 *  @param tableView 需要显示的TableView
 *
 *  @return 返回自定义的食物热量cell
 */
+ (instancetype)cellWithTableView:(UITableView *)tableView;

/**
 *  食物热量模型
 */
@property (nonatomic, strong) LJBFoodUnits * model;



@end
