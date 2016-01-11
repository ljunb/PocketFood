//
//  LJBBaseFoodCategoryController.m
//  PocketFood
//
//  Created by qf on 15/11/20.
//  Copyright © 2015年 qf. All rights reserved.
//

#import "LJBFoodCategoryController.h"
#import "LJBCategoryItemView.h"
#import "LJBMethodItemView.h"
#import "LJBFoodNetworker.h"
#import "LJBFoodGroupCategory.h"
#import "LJBFoodGroupSubCategory.h"
#import "LJBFoodsDetailController.h"

#define Row_Num 3
#define View_Width KScreenSize.width/Row_Num
#define View_Height 90

#define Gap 5
#define Item_Height 50
#define Item_Width (KScreenSize.width - Gap*(Row_Num+1)) / Row_Num

@interface LJBFoodCategoryController ()

@property (nonatomic, strong) UIScrollView * scrollView;

@end

@implementation LJBFoodCategoryController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self getDataFromServer];
}

#pragma mark - 请求数据
- (void)getDataFromServer {
    
    [LJBFoodNetworker getFoodCategoryDataFromServerWithSuccess:^(NSArray *categories) {
        
        if (self.items.count) {
            [self.items removeAllObjects];
        }
        
        [self.items addObjectsFromArray:categories];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self addSubviews];
        });
        
    } failure:^(NSError *error) {
        
        NSLog(@"Food category error:%@", error);
        
    } withParams:@{@"kind":self.category}];
}

#pragma mark - 适配子控件
- (void)addSubviews {

    for (NSInteger i = 0; i < self.items.count; i++) {
        
        LJBFoodGroupCategory * categoryModel = self.items[i];

        NSInteger row = i % Row_Num;
        NSInteger cell = i / Row_Num;
        
        if (self.itemType == KFoodCategoryItemImageTitleType) {
            // 分类、品牌、连锁餐饮
            
            LJBCategoryItemView * view = [[LJBCategoryItemView alloc] init];
            view.frame = CGRectMake(View_Width * row, View_Height * cell, View_Width, View_Height);
            view.tag = 100 + i;
            view.categoryModel = categoryModel;
            
            // 添加手势
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itemTapAction:)];
            [view addGestureRecognizer:tap];
            
            // 设置滚动范围
            self.scrollView.backgroundColor = [UIColor whiteColor];
            [self.scrollView addSubview:view];
            self.scrollView.contentSize = CGSizeMake(0, View_Height * (cell+1)+15);
            
        } else {
            // 烹饪方式
            
            LJBMethodItemView * view = [[LJBMethodItemView alloc] init];
            view.frame = CGRectMake(Gap + (Item_Width+Gap) * row, Gap + (Item_Height + Gap) * cell, Item_Width, Item_Height);
            view.tag = 100 + i;
            view.categoryModel = categoryModel;
            
            // 添加手势
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itemTapAction:)];
            [view addGestureRecognizer:tap];
            
            // 设置滚动范围
            self.scrollView.backgroundColor = KColor(240, 241, 235);
            [self.scrollView addSubview:view];
            self.scrollView.contentSize = CGSizeMake(0, Item_Height * (cell+1) + Gap * (cell+2));
        }
    }
    
}


#pragma mark - 选项单击手势方法
- (void)itemTapAction:(UITapGestureRecognizer *)tapGesture {
    
    LJBFoodGroupCategory * model = self.items[tapGesture.view.tag-100];
    
    LJBFoodsDetailController * foodsVC = [[LJBFoodsDetailController alloc] init];
    
    foodsVC.title = model.name;
    foodsVC.model = model;
    foodsVC.kind = self.category;
    
    [self.navigationController pushViewController:foodsVC animated:YES];
    
}

#pragma mark - 重写返回方法
- (void)backAction {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - getter
- (UIScrollView *)scrollView {
    
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.frame = self.view.bounds;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.bounces = NO;
        [self.view addSubview:_scrollView];
    }
    return _scrollView;
}

- (NSMutableArray *)items {
    
    if (!_items) {
        _items = [NSMutableArray array];
    }
    return _items;
}

@end
