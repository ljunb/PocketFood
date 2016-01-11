//
//  LJBTopicPageFrame.h
//  PocketFood
//
//  Created by qf on 15/11/18.
//  Copyright © 2015年 qf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>

@class LJBTopicPage;

@interface LJBTopicPageFrame : NSObject
/**
 *  专题美食模型
 */
@property (nonatomic, strong) LJBTopicPage * model;

/**
 *  可滚动高度
 */
@property (nonatomic, assign) CGFloat contentHeight;


@end
