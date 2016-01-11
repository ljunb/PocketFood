//
//  LJBClearHistoryCell.h
//  PocketFood
//
//  Created by qf on 15/11/23.
//  Copyright © 2015年 qf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LJBClearHistoryCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, copy) void(^ClearHistoryAction)();

@end
