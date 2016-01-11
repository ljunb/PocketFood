//
//  LJBFoodsCell.h
//  PocketFood
//
//  Created by qf on 15/11/21.
//  Copyright © 2015年 qf. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LJBFood;

@interface LJBFoodsCell : UITableViewCell

/**
 *  工厂方法
 *
 *  @param tableView 装载的TableView
 *
 *  @return 自定义的季节cell
 */
+ (instancetype)cellWithTableView:(UITableView *)tableView;

/**
 *  配置cell
 *
 *  @param foodModel  食物模型
 *  @param orderIndex 对应的排序类型
 */
- (void)configCellWithModel:(LJBFood *)foodModel orderBy:(NSInteger)orderIndex;


@end
