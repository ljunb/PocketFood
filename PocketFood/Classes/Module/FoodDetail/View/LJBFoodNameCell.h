//
//  LJBFoodNameCell.h
//  PocketFood
//
//  Created by qf on 15/11/18.
//  Copyright © 2015年 qf. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LJBFood;

@interface LJBFoodNameCell : UITableViewCell

/**
 *  食物模型
 */
@property (nonatomic, strong) LJBFood * model;


/**
 *  快速创建食物详情名称cell
 *
 *  @param tableView 外部传入的tableView
 *
 *  @return 返回自定义的食物名称cell
 */
+ (instancetype)cellWithTableView:(UITableView *)tableView;



@end
