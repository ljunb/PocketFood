//
//  LJBKeywordCell.h
//  PocketFood
//
//  Created by qf on 15/11/23.
//  Copyright © 2015年 qf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LJBKeywordCell : UITableViewCell

/**
 *  快速创建搜索关键词cell
 *
 *  @param tableView 外部传入的tableView
 *
 *  @return 返回自定义的关键字cell
 */
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, copy) void(^KeywordClickAction)(NSString * keyword);

- (void)configCellWithKeywords:(NSArray *)keywords;

@end
