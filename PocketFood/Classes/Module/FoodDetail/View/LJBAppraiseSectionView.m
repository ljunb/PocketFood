//
//  LJBAppraiseSectionView.m
//  PocketFood
//
//  Created by qf on 15/11/19.
//  Copyright © 2015年 qf. All rights reserved.
//

#import "LJBAppraiseSectionView.h"

#define Gap 10

@interface LJBAppraiseSectionView ()

/**
 *  组标题
 */
@property (nonatomic, strong) UILabel * title;

/**
 *  食物热量
 */
@property (nonatomic, strong) UILabel * calory;

/**
 *  食物备注
 */
@property (nonatomic, strong) UILabel * comment;

@end

@implementation LJBAppraiseSectionView

+ (instancetype)sectionViewWithTableView:(UITableView *)tableView {
    
    static NSString * ID = @"appraise_section_view";
    
    LJBAppraiseSectionView * sectionView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    if (!sectionView) {
        sectionView = [[LJBAppraiseSectionView alloc] initWithReuseIdentifier:ID];
    }
    return sectionView;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self addSubviews];
    }
    return self;
}

#pragma mark - 适配子控件
- (void)addSubviews {
    
    // 组标题
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(Gap);
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
    
    // 食物热量
    [self.calory mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_centerX).offset(Gap*4);
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];

    // 食物备注
    [self.comment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.right.equalTo(self.contentView.mas_right).offset(-Gap);
    }];
}

- (void)setSectionType:(KFoodSectionType)sectionType {
    
    _sectionType = sectionType;
    
    switch (_sectionType) {
        case KFoodSectionAppraiseType:
        {
            [self configSectionViewWithStrings:@[@"食物评价", @"", @""]];
        }
            break;
        case KFoodSectionCaloryType:
        {
            [self configSectionViewWithStrings:@[@"所含热量", @"", @""]];
        }
            break;
        case KFoodSectionIngredientType:
        {
            [self configSectionViewWithStrings:@[@"营养元素", @"每100克", @"备注"]];
        }
            break;
        default:
            break;
    }
}

- (void)configSectionViewWithStrings:(NSArray *)strings {
    
    self.title.text = strings[0];
    
    self.calory.text = strings[1];
    
    self.comment.text = strings[2];
}

- (void)configTitleWithTitles:(NSArray *)titles {
    [self configSectionViewWithStrings:titles];
}

#pragma mark - getter
- (UILabel *)title {
    
    if (!_title) {
        _title = [[UILabel alloc] init];
        _title.font = [UIFont systemFontOfSize:13];
        _title.textColor = [UIColor darkGrayColor];
        [self.contentView addSubview:_title];
    }
    return _title;
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

- (UILabel *)comment {
    
    if (!_comment) {
        _comment = [[UILabel alloc] init];
        _comment.font = [UIFont systemFontOfSize:13];
        _comment.textColor = [UIColor darkGrayColor];
        [self.contentView addSubview:_comment];
    }
    return _comment;
}


@end
