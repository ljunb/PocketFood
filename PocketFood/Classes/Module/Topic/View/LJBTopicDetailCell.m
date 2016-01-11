//
//  LJBTopicDetailCell.m
//  PocketFood
//
//  Created by qf on 15/11/18.
//  Copyright © 2015年 qf. All rights reserved.
//  专题详情cell

#import "LJBTopicDetailCell.h"
#import "UIImageView+WebCache.h"
#import "LJBTopicPage.h"
#import "LJBTopicPageFrame.h"

@interface LJBTopicDetailCell ()

/**
 *  加载内容的滚动视图
 */
@property (nonatomic, strong) UIScrollView * scrollView;

/**
 *  菜式图片
 */
@property (nonatomic, strong) UIImageView * topicImage;

/**
 *  食物名称
 */
@property (nonatomic, strong) UILabel * name;

/**
 *  菜式内容
 */
@property (nonatomic, strong) UILabel * content;

/**
 *  查看详情按钮
 */
@property (nonatomic, strong) UIButton * showDetail;

@end

@implementation LJBTopicDetailCell

#pragma mark - 布局子控件
- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 适配子控件
    [self settingSubviewsFrame];
}

- (void)settingSubviewsFrame {
    // 滚动视图
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(20, 0, 30, 0));
    }];
    
    // 美食图片
    [self.topicImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.scrollView.mas_top);
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.height.equalTo(self.contentView.mas_height).multipliedBy(0.4);
    }];
    
    // 美食名称
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topicImage.mas_bottom).offset(10);
        make.left.equalTo(self.topicImage.mas_left).offset(10);
        make.right.equalTo(self.topicImage.mas_right).offset(-10);
        make.height.equalTo(@30);
    }];
    
    // 美食描述
    [self.content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.name.mas_bottom).offset(10);
        make.left.equalTo(self.name.mas_left);
        make.right.equalTo(self.name.mas_right);
    }];
    
}

#pragma mark - 配置cell
- (void)configCellWithModel:(LJBTopicPageFrame *)model {
    
    [self.topicImage sd_setImageWithURL:[NSURL URLWithString:model.model.image_url] placeholderImage:[UIImage imageNamed:@"img_default_topic_banner"]];
    
    self.name.text = model.model.food_name;
    
    self.content.text = model.model.Description;
    
    // 查看详情按钮
    [self.showDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.content.mas_bottom).offset(20);
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.height.equalTo(@35);
        make.width.equalTo(@120);
    }];
    
    self.scrollView.contentSize = CGSizeMake(0, model.contentHeight);
}

#pragma mark - 查看详情按钮事件
- (void)showDetailAction {
    
    if (self.ShowFoodDetailAction) {
        self.ShowFoodDetailAction();
    }
}

#pragma mark - getter
- (UIScrollView *)scrollView {
    
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.bounces = NO;
        [self.contentView addSubview:_scrollView];
    }
    return _scrollView;
}

- (UIImageView *)topicImage {
    
    if (!_topicImage) {
        _topicImage = [[UIImageView alloc] init];
        [self.scrollView addSubview:_topicImage];
    }
    return _topicImage;
}

- (UILabel *)name {
    
    if (!_name) {
        _name = [[UILabel alloc] init];
        _name.textColor = KColor(246, 53, 56);
        _name.font = [UIFont systemFontOfSize:19];
        [self.scrollView addSubview:_name];
    }
    return _name;
}

- (UILabel *)content {
    
    if (!_content) {
        _content = [[UILabel alloc] init];
        _content.font = [UIFont systemFontOfSize:15];
        _content.numberOfLines = 0;
        [self.scrollView addSubview:_content];
    }
    return _content;
}

- (UIButton *)showDetail {
    
    if (!_showDetail) {
        _showDetail = [[UIButton alloc] init];
        _showDetail.backgroundColor = KColor(234, 82, 90);
        _showDetail.layer.cornerRadius = 4;
        _showDetail.layer.masksToBounds = YES;
        [_showDetail setTitle:@"查看详情" forState:UIControlStateNormal];
        _showDetail.titleLabel.font = [UIFont systemFontOfSize:15];
        
        [_showDetail addTarget:self action:@selector(showDetailAction) forControlEvents:UIControlEventTouchUpInside];
        
        [self.scrollView addSubview:_showDetail];
    }
    return _showDetail;
}

@end
