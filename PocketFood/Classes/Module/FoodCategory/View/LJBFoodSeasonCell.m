//
//  LJBFoodSeasonCell.m
//  PocketFood
//
//  Created by qf on 15/11/21.
//  Copyright © 2015年 qf. All rights reserved.
//

#import "LJBFoodSeasonCell.h"
#import "UIImageView+WebCache.h"
#import "LJBFoodGroupCategory.h"

@interface LJBFoodSeasonCell ()

/**
 *  季节图片
 */
@property (nonatomic, strong) UIImageView * seasonImage;

 /**
 *  季节名称
 */
@property (nonatomic, strong) UILabel * seasonName;

/**
 *  季节描述
 */
@property (nonatomic, strong) UILabel * seasonDesc;

@end

@implementation LJBFoodSeasonCell

#pragma mark - 工厂方法
+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    static NSString * ID = @"food_category_season_cell";
    
    LJBFoodSeasonCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[LJBFoodSeasonCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
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
    
    // 季节图片
    [self.seasonImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(9);
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-9);
        make.width.equalTo(@40);
    }];
    
    // 季节名称
    [self.seasonName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(5);
        make.left.equalTo(self.seasonImage.mas_right).offset(10);
        make.height.equalTo(@20);
    }];
    
    // 季节描述
    [self.seasonDesc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.seasonImage.mas_right).offset(10);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-5);
        make.height.equalTo(@20);
    }];
}

#pragma mark - 重写setter方法
- (void)setCategoryModel:(LJBFoodGroupCategory *)categoryModel {
 
    _categoryModel = categoryModel;
    
    [self.seasonImage sd_setImageWithURL:[NSURL URLWithString:_categoryModel.image_url]];
    
    self.seasonName.text = _categoryModel.name;
    
    self.seasonDesc.text = _categoryModel.Description;
}

#pragma mark - getter
- (UIImageView *)seasonImage {
    
    if (!_seasonImage) {
        _seasonImage = [[UIImageView alloc] init];
        [self.contentView addSubview:_seasonImage];
    }
    return _seasonImage;
}

- (UILabel *)seasonName {
    
    if (!_seasonName) {
        _seasonName = [[UILabel alloc] init];
        [self.contentView addSubview:_seasonName];
    }
    return _seasonName;
}

- (UILabel *)seasonDesc {
    
    if (!_seasonDesc) {
        _seasonDesc = [[UILabel alloc] init];
        _seasonDesc.font = [UIFont systemFontOfSize:13];
        _seasonDesc.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_seasonDesc];
    }
    return _seasonDesc;
}

@end
