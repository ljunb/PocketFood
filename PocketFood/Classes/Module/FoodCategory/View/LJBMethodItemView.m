//
//  LJBMethodItemView.m
//  PocketFood
//
//  Created by qf on 15/11/21.
//  Copyright © 2015年 qf. All rights reserved.
//

#import "LJBMethodItemView.h"
#import "LJBFoodGroupCategory.h"

@interface LJBMethodItemView ()

@property (nonatomic, strong) UILabel * itemTitle;

@end

@implementation LJBMethodItemView

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.layer.cornerRadius = 2;
    self.layer.masksToBounds = YES;
    self.backgroundColor = [UIColor whiteColor];
    
    [self.itemTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
        make.height.equalTo(@20);
    }];
}

- (void)setCategoryModel:(LJBFoodGroupCategory *)categoryModel {
    
    _categoryModel = categoryModel;
    
    self.itemTitle.text = _categoryModel.name;
}

- (UILabel *)itemTitle {
    
    if (!_itemTitle) {
        _itemTitle = [[UILabel alloc] init];
        _itemTitle.font = [UIFont systemFontOfSize:14];
        [self addSubview:_itemTitle];
    }
    return _itemTitle;
}

@end
