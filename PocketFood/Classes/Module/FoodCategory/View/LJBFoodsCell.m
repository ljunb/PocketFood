//
//  LJBFoodsCell.m
//  PocketFood
//
//  Created by qf on 15/11/21.
//  Copyright © 2015年 qf. All rights reserved.
//

#import "LJBFoodsCell.h"
#import "LJBFood.h"
#import "UIImageView+WebCache.h"

#define Image_Width 40
#define Gap 10

@interface LJBFoodsCell ()
/**
 *  食物图片
 */
@property (nonatomic, strong) UIImageView * foodImage;
/**
 *  食物名称
 */
@property (nonatomic, strong) UILabel * foodName;
/**
 *  食物热量
 */
@property (nonatomic, strong) UILabel * foodCalory;
/**
 *  食物单位
 */
@property (nonatomic, strong) UILabel * foodUnit;

/**
 *  食物健康等级
 */
@property (nonatomic, strong) UIImageView * healthImage;

@end


@implementation LJBFoodsCell

#pragma mark - 工厂方法
+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    static NSString * ID = @"foods_cell";
    
    LJBFoodsCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[LJBFoodsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
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
    
    // 食物图片
    [self.foodImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(Gap);
        make.left.equalTo(self.contentView.mas_left).offset(Gap);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-Gap);
        make.width.equalTo(@(Image_Width));
    }];
    
    // 食物名称
    [self.foodName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(Gap);
        make.left.equalTo(self.foodImage.mas_right).offset(Gap);
        make.right.equalTo(self.contentView.mas_right).offset(-Gap*3);
        make.height.equalTo(@20);
    }];
    
    // 食物热量
    [self.foodCalory mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.foodName.mas_bottom).offset(3);
        make.left.equalTo(self.foodImage.mas_right).offset(Gap);
        make.height.equalTo(@20);
    }];
    
    // 食物热量单位
    [self.foodUnit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.foodName.mas_bottom).offset(3);
        make.left.equalTo(self.foodCalory.mas_right).offset(2);
        make.height.equalTo(@20);
    }];

    // 食物健康等级图片
    [self.healthImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.right.equalTo(self.contentView.mas_right).offset(-Gap-5);
        make.height.equalTo(@10);
        make.width.equalTo(@10);
    }];
}

#pragma mark - 配置cell
- (void)configCellWithModel:(LJBFood *)foodModel orderBy:(NSInteger)orderIndex {
    
    [self.foodImage sd_setImageWithURL:[NSURL URLWithString:foodModel.thumb_image_url] placeholderImage:[UIImage imageNamed:@"img_default_food_thumbnail"]];
    
    self.foodName.text = foodModel.name;
    
    [self setDataWithOrderIndex:orderIndex foodModel:foodModel];
    
    [self setHealthImageWithFoodModel:foodModel];
}

#pragma mark 设置显示的营养元素和单位
- (void)setDataWithOrderIndex:(NSInteger)index foodModel:(LJBFood *)foodModel {
    
    switch (index) {
        case 1:
        case 2:
        {
            self.foodCalory.text = foodModel.calory;
            self.foodUnit.text = @"大卡/100克";
        }
            break;
        case 3:
        {
            self.foodCalory.text = foodModel.protein;
            self.foodUnit.text = @"克/100克";
        }
            break;
        case 4:
        {
            self.foodCalory.text = foodModel.fat;
            self.foodUnit.text = @"克/100克";
        }
            break;
        default:
            break;
    }
    if (!self.foodCalory.text.length) {
        self.foodCalory.text = @"0.0";
    }
}

#pragma mark 设置对应的健康等级图标
- (void)setHealthImageWithFoodModel:(LJBFood *)foodModel {
    
    if ([foodModel.health_light isEqualToString:@"1"]) {
        
        self.healthImage.image = [UIImage imageNamed:@"ic_food_light_green"];
        
    } else if ([foodModel.health_light isEqualToString:@"2"]) {
        
        self.healthImage.image = [UIImage imageNamed:@"ic_food_light_yellow"];
        
    } else {
        
        self.healthImage.image = [UIImage imageNamed:@"ic_food_light_red"];
    }
}

#pragma mark - getter
- (UIImageView *)foodImage {
    
    if (!_foodImage) {
        _foodImage = [[UIImageView alloc] init];
        _foodImage.layer.cornerRadius = Image_Width/2;
        _foodImage.layer.masksToBounds = YES;
        [self.contentView addSubview:_foodImage];
    }
    return _foodImage;
}

- (UILabel *)foodName {
    
    if (!_foodName) {
        _foodName = [[UILabel alloc] init];
        _foodName.font = [UIFont systemFontOfSize:16];
        _foodName.lineBreakMode = NSLineBreakByTruncatingMiddle;
        [self.contentView addSubview:_foodName];
    }
    return _foodName;
}

- (UILabel *)foodCalory {
    
    if (!_foodCalory) {
        _foodCalory = [[UILabel alloc] init];
        _foodCalory.font = [UIFont systemFontOfSize:13];
        _foodCalory.textColor = [UIColor redColor];
        [self.contentView addSubview:_foodCalory];
    }
    return _foodCalory;
}

- (UILabel *)foodUnit {
    
    if (!_foodUnit) {
        _foodUnit = [[UILabel alloc] init];
        _foodUnit.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_foodUnit];
    }
    return _foodUnit;
}

- (UIImageView *)healthImage {
    
    if (!_healthImage) {
        _healthImage = [[UIImageView alloc] init];
        [self.contentView addSubview:_healthImage];
    }
    return _healthImage;
}

@end
