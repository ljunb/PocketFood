//
//  LJBFoodSeasonCell.h
//  PocketFood
//
//  Created by qf on 15/11/21.
//  Copyright © 2015年 qf. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LJBFoodGroupCategory;

@interface LJBFoodSeasonCell : UITableViewCell

/**
 *  工厂方法
 *
 *  @param tableView 装载的TableView
 *
 *  @return 自定义的季节cell
 */
+ (instancetype)cellWithTableView:(UITableView *)tableView;

/**
 *  食物分类模型
 */
@property (nonatomic, strong) LJBFoodGroupCategory * categoryModel;

@end
