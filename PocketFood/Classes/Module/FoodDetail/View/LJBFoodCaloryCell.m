//
//  LJBFoodCaloryCell.m
//  PocketFood
//
//  Created by qf on 15/11/19.
//  Copyright © 2015年 qf. All rights reserved.
//  食物热量cell

#import "LJBFoodCaloryCell.h"
#import "LJBFoodUnits.h"

#define Label_Height 20
#define Gap 10

@interface LJBFoodCaloryCell ()
/**
 *  数量
 */
@property (nonatomic, strong) UILabel * amount;
/**
 *  重量
 */
@property (nonatomic, strong) UILabel * weight;
/**
 *  热量
 */
@property (nonatomic, strong) UILabel * calory;

@end


@implementation LJBFoodCaloryCell

#pragma mark - 工厂方法
+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    static NSString * ID = @"food_calory_cell";
    
    LJBFoodCaloryCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[LJBFoodCaloryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
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
    
    // 适配数量
    [self.amount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.left.equalTo(self.contentView.mas_left).offset(Gap);
        make.height.equalTo(@(Label_Height));
    }];
    
    // 适配热量
    [self.calory mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.right.equalTo(self.contentView.mas_right).offset(-Gap);
        make.height.equalTo(@(Label_Height));
    }];
    
    // 适配重量
    [self.weight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.right.equalTo(self.calory.mas_left).offset(-Gap*2);
        make.height.equalTo(@(Label_Height));
    }];
}

- (void)setModel:(LJBFoodUnits *)model {
    
    _model = model;
    
    NSInteger amount = [_model.amount integerValue];
    self.amount.text = [NSString stringWithFormat:@"%ld %@", amount, _model.unit];
    
    self.weight.text = [NSString stringWithFormat:@"%ld 克", [_model.weight integerValue]];
    
    self.calory.text = [NSString stringWithFormat:@"%ld 大卡", [_model.calory integerValue]];
}

#pragma mark - getter
- (UILabel *)amount {
    
    if (!_amount) {
        _amount = [[UILabel alloc] init];
        _amount.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_amount];
    }
    return _amount;
}

- (UILabel *)weight {
    
    if (!_weight) {
        _weight = [[UILabel alloc] init];
        _weight.font = [UIFont systemFontOfSize:13];
        _weight.textColor = [UIColor darkGrayColor];
        [self.contentView addSubview:_weight];
    }
    return _weight;
}

- (UILabel *)calory {
    
    if (!_calory) {
        _calory = [[UILabel alloc] init];
        _calory.font = [UIFont systemFontOfSize:13];
        _calory.textColor = [UIColor darkGrayColor];
        [self.contentView addSubview:_calory];
    }
    return _calory;
}

@end
