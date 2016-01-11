//
//  LJBFoodNameCell.m
//  PocketFood
//
//  Created by qf on 15/11/18.
//  Copyright © 2015年 qf. All rights reserved.
//  食物名称cell

#import "LJBFoodNameCell.h"
#import "LJBFood.h"
#import "UIImageView+WebCache.h"

#define V_Gap 10
#define Image_Width 40
#define Label_Height 20

@interface LJBFoodNameCell ()

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
@property (nonatomic, strong) UILabel * caloryUnit;

/**
 *  大卡按钮-热量单位
 */
@property (nonatomic, strong) UIButton * kilocalorieBtn;

/**
 *  千焦按钮
 */
@property (nonatomic, strong) UIButton * jouleBtn;

/**
 *  指示View
 */
@property (nonatomic, strong) UIView * indicatorView;

/**
 *  当前按钮
 */
@property (nonatomic, strong) UIButton * currentBtn;

@end

@implementation LJBFoodNameCell

#pragma mark - 工厂方法
+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    static NSString * ID = @"food_name_cell";
    
    LJBFoodNameCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[LJBFoodNameCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - 重写初始化方法
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addFoodView];
        [self addButtonView];
    }
    return self;
}

#pragma mark 添加子控件
- (void)addFoodView {
    
    // 适配食物图片
    [self.foodImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(V_Gap);
        make.left.equalTo(self.contentView.mas_left).offset(V_Gap+5);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-V_Gap);
        make.width.equalTo(@(Image_Width));
    }];
    
    // 适配食物名称
    [self.foodName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(V_Gap);
        make.left.equalTo(self.foodImage.mas_right).offset(V_Gap);
        make.right.lessThanOrEqualTo(self.contentView.mas_right).offset(-V_Gap*2);
        make.height.equalTo(@(Label_Height));
    }];
    
    // 适配食物热量
    [self.foodCalory mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.foodName.mas_bottom);
        make.left.equalTo(self.foodName.mas_left);
        make.height.equalTo(@(Label_Height));
    }];
    
    // 适配食物热量单位
    [self.caloryUnit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.foodName.mas_bottom);
        make.left.equalTo(self.foodCalory.mas_right);
        make.height.equalTo(@(Label_Height));
    }];
    self.caloryUnit.text = @" 大卡/100克";
    
    // 热量备注
    UILabel * content = [[UILabel alloc] init];
    content.font = [UIFont systemFontOfSize:13];
    content.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:content];
    // 适配
    [content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.foodName.mas_bottom);
        make.left.equalTo(self.caloryUnit.mas_right);
        make.height.equalTo(@(Label_Height));
    }];
    content.text = @"(可食用部分)";
}

#pragma mark - 热量单位选择按钮
- (void)addButtonView {
    
    // 千焦按钮
    [self.jouleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.foodName.mas_bottom);
        make.right.equalTo(self.contentView.mas_right).offset(-V_Gap/2);
        make.height.equalTo(@(Label_Height));
    }];
    
    // 大卡按钮
    [self.kilocalorieBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.foodName.mas_bottom);
        make.right.equalTo(self.jouleBtn.mas_left);
        make.height.equalTo(@(Label_Height));
    }];
    
    // 按钮指示器，初始位置显示在大卡下
    self.indicatorView.frame = CGRectMake(KScreenSize.width - 63, 48, 24, 3);
    
    _currentBtn = self.kilocalorieBtn;
    _currentBtn.enabled = NO;
}

#pragma mark - 调节指示器位置
- (void)fittingIndicatorViewWithButton:(UIButton *)button {
    
    self.indicatorView.frame = CGRectMake(button.frame.origin.x+2, CGRectGetMaxY(button.frame)-2, button.bounds.size.width-4, 3);
}

#pragma mark - 配置cell
- (void)setModel:(LJBFood *)model {
    
    _model = model;
    
    [self.foodImage sd_setImageWithURL:[NSURL URLWithString:model.thumb_image_url] placeholderImage:[UIImage imageNamed:@"img_default_food_thumbnail"]];
    
    self.foodName.text = model.name;
    
    self.foodCalory.text = model.calory;
}

#pragma mark - 热量单位按钮事件
- (void)caloryBtnAction:(UIButton *)button {
    
    _currentBtn.enabled = YES;
    _currentBtn = button;
    _currentBtn.enabled = NO;
    
    // 1卡 = 4.18千焦；
    if (_currentBtn == self.kilocalorieBtn) {
        // 大卡单位
        self.caloryUnit.text = @" 大卡/100克";
        self.foodCalory.text = self.model.calory;
    } else {
        // 千焦单位
        self.caloryUnit.text = @" 千焦/100克";
        self.foodCalory.text = [NSString stringWithFormat:@"%.f", [self.model.calory integerValue] * 4.18];
    }
    
    // 适配指示器
    [self fittingIndicatorViewWithButton:_currentBtn];
}

#pragma mark - getter
- (UIImageView *)foodImage {
    
    if (!_foodImage) {
        _foodImage = [[UIImageView alloc] init];
        [self.contentView addSubview:_foodImage];
    }
    return _foodImage;
}

- (UILabel *)foodName {
    
    if (!_foodName) {
        _foodName = [[UILabel alloc] init];
        _foodName.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_foodName];
    }
    return _foodName;
}

- (UILabel *)foodCalory {
    
    if (!_foodCalory) {
        _foodCalory = [[UILabel alloc] init];
        _foodCalory.textColor = [UIColor redColor];
        _foodCalory.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_foodCalory];
    }
    return _foodCalory;
}

- (UILabel *)caloryUnit {
    
    if (!_caloryUnit) {
        _caloryUnit = [[UILabel alloc] init];
        _caloryUnit.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_caloryUnit];
    }
    return _caloryUnit;
}

- (UIButton *)kilocalorieBtn {
    
    if (!_kilocalorieBtn) {
        _kilocalorieBtn = [[UIButton alloc] init];
        [_kilocalorieBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_kilocalorieBtn setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        [_kilocalorieBtn setTitle:@"大卡" forState:UIControlStateNormal];
        _kilocalorieBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        
        [_kilocalorieBtn addTarget:self action:@selector(caloryBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_kilocalorieBtn];
    }
    return _kilocalorieBtn;
}

- (UIButton *)jouleBtn {
    
    if (!_jouleBtn) {
        _jouleBtn = [[UIButton alloc] init];
        [_jouleBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_jouleBtn setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        [_jouleBtn setTitle:@"千焦" forState:UIControlStateNormal];
        _jouleBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        
        [_jouleBtn addTarget:self action:@selector(caloryBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_jouleBtn];
    }
    return _jouleBtn;
}

- (UIView *)indicatorView {
    
    if (!_indicatorView) {
        _indicatorView = [[UIView alloc] init];
        _indicatorView.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_indicatorView];
    }
    return _indicatorView;
}

@end
