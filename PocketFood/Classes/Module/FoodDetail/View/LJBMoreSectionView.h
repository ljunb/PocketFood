//
//  LJBMoreSectionView.h
//  PocketFood
//
//  Created by qf on 15/11/19.
//  Copyright © 2015年 qf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LJBMoreSectionView : UITableViewHeaderFooterView

/**
 *  返回自定制的查看更多营养元素视图
 *
 *  @param tableView 显示的表格视图
 */
+ (instancetype)sectionViewWithTableView:(UITableView *)tableView;

@property (nonatomic, copy) void(^ShowMoreIngredientInfoAction)();

@end
