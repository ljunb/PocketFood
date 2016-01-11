//
//  LJBSliderMenuCell.m
//  PocketFood
//
//  Created by qf on 15/11/20.
//  Copyright © 2015年 qf. All rights reserved.
//

#import "LJBSliderMenuCell.h"

#define Imgae_Width 40
#define Image_Height 40

@interface LJBSliderMenuCell ()

@property (nonatomic, strong) UIImageView * menuImage;

@property (nonatomic, strong) UILabel * menuName;

@end

@implementation LJBSliderMenuCell

#pragma mark - 工厂方法
+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    static NSString * ID = @"slider_menu_cell";
    
    LJBSliderMenuCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[LJBSliderMenuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
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
    
    // 用户图片
    [self.menuImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(40);
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.width.equalTo(@(Imgae_Width));
        make.height.equalTo(@(Image_Height));
    }];
    
    // 用户名
    [self.menuName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.menuImage.mas_centerY);
        make.left.equalTo(self.menuImage.mas_right);
        make.height.equalTo(@20);
    }];
    
    self.menuImage.image = [UIImage imageNamed:@"shoucangle"];
    self.menuName.text = @"我的收藏";
}


#pragma mark - getter
- (UIImageView *)menuImage {
    
    if (!_menuImage) {
        _menuImage = [[UIImageView alloc] init];
        _menuImage.layer.cornerRadius = Imgae_Width/2;
        _menuImage.layer.masksToBounds = YES;
        [self.contentView addSubview:_menuImage];
    }
    return _menuImage;
}

- (UILabel *)menuName {
    
    if (!_menuName) {
        _menuName = [[UILabel alloc] init];
        _menuName.textColor = [UIColor whiteColor];
        [self.contentView addSubview:_menuName];
    }
    return _menuName;
}

@end
