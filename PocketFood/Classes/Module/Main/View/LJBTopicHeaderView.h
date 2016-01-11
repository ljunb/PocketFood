//
//  LJBTopicHeaderView.h
//  PocketFood
//
//  Created by qf on 15/11/20.
//  Copyright © 2015年 qf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LJBTopicHeaderView : UITableViewHeaderFooterView

/**
 *  返回自定制的专题组头视图
 *
 *  @param tableView 显示的表格视图
 */
+ (instancetype)sectionViewWithTableView:(UITableView *)tableView;

/**
 *  查看更多专题block
 */
@property (nonatomic, copy) void(^ShowMoreTopicAction)();

@end
