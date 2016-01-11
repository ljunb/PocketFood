//
//  LJBMainViewController.h
//  PocketFood
//
//  Created by qf on 15/11/17.
//  Copyright © 2015年 qf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LJBMainViewController : UIViewController

@property (nonatomic, copy) void(^OpenLeftMenuViewAction)(BOOL isOpen);

@property (nonatomic, strong) UIView * coverView;

@end
