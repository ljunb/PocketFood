//
//  LJBMoreSectionView.m
//  PocketFood
//
//  Created by qf on 15/11/19.
//  Copyright © 2015年 qf. All rights reserved.
//

#import "LJBMoreSectionView.h"

@interface LJBMoreSectionView ()

@property (nonatomic, strong) UILabel * content;

@end

@implementation LJBMoreSectionView

+ (instancetype)sectionViewWithTableView:(UITableView *)tableView {
    
    static NSString * ID = @"more_section_view";
    
    LJBMoreSectionView * sectionView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    if (!sectionView) {
        sectionView = [[LJBMoreSectionView alloc] initWithReuseIdentifier:ID];
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
    
    [self.content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
    
    self.content.text = @"查看更多营养信息";
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [self.contentView addGestureRecognizer:tap];
}

#pragma mark - 单击手势
- (void)tapAction {
    
    // 回调查看更多营养信息
    if (self.ShowMoreIngredientInfoAction) {
        self.ShowMoreIngredientInfoAction();
    }
}

#pragma mark - getter
- (UILabel *)content {
    
    if (!_content) {
        _content = [[UILabel alloc] init];
        _content.font = [UIFont systemFontOfSize:13];
        _content.textColor = [UIColor darkGrayColor];
        [self.contentView addSubview:_content];
    }
    return _content;
}

@end
