//
//  LJBIngredientInfoViewController.h
//  PocketFood
//
//  Created by qf on 15/11/19.
//  Copyright © 2015年 qf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LJBBaseViewController.h"


@class LJBFood;

@interface LJBIngredientInfoViewController : LJBBaseViewController

/**
 *  食物模型
 */
@property (nonatomic, strong) LJBFood * foodModel;

@end
