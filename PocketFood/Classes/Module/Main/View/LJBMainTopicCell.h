//
//  LJBMainTopicCell.h
//  PocketFood
//
//  Created by qf on 15/11/17.
//  Copyright © 2015年 qf. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LJBMainTopic;

@interface LJBMainTopicCell : UITableViewCell

/**
 *  快速创建首页专题cell
 *
 *  @param tableView 外部传入的tableView
 *
 *  @return 返回自定义的专题cell
 */
+ (instancetype)cellWithTableView:(UITableView *)tableView;

/**
 *  配置专题图片资源
 *
 *  @param images 请求到的专题图片
 */
- (void)configCellWithModel:(LJBMainTopic *)model;


@end
