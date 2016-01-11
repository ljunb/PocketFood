//
//  LJBAppraiseSectionView.h
//  PocketFood
//
//  Created by qf on 15/11/19.
//  Copyright © 2015年 qf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LJBAppraiseSectionView : UITableViewHeaderFooterView

/**
 *  返回自定制的食物评价视图
 *
 *  @param tableView 显示的表格视图
 */
+ (instancetype)sectionViewWithTableView:(UITableView *)tableView;

/**
 *  设置section标题
 */
@property (nonatomic, assign) KFoodSectionType sectionType;

- (void)configTitleWithTitles:(NSArray *)titles;

@end
