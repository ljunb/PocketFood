//
//  LJBMoreTopicController.m
//  PocketFood
//
//  Created by ljunb on 15/11/22.
//  Copyright © 2015年 qf. All rights reserved.
//  更多专题VC

#import "LJBMoreTopicController.h"
#import "LJBMainTopic.h"
#import "LJBMainTopicCell.h"
#import "LJBTopicViewController.h"

@interface LJBMoreTopicController () <UITableViewDataSource, UITableViewDelegate>

/**
 *  专题tableView
 */
@property (nonatomic, strong) UITableView * tableView;

@end

@implementation LJBMoreTopicController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
}

#pragma mark - 适配TableView
- (void)setupTableView {
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

#pragma mark - 重写返回方法
- (void)backAction {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - TableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.moreTopics.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LJBMainTopic * topicModel = self.moreTopics[indexPath.row];
    
    LJBMainTopicCell * cell = [LJBMainTopicCell cellWithTableView:tableView];
    
    [cell configCellWithModel:topicModel];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LJBMainTopic * model = self.moreTopics[indexPath.row];
    
    // 跳转至专题详情页
    LJBTopicViewController * topicVC = [[LJBTopicViewController alloc] init];
    topicVC.topic_id = model.topic_id;
    topicVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:topicVC animated:YES completion:nil];
}

#pragma mark - getter
- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.bounces = NO;
        _tableView.rowHeight = 120;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

@end
