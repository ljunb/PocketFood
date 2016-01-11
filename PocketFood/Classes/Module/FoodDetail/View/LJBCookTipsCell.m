//
//  LJBCookTipsCell.m
//  PocketFood
//
//  Created by qf on 15/11/20.
//  Copyright © 2015年 qf. All rights reserved.
//  做法小贴士cell

#import "LJBCookTipsCell.h"

#define Gap 10

@interface LJBCookTipsCell ()

@property (nonatomic, strong) UIImageView * tipsBgView;

@property (nonatomic, strong) UILabel * tipsContent;

@end

@implementation LJBCookTipsCell

#pragma mark - 工厂方法
+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    static NSString * ID = @"cook_tips_cell";
    
    LJBCookTipsCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[LJBCookTipsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
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

#pragma mark - 适配子控件
- (void)addSubviews {
    
    // 背景
    UIView * coverView = [[UIView alloc] init];
    coverView.backgroundColor = [UIColor lightGrayColor];
    coverView.alpha = 0.3;
    [self.contentView addSubview:coverView];
    [coverView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    // 贴士图片
    [self.tipsBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(Gap);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-Gap);
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.width.equalTo(@(KScreenSize.width-(Gap+5)*4));
    }];
    self.tipsBgView.image = [UIImage imageNamed:@"img_tips_bg"];
    
    // 贴士标签
    UILabel * tips = [[UILabel alloc] init];
    tips.font = [UIFont systemFontOfSize:14];
    tips.textColor = [UIColor darkGrayColor];
    [self.contentView addSubview:tips];
    [tips mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tipsBgView.mas_top).offset(Gap);
        make.left.equalTo(self.tipsBgView.mas_left).offset(Gap);
        make.height.equalTo(@20);
    }];
    
    tips.text = @"小贴士";
    
    // 贴士内容
    [self.tipsContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tips.mas_bottom).offset(5);
        make.left.equalTo(self.tipsBgView.mas_left).offset(Gap);
        make.right.equalTo(self.tipsBgView.mas_right).offset(-Gap);
    }];
}

#pragma mark - 重写setter方法
- (void)setTipsText:(NSString *)tipsText {
    
    _tipsText = tipsText;
    
    self.tipsContent.text = _tipsText;
}

#pragma mark - getter
- (UIImageView *)tipsBgView {
    
    if (!_tipsBgView) {
        _tipsBgView = [[UIImageView alloc] init];
        [self.contentView addSubview:_tipsBgView];
    }
    return _tipsBgView;
}

- (UILabel *)tipsContent {
    
    if (!_tipsContent) {
        _tipsContent = [[UILabel alloc] init];
        _tipsContent.numberOfLines = 0;
        _tipsContent.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_tipsContent];
    }
    return _tipsContent;
}

@end
