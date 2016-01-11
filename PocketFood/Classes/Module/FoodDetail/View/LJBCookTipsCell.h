//
//  LJBCookTipsCell.h
//  PocketFood
//
//  Created by qf on 15/11/20.
//  Copyright © 2015年 qf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LJBCookTipsCell : UITableViewCell

/**
 *  快速创建食物图片cell的工程方法
 *
 *  @param tableView 装载的tableView
 *
 *  @return 自定义的食物图片cell
 */
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, copy ) NSString * tipsText;

@end
