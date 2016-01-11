//
//  LJBFoodAppraiseCell.m
//  PocketFood
//
//  Created by qf on 15/11/18.
//  Copyright © 2015年 qf. All rights reserved.
//  食物评价cell

#import "LJBFoodAppraiseCell.h"
#import "UIImageView+WebCache.h"
#import "LJBFood.h"

#define V_Gap 10

#define Image_Width 50
#define Image_Height 80

@interface LJBFoodAppraiseCell ()

/**
 *  评价图片
 */
@property (nonatomic, strong) UIImageView * appraiseImage;

/**
 *  评价内容
 */
@property (nonatomic, strong) UILabel * appraiseContent;

/**
 *  食物做法
 */
@property (nonatomic, strong) UIView * methodView;

/**
 *  食物做法label
 */
@property (nonatomic, strong) UILabel * methodText;

@end

@implementation LJBFoodAppraiseCell

#pragma mark - 工厂方法
+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    static NSString * ID = @"food_appraise_cell";
    
    LJBFoodAppraiseCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[LJBFoodAppraiseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
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
    
    // 评价图片
    [self.appraiseImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(V_Gap);
        make.left.equalTo(self.contentView.mas_left).offset(V_Gap);
        make.width.equalTo(@(Image_Width));
        make.height.equalTo(@(Image_Height));
    }];
    
    // 评价内容
    [self.appraiseContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(V_Gap);
        make.left.equalTo(self.appraiseImage.mas_right).offset(V_Gap);
        make.right.equalTo(self.contentView.mas_right).offset(-V_Gap);
    }];
#warning 屏蔽做法
//     食物做法
    [self.methodView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(-1);
        make.right.equalTo(self.contentView.mas_right).offset(1);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(1);
        make.height.equalTo(@40);
    }];
    
    // 做法文本
    [self.methodText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.methodView.mas_centerX);
        make.centerY.equalTo(self.methodView.mas_centerY);
        make.top.equalTo(self.methodView.mas_top);
    }];
    
}

#pragma mark - 重写setter方法
- (void)setModel:(LJBFood *)model {
    
    _model = model;
    
    // 食物健康等级
    if ([_model.health_light intValue] == 1) {
        self.appraiseImage.image = [UIImage imageNamed:@"img_food_light_green"];
    } else if ([_model.health_light intValue] == 2) {
        self.appraiseImage.image = [UIImage imageNamed:@"img_food_light_yellow"];
    } else {
        self.appraiseImage.image = [UIImage imageNamed:@"img_food_light_red"];
    }
    
    // 评价内容
    if (_model.appraise.length) {
        self.appraiseContent.text = _model.appraise;
    } else {
        self.appraiseContent.text = @"暂无评价";
    }

    // 做法
    if ([_model.recipe intValue]) {
        self.methodView.hidden = NO;
        self.methodText.text = @"原料与做法";
    } else {
        self.methodView.hidden = YES;
    }
}

#pragma mark - 做法单击手势
- (void)methodTapAction {
    
    if (self.FoodMaterialAction) {
        self.FoodMaterialAction();
    }
}

#pragma mark - getter
- (UIImageView *)appraiseImage {
    
    if (!_appraiseImage) {
        _appraiseImage = [[UIImageView alloc] init];
        [self.contentView addSubview:_appraiseImage];
    }
    return _appraiseImage;
}

- (UILabel *)appraiseContent {
    
    if (!_appraiseContent) {
        _appraiseContent = [[UILabel alloc] init];
        _appraiseContent.numberOfLines = 0;
        _appraiseContent.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_appraiseContent];
    }
    return _appraiseContent;
}

- (UIView *)methodView {
    
    if (!_methodView) {
        _methodView = [[UIView alloc] init];
        _methodView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _methodView.layer.borderWidth = 0.5;
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(methodTapAction)];
        [_methodView addGestureRecognizer:tap];
        
        [self.contentView addSubview:_methodView];
    }
    return _methodView;
}

- (UILabel *)methodText {
    
    if (!_methodText) {
        _methodText = [[UILabel alloc] init];
        _methodText.font = [UIFont systemFontOfSize:13];
        _methodText.textColor = [UIColor darkGrayColor];
        _methodText.textAlignment = NSTextAlignmentCenter;
        [self.methodView addSubview:_methodText];
    }
    return _methodText;
}

@end
