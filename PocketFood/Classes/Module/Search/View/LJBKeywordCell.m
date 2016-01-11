//
//  LJBKeywordCell.m
//  PocketFood
//
//  Created by qf on 15/11/23.
//  Copyright © 2015年 qf. All rights reserved.
//

#import "LJBKeywordCell.h"

#define Gap 15
#define Row_Count 4
#define Label_Height 30
#define Label_Width (KScreenSize.width - Gap*(Row_Count+1))/Row_Count

@implementation LJBKeywordCell

#pragma mark - 工厂方法
+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    static NSString * ID = @"food_keyword_cell";
    
    LJBKeywordCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[LJBKeywordCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - 重写初始化方法
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

    }
    return self;
}


- (void)configCellWithKeywords:(NSArray *)keywords {
    
    for (UIView * view in self.contentView.subviews) {
        if ([view isKindOfClass:[UILabel class]]) {
            [view removeFromSuperview];
        }
    }
    
    for (NSInteger i = 0; i < keywords.count; i++) {
        
        NSInteger row = i % Row_Count;
        NSInteger cell = i / Row_Count;
        
        UILabel * keyword = [[UILabel alloc] init];
        keyword.frame = CGRectMake(Gap + (Gap + Label_Width)*row, Gap + (Gap + Label_Height)*cell, Label_Width, Label_Height);
        keyword.text = keywords[i];
        keyword.textAlignment = NSTextAlignmentCenter;
        keyword.font = [UIFont systemFontOfSize:15];
        keyword.textColor = [UIColor darkGrayColor];
        
        keyword.layer.borderColor = [UIColor darkGrayColor].CGColor;
        keyword.layer.borderWidth = 0.5;
        keyword.layer.cornerRadius = 4;
        keyword.layer.masksToBounds = YES;
        
        [self.contentView addSubview:keyword];
        
        // 添加手势
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keywordTapAction:)];
        keyword.userInteractionEnabled = YES;
        keyword.tag = 100 + i;
        [keyword addGestureRecognizer:tap];
    }
}

#pragma mark 单击手势事件
- (void)keywordTapAction:(UITapGestureRecognizer *)tapGesture {
    
    UILabel * label = (id)[self.contentView viewWithTag:tapGesture.view.tag];
    
    // 回调点击关键字方法
    if (self.KeywordClickAction) {
        self.KeywordClickAction(label.text);
    }
    
}



@end
