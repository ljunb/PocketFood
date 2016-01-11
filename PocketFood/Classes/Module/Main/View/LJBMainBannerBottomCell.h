//
//  LJBMainBannerBottomCell.h
//  PocketFood
//
//  Created by qf on 15/11/17.
//  Copyright © 2015年 qf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LJBMainBannerBottomCell : UITableViewCell

/**
 *  单击手势block
 */
@property (nonatomic, copy) void(^ShowFoodDetailAction)(NSInteger index);

/**
 *  快速创建首页广告栏下方图片
 *
 *  @param tableView 外部传入的tableView
 *
 *  @return 返回自定义的cell
 */
+ (instancetype)cellWithTableView:(UITableView *)tableView;

/**
 *  配置图片资源
 *
 *  @param images 请求到的图片
 */
- (void)configCellWithImages:(NSArray *)images;


@end
