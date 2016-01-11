//
//  LJBFoodMaterialImageCell.m
//  PocketFood
//
//  Created by qf on 15/11/20.
//  Copyright © 2015年 qf. All rights reserved.
//

#import "LJBFoodMaterialImageCell.h"
#import "UIImageView+WebCache.h"

@interface LJBFoodMaterialImageCell ()

/**
 *  视图图片
 */
@property (nonatomic, strong) UIImageView * foodImage;

@end


@implementation LJBFoodMaterialImageCell

#pragma mark - 工厂方法
+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    static NSString * ID = @"food_image_cell";
    
    LJBFoodMaterialImageCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[LJBFoodMaterialImageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
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

#pragma mark 适配子控件
- (void)addSubviews {
    
    [self.foodImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

- (void)setImageUrl:(NSString *)imageUrl {
    
    _imageUrl = imageUrl;
    
    [self.foodImage sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"img_default_topic_banner"]];
}

#pragma mark - getter
- (UIImageView *)foodImage {
    
    if (!_foodImage) {
        _foodImage = [[UIImageView alloc] init];
        [self.contentView addSubview:_foodImage];
    }
    return _foodImage;
}

@end
