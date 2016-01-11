//
//  LJBFoodCompareCell.h
//  PocketFood
//
//  Created by qf on 15/11/19.
//  Copyright © 2015年 qf. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LJBFood;

@interface LJBFoodCompareCell : UITableViewCell

/**
 *  创建食物对比cell
 *
 *  @param tableView 装载的TableView
 *
 *  @return 食物对比cell
 */
+ (instancetype)cellWithTableView:(UITableView *)tableView;

/**
 *  食物对比模型
 */
@property (nonatomic, strong) LJBFood * model;


@end
