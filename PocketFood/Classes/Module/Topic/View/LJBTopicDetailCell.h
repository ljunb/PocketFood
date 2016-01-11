//
//  LJBTopicDetailCell.h
//  PocketFood
//
//  Created by qf on 15/11/18.
//  Copyright © 2015年 qf. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LJBTopicPageFrame;

@interface LJBTopicDetailCell : UICollectionViewCell

@property (nonatomic, copy) void(^ShowFoodDetailAction)();

- (void)configCellWithModel:(LJBTopicPageFrame *)model;

@end
