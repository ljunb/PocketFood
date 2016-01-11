//
//  LJBTitleSelectView.h
//  蝉游记
//
//  Created by qf on 15/11/9.
//  Copyright © 2015年 qf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LJBTitleSelectView : UIView

// 需要显示的标题
@property (nonatomic, strong) NSArray * titles;

// 设置选中的是哪个标题
- (void)setSelectAtIndex:(NSInteger)index;

- (void)setContentOffset:(CGFloat)point;

// 把选中的下标传出去
@property (nonatomic, copy) void(^SelectIndexBlock)(NSInteger index);


- (instancetype)initWithFrame:(CGRect)frame
                       titles:(NSArray *)titles
                selectAtIndex:(void(^)(NSInteger index))selectIndex;

@end
