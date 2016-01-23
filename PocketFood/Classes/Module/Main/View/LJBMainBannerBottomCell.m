//
//  LJBMainBannerBottomCell.m
//  PocketFood
//
//  Created by qf on 15/11/17.
//  Copyright © 2015年 qf. All rights reserved.
//

#import "LJBMainBannerBottomCell.h"
#import "UIImageView+WebCache.h"
#import "LJBMainFood.h"

#define Gap 10
#define Image_Width KScreenSize.height / 3.0 / 2.0 - Gap*2

@interface LJBMainBannerBottomCell () <UIScrollViewDelegate>

/**
 *  装载图片的滚动视图
 */
@property (nonatomic, strong) UIScrollView * scrollView;

/**
 *  装载模型的数组
 */
@property (nonatomic, strong) NSMutableArray * models;

@end


@implementation LJBMainBannerBottomCell

- (NSMutableArray *)models {
    
    if (!_models) {
        _models = [NSMutableArray array];
    }
    return _models;
}

#pragma mark - 工厂方法
+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    static NSString * ID = @"main_banner_bottom_cell";
    
    LJBMainBannerBottomCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[LJBMainBannerBottomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
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

#pragma mark - 添加子控件
- (void)addSubviews {
    
    // 滚动视图
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.delegate = self;
    _scrollView.bounces = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    [self.contentView addSubview:_scrollView];
    
    // 适配滚动视图
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
}


#pragma mark - 配置图片资源
- (void)configCellWithImages:(NSArray *)images {
    
    if (self.models.count) {
        [self.models removeAllObjects];
    }
    
    [self.models addObjectsFromArray:images];
    
    UIImageView * lastImgView;
    for (NSInteger i = 0; i < images.count; i++) {
        
        // 获得模型
        LJBMainFood * foodModel = images[i];
        
        // 添加图片视图
        UIImageView * imageView = [[UIImageView alloc] init];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.tag = 100 + i;
        [self.scrollView addSubview:imageView];
        
        // 适配图片
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            if (lastImgView) {
                make.left.equalTo(lastImgView.mas_right).offset(Gap);
            } else {
                make.left.equalTo(@(Gap));
            }
            
            make.top.equalTo(_scrollView.mas_top).offset(Gap);
            make.height.equalTo(@(Image_Width));
            make.width.equalTo(@(Image_Width));
        }];
        lastImgView = imageView;
        
        // 设置图片内容
        [imageView sd_setImageWithURL:[NSURL URLWithString:foodModel.image_url] placeholderImage:[UIImage imageNamed:@"img_default_home_cover"]];
        
        // 添加单击手势
        imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [imageView addGestureRecognizer:tap];
    }
    
    _scrollView.contentSize = CGSizeMake(images.count * (Image_Width + Gap) + Gap, 0);
    
}

- (void)tapAction:(UITapGestureRecognizer *)tapGesture {
    NSInteger index = tapGesture.view.tag - 100;
    
    if (self.ShowFoodDetailAction) {
        self.ShowFoodDetailAction(index);
    }
}


@end
