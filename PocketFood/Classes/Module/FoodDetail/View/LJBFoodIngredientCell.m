//
//  LJBFoodIngredientCell.m
//  PocketFood
//
//  Created by qf on 15/11/19.
//  Copyright © 2015年 qf. All rights reserved.
//

#import "LJBFoodIngredientCell.h"
#import "LJBFoodLights.h"
#import "LJBFoodIngredient.h"
#import "LJBFood.h"

#define Gap 10
#define Label_Height 20

@interface LJBFoodIngredientCell ()

/**
 *  营养元素
 */
@property (nonatomic, strong) UILabel * name;

/**
 *  每100克
 */
@property (nonatomic, strong) UILabel * calory;

/**
 *  备注
 */
@property (nonatomic, strong) UILabel * comments;

/**
 *  营养元素字典
 */
@property (nonatomic, strong) NSDictionary * dict;

@end

@implementation LJBFoodIngredientCell

#pragma mark - 工厂方法
+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    static NSString * ID = @"food_ingredient_cell";
    
    LJBFoodIngredientCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[LJBFoodIngredientCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
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

    // 适配营养元素名称
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.left.equalTo(self.contentView.mas_left).offset(Gap);
        make.height.equalTo(@(Label_Height));
    }];
    
    // 适配重量
    [self.calory mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_centerX).offset(Gap*4);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.height.equalTo(@(Label_Height));
    }];
    
    // 适配备注
    [self.comments mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.right.equalTo(self.contentView.mas_right).offset(-Gap);
        make.height.equalTo(@(Label_Height));
    }];
    
    UIView * line = [UIView new];
    line.backgroundColor = [UIColor lightGrayColor];
    line.alpha = 0.5;
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.contentView);
        make.height.equalTo(@0.5);
    }];
}

#pragma mark - 配置cell
- (void)configCellWithFood:(LJBFood *)foodModel ingredient:(NSString *)ingredient {
    
    // 营养元素名称
    self.name.text = self.dict[ingredient];
    
    // 能量
    if ([ingredient isEqualToString:@"calory"]) {
        
        // 大卡/千焦
        NSInteger calory = [[foodModel.ingredient valueForKey:ingredient] integerValue];
        self.calory.text = [NSString stringWithFormat:@"%ld 大卡", calory];
        
    } else if ([ingredient isEqualToString:@"protein"]
               || [ingredient isEqualToString:@"fat"]
               || [ingredient isEqualToString:@"carbohydrate"]
               || [ingredient isEqualToString:@"fiber_dietary"]) {
        
        // 克单位
        CGFloat calory = [[foodModel.ingredient valueForKey:ingredient] floatValue];
        self.calory.text = [NSString stringWithFormat:@"%.1f 克", calory];
        
    } else if ([ingredient isEqualToString:@"selenium"]) {
        
        // 微克单位
        CGFloat calory = [[foodModel.ingredient valueForKey:ingredient] floatValue];
        self.calory.text = [NSString stringWithFormat:@"%.1f 微克", calory];
        
    } else {
        
        // 毫克单位
        CGFloat calory = [[foodModel.ingredient valueForKey:ingredient] floatValue];
        self.calory.text = [NSString stringWithFormat:@"%.1f 毫克", calory];
    }
    
    // 能量为空
    if (![[foodModel.ingredient valueForKey:ingredient] length]
        || [self.calory.text hasPrefix:@"0.0"]) {
        self.calory.text = @"--";
    }
    
    // 备注
    if ([ingredient isEqualToString:@"calory"]
        || [ingredient isEqualToString:@"protein"]
        || [ingredient isEqualToString:@"fat"]
        || [ingredient isEqualToString:@"carbohydrate"]
        || [ingredient isEqualToString:@"fiber_dietary"]) {
        LJBFoodLights * lights = foodModel.lights;
        self.comments.text = [lights valueForKey:ingredient];
    } else {
        self.comments.text = nil;
    }
}

#pragma mark - getter
- (UILabel *)name {
    
    if (!_name) {
        _name = [[UILabel alloc] init];
        _name.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_name];
    }
    return _name;
}

- (UILabel *)calory {
    
    if (!_calory) {
        _calory = [[UILabel alloc] init];
        _calory.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_calory];
    }
    return _calory;
}

- (UILabel *)comments {
    
    if (!_comments) {
        _comments = [[UILabel alloc] init];
        _comments.font = [UIFont systemFontOfSize:13];
        _comments.textColor = [UIColor darkGrayColor];
        [self.contentView addSubview:_comments];
    }
    return _comments;
}

- (NSDictionary *)dict {
    
    if (!_dict) {
        NSString * path = [[NSBundle mainBundle] pathForResource:@"IngredientDict.plist" ofType:nil];
        _dict = [NSDictionary dictionaryWithContentsOfFile:path];
    }
    return _dict;
}

@end
