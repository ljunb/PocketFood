//
//  LJBMainTopicCell.m
//  PocketFood
//
//  Created by qf on 15/11/17.
//  Copyright © 2015年 qf. All rights reserved.
//

#import "LJBMainTopicCell.h"
#import "UIImageView+WebCache.h"
#import "LJBMainTopic.h"

#define Left_Gap 20
#define V_Gap 10

#define Image_Width KScreenSize.height / 3.0 / 2.0 - V_Gap*2

#define Label_Height 20
#define Label_Width 40

@interface LJBMainTopicCell ()

/**
 *  菜式图片
 */
@property (nonatomic, strong) UIImageView * topicImage;

/**
 *  菜式名称
 */
@property (nonatomic, strong) UILabel * title;

/**
 *  菜式描述
 */
@property (nonatomic, strong) UILabel * subTitle;

/**
 *  菜式数量
 */
@property (nonatomic, strong) UILabel * pageCount;


@end

@implementation LJBMainTopicCell

#pragma mark - 工厂方法
+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    static NSString * ID = @"main_topic_cell";
    
    LJBMainTopicCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[LJBMainTopicCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
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
    // 菜式图片
    _topicImage = [[UIImageView alloc] init];
    [self.contentView addSubview:_topicImage];
    
    // 适配图片
    [_topicImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(Left_Gap);
        make.top.equalTo(self.contentView.mas_top).offset(V_Gap);
        make.width.equalTo(@(Image_Width));
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-V_Gap);
    }];
    
    // 菜式名称
    _title = [[UILabel alloc] init];
    _title.font = [UIFont systemFontOfSize:18];
    [self.contentView addSubview:_title];
    
    // 适配菜式名称
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_topicImage.mas_right).offset(V_Gap);
        make.top.equalTo(_topicImage.mas_top).offset(V_Gap);
        make.right.equalTo(self.contentView.mas_right).offset(-V_Gap);
        make.height.equalTo(@(Label_Height));
    }];
    
    // 菜式描述
    _subTitle = [[UILabel alloc] init];
    _subTitle.font = [UIFont systemFontOfSize:16];
    _subTitle.textColor = [UIColor darkGrayColor];
    _subTitle.numberOfLines = 0;
    [self.contentView addSubview:_subTitle];
    
    // 适配菜式描述
    [_subTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_topicImage.mas_right).offset(V_Gap);
        make.right.equalTo(self.contentView.mas_right).offset(-Left_Gap);
        make.bottom.equalTo(_topicImage.mas_bottom).offset(-V_Gap);
        make.top.equalTo(_topicImage.mas_top).offset(V_Gap);
    }];
    
    // 菜式数量
    _pageCount = [[UILabel alloc] init];
    _pageCount.layer.borderColor = [UIColor orangeColor].CGColor;
    _pageCount.layer.borderWidth = 1;
    _pageCount.layer.cornerRadius = 4;
    _pageCount.layer.masksToBounds = YES;
    _pageCount.textColor = [UIColor orangeColor];
    _pageCount.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_pageCount];
    
    // 适配菜式数量
    [_pageCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-Left_Gap);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-V_Gap);
        make.height.equalTo(@(Label_Height));
        make.width.equalTo(@(Label_Width));
    }];
}

#pragma mark - 配置cell内容
- (void)configCellWithModel:(LJBMainTopic *)model {
    
    // 图片
    [_topicImage sd_setImageWithURL:[NSURL URLWithString:model.image_url] placeholderImage:[UIImage imageNamed:@"img_default_topic_cover"]];
    
    // 名称
    _title.text = model.title;
    
    // 描述
    _subTitle.text = model.sub_title;
    
    // 数量
    _pageCount.text = model.page_count;
}

@end
