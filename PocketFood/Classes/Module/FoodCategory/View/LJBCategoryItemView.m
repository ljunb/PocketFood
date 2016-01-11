//
//  LJBCategoryItemView.m
//  PocketFood
//
//  Created by qf on 15/11/21.
//  Copyright © 2015年 qf. All rights reserved.
//

#import "LJBCategoryItemView.h"
#import "LJBFoodGroupCategory.h"
#import "UIImageView+WebCache.h"

#define Image_Width 40
#define Image_Height 40

@interface LJBCategoryItemView ()
/**
 *  选项图片
 */
@property (nonatomic, strong) UIImageView * itemImage;
/**
 *  选项标题
 */
@property (nonatomic, strong) UILabel * itemTitle;

@end

@implementation LJBCategoryItemView

#pragma mark - 布局子控件
- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.itemTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom);
        make.centerX.equalTo(self.mas_centerX);
        make.height.equalTo(@20);
    }];
    
    [self.itemImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.itemTitle.mas_top).offset(-5);
        make.centerX.equalTo(self.mas_centerX);
        make.width.equalTo(@(Image_Width));
        make.height.equalTo(@(Image_Height));
    }];
    
}

- (void)setCategoryModel:(LJBFoodGroupCategory *)categoryModel {
    
    _categoryModel = categoryModel;
    
    [self.itemImage sd_setImageWithURL:[NSURL URLWithString:categoryModel.image_url] placeholderImage:[UIImage imageNamed:@""]];
    
    self.itemTitle.text = categoryModel.name;
}


#pragma mark - getter
- (UIImageView *)itemImage {
    
    if (!_itemImage) {
        _itemImage = [[UIImageView alloc] init];
        [self addSubview:_itemImage];
    }
    return _itemImage;
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
