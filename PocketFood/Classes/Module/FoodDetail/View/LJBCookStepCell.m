//
//  LJBFoodStepCell.m
//  PocketFood
//
//  Created by qf on 15/11/20.
//  Copyright © 2015年 qf. All rights reserved.
//

#import "LJBCookStepCell.h"
#import "UIImageView+WebCache.h"
#import "LJBCookStep.h"

#define Image_Width 100
#define Image_Height 80
#define Gap 10

@interface LJBCookStepCell ()
/**
 *  做法图片
 */
@property (nonatomic, strong) UIImageView * stepImage;

/**
 *  步骤
 */
@property (nonatomic, strong) UILabel * position;

/**
 *  步骤内容
 */
@property (nonatomic, strong) UILabel * desc;

@end



@implementation LJBCookStepCell

#pragma mark - 工厂方法
+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    static NSString * ID = @"food_step_cell";
    
    LJBCookStepCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[LJBCookStepCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubviews];
    }
    return self;
}

#pragma mark - 适配子控件
- (void)addSubviews {
    
    // 步骤图片
    [self.stepImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(Gap);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.width.equalTo(@(Image_Width));
        make.height.equalTo(@(Image_Height));
    }];
    
    // 步骤顺序
    [self.position mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(Gap+2);
        make.left.equalTo(self.stepImage.mas_right).offset(Gap);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
    }];
    
    // 步骤内容
    [self.desc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(Gap);
        make.left.equalTo(self.position.mas_right).offset(5);
        make.right.equalTo(self.contentView.mas_right).offset(-Gap);
    }];
}

#pragma mark - 重写setter方法
- (void)setStepModel:(LJBCookStep *)stepModel {
    
    _stepModel = stepModel;
    
    [self.stepImage sd_setImageWithURL:[NSURL URLWithString:_stepModel.image_url] placeholderImage:[UIImage imageNamed:@"img_default_topic_banner"]];
    
    self.position.text = _stepModel.position;
    
    self.desc.text = _stepModel.desc;
}

#pragma mark - getter
- (UIImageView *)stepImage {
    
    if (!_stepImage) {
        _stepImage = [[UIImageView alloc] init];
        [self.contentView addSubview:_stepImage];
    }
    return _stepImage;
}

- (UILabel *)position {
    
    if (!_position) {
        _position = [[UILabel alloc] init];
        _position.textColor = [UIColor darkGrayColor];
        _position.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_position];
    }
    return _position;
}

- (UILabel *)desc {
    
    if (!_desc) {
        _desc = [[UILabel alloc] init];
        _desc.numberOfLines = 0;
        _desc.font = [UIFont systemFontOfSize:14];
        _desc.textColor = [UIColor blackColor];
        [self.contentView addSubview:_desc];
    }
    return _desc;
}

@end
