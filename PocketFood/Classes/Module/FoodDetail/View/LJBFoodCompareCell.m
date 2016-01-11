//
//  LJBFoodCompareCell.m
//  PocketFood
//
//  Created by qf on 15/11/19.
//  Copyright © 2015年 qf. All rights reserved.
//

#import "LJBFoodCompareCell.h"
#import "LJBFood.h"
#import "LJBFoodCompare.h"
#import "UIImageView+WebCache.h"

#define Label_Height 20
#define Image_Width 50
#define Gap 10

@interface LJBFoodCompareCell ()

/**
 *  食物图片
 */
@property (nonatomic, strong) UIImageView * foodImage;

/**
 *  X号
 */
@property (nonatomic, strong) UILabel * symbol;

/**
 *  数量
 */
@property (nonatomic, strong) UILabel * amount;

/**
 *  比较结果文本
 */
@property (nonatomic, strong) UILabel * compareText;

@end

@implementation LJBFoodCompareCell

#pragma mark - 工厂方法
+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    static NSString * ID = @"food_compare_cell";
    
    LJBFoodCompareCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[LJBFoodCompareCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
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
    
    // 图片
    [self.foodImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(Gap);
        make.left.equalTo(self.contentView.mas_left).offset(Gap);
        make.width.equalTo(@(Image_Width));
        make.height.equalTo(@(Image_Width));
    }];
    
    // 符号
    [self.symbol mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(Gap+5);
        make.left.equalTo(self.contentView.mas_left).offset(Gap*7);
        make.height.equalTo(@(Label_Height));
    }];

    // 数量
    [self.amount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.symbol.mas_bottom).offset(-2);
        make.left.equalTo(self.symbol.mas_left).offset(Gap);
        make.height.equalTo(@(Label_Height));
    }];

    // 比较文本
    [self.compareText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.foodImage.mas_right).offset(Gap);
        make.top.equalTo(self.symbol.mas_bottom);
        make.right.equalTo(self.contentView.mas_right).offset(-5);
//        make.height.equalTo(@(Label_Height));
    }];
    
}

#pragma mark - 重写setter方法
- (void)setModel:(LJBFood *)model {
    
    _model = model;
    
    LJBFoodCompare * compareModel = _model.compare;
    
    [self.foodImage sd_setImageWithURL:[NSURL URLWithString:compareModel.target_image_url] placeholderImage:[UIImage imageNamed:@"img_default_food_thumbnail"]];
    
    self.symbol.text = @"X";
    
    self.amount.text = compareModel.amount1;
    
    self.compareText.text = [NSString stringWithFormat:@"%@%@%@ ≈ %@%@%@", compareModel.amount0, compareModel.unit0, _model.name, compareModel.amount1, compareModel.unit1, compareModel.target_name];
}

#pragma mark - getter
- (UIImageView *)foodImage {
    
    if (!_foodImage) {
        _foodImage = [[UIImageView alloc] init];
        [self.contentView addSubview:_foodImage];
    }
    return _foodImage;
}

- (UILabel *)symbol {
    
    if (!_symbol) {
        _symbol = [[UILabel alloc] init];
        _symbol.font = [UIFont systemFontOfSize:13];
        _symbol.textColor = [UIColor darkGrayColor];
        [self.contentView addSubview:_symbol];
    }
    return _symbol;
}

- (UILabel *)amount {
    
    if (!_amount) {
        _amount = [[UILabel alloc] init];
        _amount.font = [UIFont systemFontOfSize:20];
        _amount.textColor = KColor(246, 53, 56);
        [self.contentView addSubview:_amount];
    }
    return _amount;
}

- (UILabel *)compareText {
    
    if (!_compareText) {
        _compareText = [[UILabel alloc] init];
        _compareText.font = [UIFont systemFontOfSize:13];
        _compareText.numberOfLines = 0;
        _compareText.textColor = [UIColor darkGrayColor];
        [self.contentView addSubview:_compareText];
    }
    return _compareText;
}

@end
