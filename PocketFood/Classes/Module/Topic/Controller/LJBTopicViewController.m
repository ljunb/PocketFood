//
//  LJBTopicViewController.m
//  PocketFood
//
//  Created by qf on 15/11/18.
//  Copyright © 2015年 qf. All rights reserved.
//  专题界面

#import "LJBTopicViewController.h"
#import "LJBTopicDetailCell.h"

#import "LJBTopicPageFrame.h"
#import "LJBTopicPage.h"
#import "LJBMainNetworker.h"
#import "LJBFoodViewController.h"
#import "LJBTopicIndicatiorView.h"

#import "UMSocial.h"

#define BackButton_VGap 25
#define BackButton_Width 50
#define BackButton_Height 44

@interface LJBTopicViewController ()

/**
 *  专题食物数组
 */
@property (nonatomic, strong) NSMutableArray * topicFoods;

/**
 *  返回按钮
 */
@property (nonatomic, strong) UIButton * backButton;

/**
 *  分享按钮
 */
@property (nonatomic, strong) UIButton * shareButton;

/**
 *  当前页
 */
@property (nonatomic, assign) NSInteger currentPage;

/**
 *  底部页码指示图
 */
@property (nonatomic, strong) LJBTopicIndicatiorView * indicatorView;

@end

@implementation LJBTopicViewController

static NSString * const reuseIdentifier = @"Topic_Cell";

#pragma mark - 重写初始化方法
- (instancetype)init {
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
//    layout.itemSize = CGSizeMake(KScreenSize.width, KScreenSize.height-20);
    layout.itemSize = KScreenSize;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 0;
    
    return [super initWithCollectionViewLayout:layout];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // collectionView基础配置
    [self configCollectionView];
    
    [self setupStatusBar];
    
    // 适配子控件
    [self settingSubviewsFrame];
    
    // 注册cell
    [self.collectionView registerClass:[LJBTopicDetailCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // 请求数据
    [self getTopicPageData];
    
}

#pragma mark - 初始化CollectionView的配置
- (void)configCollectionView {
    
    self.collectionView.pagingEnabled = YES;
    self.collectionView.bounces = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    // NSKeyValueObservingOptionNew = 0x01,
//    NSKeyValueObservingOptionOld = 0x02,
    
    
    _currentPage = 0;
}

- (void)dealloc {
    [self.collectionView removeObserver:self forKeyPath:@"contentOffset" context:nil];
}

- (void)setupStatusBar {
    
    UIView * statusBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenSize.width, 20)];
    statusBgView.backgroundColor = KColor(234, 82, 90);
    [self.view addSubview:statusBgView];
}

#pragma mark - 适配子控件
- (void)settingSubviewsFrame {
    
    // 适配返回按钮
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(BackButton_VGap);
        make.left.equalTo(self.view.mas_left);
        make.width.equalTo(@(BackButton_Width));
        make.height.equalTo(@(BackButton_Height));
    }];
    
    // 适配分享按钮
    [self.shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(BackButton_VGap);
        make.right.equalTo(self.view.mas_right);
        make.width.equalTo(@(BackButton_Width));
        make.height.equalTo(@(BackButton_Height));
    }];
    
    // 适配底部页码指示图
    [self.indicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(KScreenSize.height-30, 0, 0, 0));
    }];
}

#pragma mark - 获取专题详情页数据
- (void)getTopicPageData {
//    
    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleFade];
    [MMProgressHUD show];
    
    [LJBMainNetworker getTopicPageDataFromServerWithSuccess:^(NSArray *models) {
        
        if (self.topicFoods.count) {
            [self.topicFoods removeAllObjects];
        }
        
        for (LJBTopicPage * model in models) {
            
            LJBTopicPageFrame * frame = [[LJBTopicPageFrame alloc] init];
            frame.model = model;
            
            [self.topicFoods addObject:frame];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
    
            [MMProgressHUD dismiss];
            
            [self.collectionView reloadData];
            
            // 设置页码指示器
            [self.indicatorView configViewWithPageCount:self.topicFoods.count];
            
            [self.collectionView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
        });
     
    } failure:^(NSError *error) {
        
        NSLog(@"Topic detail error:%@", error);
        [MMProgressHUD dismiss];
        
    } withTopicId:self.topic_id];
}

#pragma mark <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.topicFoods.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    LJBTopicPageFrame * model;
    if (self.topicFoods.count) {
        model = self.topicFoods[indexPath.row];
    }
    
    LJBTopicDetailCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    [cell configCellWithModel:model];
    
    // 查看详情
    cell.ShowFoodDetailAction = ^ {
        [self presentToViewControllerWithModel:model.model];
    };
    
    cell.backgroundColor = [UIColor whiteColor];
    
    return cell;
}

#pragma mark - 滑动时获得当前页数
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
//    
//    _currentPage = scrollView.contentOffset.x / KScreenSize.width;
//    // 更新页码指示图
//    [self.indicatorView updatePageIndicatorWithIndex:_currentPage];
//}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    
    
    if (object == self.collectionView && [keyPath isEqualToString:@"contentOffset"]) {
        
        _currentPage = self.collectionView.contentOffset.x / KScreenSize.width;
        
        [self.indicatorView updatePageIndicatorWithIndex:_currentPage];
    }
    
    NSLog(@"%ld", _currentPage);
}

#pragma mark - 挑转至食物详情VC
- (void)presentToViewControllerWithModel:(LJBTopicPage *)model {
    
    LJBFoodViewController * foodVC = [[LJBFoodViewController alloc] init];
    [LJBFoodSingleTon sharedFood].foodCode = model.food_code;
    
    UINavigationController * unc = [[UINavigationController alloc] initWithRootViewController:foodVC];
    unc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:unc animated:YES completion:nil];
}

#pragma mark - 返回按钮事件
- (void)backAction {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 分享按钮事件
- (void)shareAction {

    LJBTopicPageFrame * frame = self.topicFoods[_currentPage];
    
    NSString * shareText = [NSString stringWithFormat:@"来自口袋食物百科的分享:%@", frame.model.Description];
    
    [[UMSocialData defaultData].urlResource setResourceType:UMSocialUrlResourceTypeImage url:frame.model.image_url];
    
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:APPKey
                                      shareText:shareText
                                     shareImage:nil
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToWechatSession,UMShareToQQ,nil]
                                       delegate:nil];
    
}

#pragma mark - getter
- (NSMutableArray *)topicFoods {
    
    if (!_topicFoods) {
        _topicFoods = [NSMutableArray array];
    }
    return _topicFoods;
}

- (UIButton *)backButton {
    
    if (!_backButton) {
        _backButton = [[UIButton alloc] init];
        [_backButton setBackgroundImage:[UIImage imageNamed:@"ic_back_white"] forState:UIControlStateNormal];
        [_backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_backButton];
    }
    return _backButton;
}

- (UIButton *)shareButton {
    
    if (!_shareButton) {
        _shareButton = [[UIButton alloc] init];
        [_shareButton setBackgroundImage:[UIImage imageNamed:@"ic_share"] forState:UIControlStateNormal];
        [_shareButton addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_shareButton];
    }
    return _shareButton;
}

- (LJBTopicIndicatiorView *)indicatorView {
    
    if (!_indicatorView) {
        _indicatorView = [[LJBTopicIndicatiorView alloc] init];
        [self.view addSubview:_indicatorView];
    }
    return _indicatorView;
}

@end
