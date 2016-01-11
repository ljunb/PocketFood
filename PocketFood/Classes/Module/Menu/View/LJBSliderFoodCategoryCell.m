//
//  LJBSliderMenuSectionView.m
//  PocketFood
//
//  Created by qf on 15/11/20.
//  Copyright © 2015年 qf. All rights reserved.
//

#import "LJBSliderFoodCategoryCell.h"

@interface LJBSliderFoodCategoryCell ()
/**
 *  食物分类标题
 */
@property (nonatomic, strong) UILabel * title;

@end

@implementation LJBSliderFoodCategoryCell

#pragma mark - 工厂方法
+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    static NSString * ID = @"slider_food_category_cell";
    
    LJBSliderFoodCategoryCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[LJBSliderFoodCategoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
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
    
    
//    self.contentView.backgroundColor = [UIColor clearColor];
//    
//    UIView * upLineView = [[UIView alloc] init];
//    upLineView.alpha = 0.7;
//    upLineView.backgroundColor = [UIColor whiteColor];
//    [self.contentView addSubview:upLineView];
//    [upLineView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.contentView.mas_top);
//        make.left.equalTo(self.contentView.mas_left);
//        make.right.equalTo(self.contentView.mas_right);
//        make.height.equalTo(@0.3);
//    }];
//    
//    UIView * lineView = [[UIView alloc] init];
//    lineView.alpha = 0.7;
//    lineView.backgroundColor = [UIColor whiteColor];
//    [self.contentView addSubview:lineView];
//    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(self.contentView.mas_bottom);
//        make.left.equalTo(self.contentView.mas_left);
//        make.right.equalTo(self.contentView.mas_right);
//        make.height.equalTo(@0.3);
//    }];
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(15);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
        make.height.equalTo(@15);
    }];
    self.title.text = @"食物分类";
}

#pragma mark - getter
- (UILabel *)title {
    
    if (!_title) {
        _title = [[UILabel alloc] init];
        _title.font = [UIFont systemFontOfSize:13];
        _title.textColor = [UIColor whiteColor];
        [self.contentView addSubview:_title];
    }
    return _title;
}

@end
