//
//  LJBSliderMenuViewController.m
//  PocketFood
//
//  Created by qf on 15/11/20.
//  Copyright © 2015年 qf. All rights reserved.
//

#import "LJBSliderMenuViewController.h"
#import "LJBMainViewController.h"
#import "LJBSliderMenuCell.h"
#import "LJBSliderFoodCategoryCell.h"
#import "LJBFoodCategotySeasonController.h"
#import "LJBFoodCategoryController.h"
#import "LJBFavoriteViewController.h"

@interface LJBSliderMenuViewController () <UITableViewDelegate, UITableViewDataSource>


@property (nonatomic, strong) UITableView * tableView;
/**
 *  食物分类图标数组
 */
@property (nonatomic, strong) NSArray * categoryImages;
/**
 *  食物分类标题数组
 */
@property (nonatomic, strong) NSArray * categoryTitles;
/**
 *  食物分类请求URL数组
 */
@property (nonatomic, strong) NSArray * categoryParams;

@end

@implementation LJBSliderMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"slider_menu_bg.jpg"]];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    [self viewDidLayoutSubviews];
    
}

#pragma mark - 调整tableView分割线位置
-(void)viewDidLayoutSubviews{
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        // 分割线位置
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        // cell偏移
        [self.tableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row <= 1 || indexPath.row >= 6) {
        if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
            [cell setSeparatorInset:UIEdgeInsetsZero];
        }
        if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
            [cell setLayoutMargins:UIEdgeInsetsZero];
        }
    } else {
        // 食物分类cell
        if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
            [cell setSeparatorInset:UIEdgeInsetsMake(0, 80, 0, 0)];
        }
        if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
            [cell setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
        }
    }
}


#pragma mark - TableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * ID = @"slider_cell";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.textColor = [UIColor whiteColor];
    
    if (indexPath.row == 0) {
        
        LJBSliderMenuCell * cell = [LJBSliderMenuCell cellWithTableView:tableView];
        
        return cell;
        
    } else if (indexPath.row == 1) {
        
        LJBSliderFoodCategoryCell * cell = [LJBSliderFoodCategoryCell cellWithTableView:tableView];
        return cell;
        
    } else {
        
        cell.imageView.image = [UIImage imageNamed:self.categoryImages[indexPath.row-2]];
        cell.textLabel.text = self.categoryTitles[indexPath.row-2];
        
    }

    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 80;
    } else if (indexPath.row == 1) {
        
        return 70;
    } else {
        return 50;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.row) {
        case 0:
            [self presentToFavoriteViewController];
            break;
        case 1:
            break;
        case 3:
            [self presentToViewControllerWithType:KFoodCategoryItemTitleType index:indexPath.row-2];
            break;
        case 2:
        case 4:
        case 5:
            [self presentToViewControllerWithType:KFoodCategoryItemImageTitleType index:indexPath.row-2];
            break;
        case 6:
            [self presentToSeasonViewController];
             break;
            
        default:
            break;
    }
    
}

#pragma mark - 跳转至收藏VC
- (void)presentToFavoriteViewController {
    
    LJBFavoriteViewController * favoriteVC = [[LJBFavoriteViewController alloc] init];
    favoriteVC.title = @"收藏列表";
    
    UINavigationController * unc = [[UINavigationController alloc] initWithRootViewController:favoriteVC];
    unc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:unc animated:YES completion:nil];
}

#pragma mark - 跳转至对应的食物分类VC
- (void)presentToViewControllerWithType:(KFoodCategoryItemType)type index:(NSInteger)index {
    
    LJBFoodCategoryController * baseVC = [[LJBFoodCategoryController alloc] init];
    baseVC.title = self.categoryTitles[index];
    baseVC.itemType = type;
    baseVC.category = self.categoryParams[index];
    
    UINavigationController * unc = [[UINavigationController alloc] initWithRootViewController:baseVC];
    unc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    [self presentViewController:unc animated:YES completion:nil];
}

#pragma mark - 跳转至季节VC
- (void)presentToSeasonViewController {
    
    LJBFoodCategotySeasonController * seasonVC = [[LJBFoodCategotySeasonController alloc] init];
    seasonVC.title = @"季节";
    seasonVC.category = @"season";
    
    UINavigationController * unc = [[UINavigationController alloc] initWithRootViewController:seasonVC];
    unc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:unc animated:YES completion:nil];
}

#pragma mark - getter

- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.frame = self.view.bounds;
        _tableView.bounces = NO;
        _tableView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (NSArray *)categoryImages {
    
    if (!_categoryImages) {
        _categoryImages = @[@"ic_method_category", @"ic_method_cook", @"ic_method_brand", @"ic_method_chain_restaurant", @"ic_method_season"];
    }
    return _categoryImages;
}

- (NSArray *)categoryTitles {
    
    if (!_categoryTitles) {
        _categoryTitles = @[@"类别", @"烹饪方式", @"品牌", @"连锁餐饮", @"季节"];
    }
    return _categoryTitles;
}

- (NSArray *)categoryParams {
    
    if (!_categoryParams) {
        _categoryParams = @[@"group", @"cooking", @"brand", @"restaurant", @"season"];
    }
    return _categoryParams;
}
@end
