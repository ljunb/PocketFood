//
//  LJBTopicHeaderView.m
//  PocketFood
//
//  Created by qf on 15/11/20.
//  Copyright © 2015年 qf. All rights reserved.
//

#import "LJBTopicHeaderView.h"

@interface LJBTopicHeaderView ()

@property (nonatomic, strong) UIView * lineView;

@property (nonatomic, strong) UILabel * topicTitle;

@property (nonatomic, strong) UILabel * moreTopic;

@property (nonatomic, strong) UIImageView * moreImage;



@end

@implementation LJBTopicHeaderView

+ (instancetype)sectionViewWithTableView:(UITableView *)tableView {
    
    static NSString * ID = @"main_topic_section";
    
    LJBTopicHeaderView * sectionView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    if (!sectionView) {
        sectionView = [[LJBTopicHeaderView alloc] initWithReuseIdentifier:ID];
    }
    return sectionView;
}

#pragma mark - 重写初始化方法
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self addSubviews];
    }
    return self;
}

#pragma mark - 适配子控件
- (void)addSubviews {
    
    // 竖条
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(2);
        make.left.equalTo(self.contentView.mas_left);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-2);
        make.width.equalTo(@5);
    }];
    
    // 推荐专题
    [self.topicTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top);
        make.left.equalTo(self.lineView.mas_left).offset(10);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
    self.topicTitle.text = @"推荐专题";
    
    // img_topic_more
    [self.moreImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
        make.width.equalTo(@15);
    }];
    self.moreImage.image = [UIImage imageNamed:@"ic_bullet_dark"];
    
    [self.moreTopic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.right.equalTo(self.moreImage.mas_left).offset(-5);
    }];
    self.moreTopic.text = @"查看更多";
    
    UIView * coverView = [[UIView alloc] init];
    [self.contentView addSubview:coverView];
    [coverView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top);
        make.left.equalTo(self.moreTopic.mas_left);
        make.right.equalTo(self.moreImage.mas_right);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(moreTopicAction)];
    [coverView addGestureRecognizer:tap];
}

#pragma mark 查看更多手势方法
- (void)moreTopicAction {
    
    // 调用block
    if (self.ShowMoreTopicAction) {
        self.ShowMoreTopicAction();
    }
}

#pragma mark - getter
- (UIView *)lineView {
    
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_lineView];
    }
    return _lineView;
}

- (UILabel *)topicTitle {
    
    if (!_topicTitle) {
        _topicTitle = [[UILabel alloc] init];
        _topicTitle.font = [UIFont systemFontOfSize:15];
        _topicTitle.textColor = [UIColor redColor];
        [self.contentView addSubview:_topicTitle];
    }
    return _topicTitle;
}

- (UILabel *)moreTopic {
    
    if (!_moreTopic) {
        _moreTopic = [[UILabel alloc] init];
        _moreTopic.font = [UIFont systemFontOfSize:14];
        _moreTopic.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_moreTopic];
    }
    return _moreTopic;
}

- (UIImageView *)moreImage {
    
    if (!_moreImage) {
        _moreImage = [[UIImageView alloc] init];
        [self.contentView addSubview:_moreImage];
    }
    return _moreImage;
}


@end
