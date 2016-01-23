//
//  LJBTitleSelectView.m
//
//  Created by CookieJ on 15/11/9.
//  Copyright © 2015年 ljunb. All rights reserved.
//

#define CornerRadius self.bounds.size.height/2


#import "LJBTitleSelectView.h"

@interface LJBTitleSelectView ()
/**
 *  滑块
 */
@property (nonatomic, strong) UIView * sliderView;

/**
 *  滑块数组
 */
@property (nonatomic, strong) NSMutableArray * items;

/**
 *  当前滑块下标
 */
@property (nonatomic, assign) NSInteger currentIndex;

/**
 *  滑块宽度、高度
 */
@property (nonatomic, assign) CGFloat item_W;
@property (nonatomic, assign) CGFloat item_H;

@property (nonatomic, copy) void(^itemClickAtIndex)(NSInteger index);

@end

@implementation LJBTitleSelectView


#pragma mark - 重写初始化方法
- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        _items = [NSMutableArray array];
        [self addSubviews];
    }
    return self;
}

#pragma mark - 添加子视图
- (void)addSubviews {
    
    self.backgroundColor = [UIColor clearColor];
    self.layer.cornerRadius = CornerRadius;
    self.layer.masksToBounds = YES;
    self.layer.borderColor = [UIColor whiteColor].CGColor;
    self.layer.borderWidth = 1;
}

#pragma mark - 重写setter方法
- (void)setTitles:(NSArray *)titles {
    
    _titles = titles;
    
    _item_W = self.frame.size.width / _titles.count;
    _item_H = self.frame.size.height;
    
    _sliderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _item_W, _item_H)];
    _sliderView.backgroundColor = KColor(236, 236, 236);
    [self addSubview:_sliderView];
    
    for (NSInteger i = 0; i < _titles.count; i++) {
        
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(i * _item_W, 0, _item_W, _item_H)];
        [button setTitle:_titles[i] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitleColor:KColor(234, 82, 90) forState:UIControlStateDisabled];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        if (i == 0) {
            button.enabled = NO;
            _currentIndex = i;
        }
        
        [self addSubview:button];
        [_items addObject:button];
    }
    
}

#pragma mark - 滑块点击方法
- (void)buttonClick:(UIButton *)button {
    
    UIButton * currentBtn = _items[_currentIndex];
    currentBtn.enabled = YES;
    _currentIndex = [_items indexOfObject:button];
    button.enabled = NO;
    
    [UIView animateWithDuration:0.2 animations:^{
       
        _sliderView.frame = CGRectMake(_currentIndex * _item_W, 0, _item_W, _item_H);
        
    }];
    
    if (self.SelectIndexBlock) {
        self.SelectIndexBlock(_currentIndex);
    }

    if (self.itemClickAtIndex) {
        _itemClickAtIndex(_currentIndex);
    }
}

- (void)setSelectAtIndex:(NSInteger)index {
    
}

#pragma mark - 滚动视图联动滑块方法
- (void)setContentOffset:(CGFloat)point {
    
    [UIView animateWithDuration:0.2 animations:^{
        
        _sliderView.frame = CGRectMake(point, 0, _item_W, _item_H);
        
    } completion:^(BOOL finished) {
        
        UIButton * lastBtn = _items[_currentIndex];
        lastBtn.enabled = YES;
        
        _currentIndex = _sliderView.frame.origin.x / _item_W;
        
        UIButton * currentBtn = _items[_currentIndex];
        currentBtn.enabled = NO;
    }] ;
}

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles selectAtIndex:(void (^)(NSInteger))selectIndex {
    
    self = [self initWithFrame:frame];
    
    if (self) {
        [self setTitles:titles];
        self.itemClickAtIndex = selectIndex;
    }
    
    return self;
}

@end
