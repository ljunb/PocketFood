//
//  LJBMainBannerCell.m
//  PocketFood
//
//  Created by qf on 15/11/17.
//  Copyright © 2015年 qf. All rights reserved.
//

#import "LJBMainBannerCell.h"
#import "UIImageView+WebCache.h"
#import "LJBMainFood.h"

#define FoodName_Height 35

@interface LJBMainBannerCell () <UIScrollViewDelegate>

/**
 *  广告栏轮播视图
 */
@property (nonatomic, strong) UIScrollView * scrollView;

/**
 *  广告栏图片数组
 */
@property (nonatomic, strong) NSMutableArray * imageArray;

/**
 *  食物名称背景
 */
@property (nonatomic, strong) UIView * coverView;

/**
 *  食物名称
 */
@property (nonatomic, strong) UILabel * foodName;

/**
 *  页码指示器
 */
@property (nonatomic, strong) UIPageControl * pageControl;

/**
 *  当前页数
 */
@property (nonatomic, assign) NSInteger currentPage;

/**
 *  计时器
 */
@property (nonatomic, strong) NSTimer * timer;

@end

@implementation LJBMainBannerCell

#pragma mark - getter
- (NSMutableArray *)imageArray {
    
    if (!_imageArray) {
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
}

#pragma mark - 快速创建cell的类方法
+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    static NSString * ID = @"main_banner_cell";
    
    LJBMainBannerCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[LJBMainBannerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

#pragma mark - 重写初始化方法
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubviews];
    }
    return self;
}

#pragma mark 添加子控件
- (void)addSubviews {
    
    // 滚动视图
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    [self.contentView addSubview:_scrollView];
    
    // 适配滚动视图
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    // 页码指示器
    _pageControl = [[UIPageControl alloc] init];
    _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    [self.contentView addSubview:_pageControl];
}

#pragma mark - 配置广告栏图片
- (void)configCellWithImages:(NSArray *)images {
    
    // 清除旧数据
    if (self.imageArray.count) {
        [self.imageArray removeAllObjects];
    }
    
    // 首尾添加图片
    [self.imageArray addObjectsFromArray:images];
    [self.imageArray insertObject:images.lastObject atIndex:0];
    [self.imageArray addObject:images.firstObject];
    
    _scrollView.contentSize = CGSizeMake(self.imageArray.count * KScreenSize.width, 0);
    _scrollView.contentOffset = CGPointMake(KScreenSize.width*1, 0);
    
    // 添加轮播图片
    UIImageView * lastImgView;
    for (NSInteger i = 0; i < self.imageArray.count; i++) {
        
        // 获得模型
        LJBMainFood * foodModel = self.imageArray[i];
        
        // 创建图片实例
        UIImageView * imageView = [[UIImageView alloc] init];
        imageView.tag = 100 + i;
        [self.scrollView addSubview:imageView];
        
        // 适配图片
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.scrollView);
            make.left.equalTo(lastImgView ? lastImgView.mas_right : @0);
            make.width.equalTo(self.scrollView);
            make.height.equalTo(self.scrollView);
        }];
        lastImgView = imageView;
        
        // 添加手势
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        imageView.userInteractionEnabled = YES;
        [imageView addGestureRecognizer:tap];
        
        // 设置图片资源
        [imageView sd_setImageWithURL:[NSURL URLWithString:foodModel.image_url] placeholderImage:[UIImage imageNamed:@"img_default_topic_banner"]];
        
        // 食物名称背景View
        _coverView = [[UIView alloc] init];
        _coverView.alpha = 0.5;
        _coverView.backgroundColor = [UIColor blackColor];
        [imageView addSubview:_coverView];
        
        // 适配背景View
        [_coverView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(imageView.mas_bottom);
            make.left.equalTo(imageView.mas_left);
            make.right.equalTo(imageView.mas_right);
            make.height.equalTo(@(FoodName_Height));
        }];
        
        // 食物名称
        _foodName = [[UILabel alloc] init];
        _foodName.text = foodModel.food_name;
        _foodName.textColor = [UIColor whiteColor];
        _foodName.font = [UIFont systemFontOfSize:18];
        [imageView addSubview:_foodName];
        
        // 适配食物名称
        [_foodName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(imageView.mas_left).offset(10);
            make.height.equalTo(@(FoodName_Height));
            make.bottom.equalTo(imageView.mas_bottom);
        }];
    }
    
    // 适配页码指示器
    [_pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-20);
        make.centerY.equalTo(_coverView.mas_centerY);
    }];
    
    // 设置页码数
    _pageControl.numberOfPages = self.imageArray.count - 2;
    _pageControl.currentPage = 0;
    
    // 当前页码
    _currentPage = 1;
    
    // 开始轮播
    [self startTimer];
}

#pragma mark - 图片单击手势
- (void)tapAction:(UITapGestureRecognizer *)tapGesture {
    
    NSInteger index = tapGesture.view.tag - 100;
    if (index == 0) {
        index = self.imageArray.count - 2;
    } else if (index == self.imageArray.count - 1) {
        index = 0;
    } else {
        index--;
    }
    
    // 首页广告栏回调方法
    if (self.ShowFoodDetailAction) {
        self.ShowFoodDetailAction(index);
    }
}

#pragma mark - UIScrollView delegate
#pragma mark 结束滚动后计算偏移
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    _currentPage = scrollView.contentOffset.x / KScreenSize.width;
    
    _pageControl.currentPage = _currentPage - 1;
    
    [self updateScrollViewContentOffset];

}

#pragma mark 结束滚动动画后计算偏移
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    
    _currentPage = scrollView.contentOffset.x / KScreenSize.width;
    
    _pageControl.currentPage = _currentPage - 1;
    
    [self updateScrollViewContentOffset];
}

#pragma mark 拖拽时停止计时器
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    if (scrollView == self.scrollView) {
        [self stopTimer];
    }
}

#pragma mark 结束拖拽时开启计时器
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (scrollView == self.scrollView) {
        [self startTimer];
    }
}

#pragma mark 循环处理
- (void)updateScrollViewContentOffset {
    
    if (_currentPage == self.imageArray.count - 1) {
        _currentPage = 1;
    } else if (_currentPage == 0) {
        _currentPage = self.imageArray.count - 2;
    }
    
    _scrollView.contentOffset = CGPointMake(_currentPage * KScreenSize.width, 0);
    _pageControl.currentPage = _currentPage - 1;
}

#pragma mark - 计时器方法
- (void)updateBannerImage {
    [_scrollView setContentOffset:CGPointMake(_scrollView.contentOffset.x + KScreenSize.width, 0) animated:YES];
}

- (void)startTimer {
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(updateBannerImage) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
}

- (void)stopTimer {
    [_timer invalidate];
    _timer = nil;
}

@end
