//
//  LJBTopicIndicatiorView.h
//  PocketFood
//
//  Created by qf on 15/11/18.
//  Copyright © 2015年 qf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LJBTopicIndicatiorView : UIView

/**
 *  设置页码指示图
 *
 *  @param pageCount 页码数
 */
- (void)configViewWithPageCount:(NSInteger)pageCount;

/**
 *  更新页码
 *
 *  @param index 页码下标
 */
- (void)updatePageIndicatorWithIndex:(NSInteger)index;

@end
