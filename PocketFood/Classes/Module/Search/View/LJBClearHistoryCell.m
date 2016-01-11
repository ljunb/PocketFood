//
//  LJBClearHistoryCell.m
//  PocketFood
//
//  Created by qf on 15/11/23.
//  Copyright © 2015年 qf. All rights reserved.
//

#import "LJBClearHistoryCell.h"

@interface LJBClearHistoryCell ()

@property (nonatomic, strong) UIButton * clearBtn;

@end

@implementation LJBClearHistoryCell

#pragma mark - 工厂方法
+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    static NSString * ID = @"clear_keyword_cell";
    
    LJBClearHistoryCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[LJBClearHistoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubviews];
    }
    return self;
}

- (void)addSubviews {
    
    [self.clearBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    [self.clearBtn addTarget:self action:@selector(clearHistoryAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)clearHistoryAction {
    
    if (self.ClearHistoryAction) {
        self.ClearHistoryAction();
    }
}

- (UIButton *)clearBtn {
    
    if (!_clearBtn) {
        _clearBtn = [[UIButton alloc] init];
        [_clearBtn setTitle:@"清空历史记录" forState:UIControlStateNormal];
        _clearBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_clearBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [_clearBtn setImage:[UIImage imageNamed:@"ic_trash"] forState:UIControlStateNormal];
        _clearBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -50, 0, 0);
        _clearBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 100, 0, 180);
        [self.contentView addSubview:_clearBtn];
    }
    return _clearBtn;
}

@end
