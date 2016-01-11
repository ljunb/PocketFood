//
//  LJBTopicIndicatiorView.m
//  PocketFood
//
//  Created by qf on 15/11/18.
//  Copyright © 2015年 qf. All rights reserved.
//  专题页下面的指示图

#import "LJBTopicIndicatiorView.h"

#define Line_Y (self.bounds.size.height+Line_Height)/2
#define Line_Width 15
#define Line_Height 3
#define Margin 5

@interface LJBTopicIndicatiorView ()

/**
 *  当前页码
 */
@property (nonatomic, strong) UIView * currentPage;

/**
 *  左边间距
 */
@property (nonatomic, assign) CGFloat leftGap;

@end

@implementation LJBTopicIndicatiorView

#pragma mark - 设置页码指示图
- (void)configViewWithPageCount:(NSInteger)pageCount {
        
    CGFloat gap = (KScreenSize.width - pageCount*Line_Width - (pageCount-1)*Margin)/2;
    self.leftGap = gap;
    
    for (NSInteger i = 0; i < pageCount; i++) {
        
        UIView * lineView = [[UIView alloc] init];
        lineView.frame = CGRectMake(gap + (Line_Width + Margin)*i, Line_Y, Line_Width, Line_Height);
        lineView.backgroundColor = KColor(226, 226, 226);
        
        [self addSubview:lineView];
    }
    
    self.currentPage.frame = CGRectMake(self.leftGap, Line_Y, Line_Width, Line_Height);
}

#pragma mark - 更新页码
- (void)updatePageIndicatorWithIndex:(NSInteger)index {
    
    self.currentPage.frame = CGRectMake(self.leftGap + (Line_Width+Margin)*index, Line_Y, Line_Width, Line_Height);
}

#pragma mark - getter
- (UIView *)currentPage {
    
    if (!_currentPage) {
        _currentPage = [[UIView alloc] init];
        _currentPage.backgroundColor = KColor(234, 82, 90);
        [self addSubview:_currentPage];
    }
    return _currentPage;
}

@end
