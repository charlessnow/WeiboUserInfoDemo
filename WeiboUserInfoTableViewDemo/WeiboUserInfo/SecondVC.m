//
//  SecondVC.m
//  WeiboUserInfoTableViewDemo
//
//  Created by 牛严 on 2017/1/18.
//  Copyright © 2017年 牛严. All rights reserved.
//

#import "SecondVC.h"

@interface SecondVC ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation SecondVC
@synthesize tableView = _tableView;

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"标题二";
        [self.view addSubview:self.tableView];
    }
    return self;
}

#pragma mark UITableView Delegate/DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]init];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    cell.backgroundColor = [UIColor brownColor];
    return cell;
}

#pragma mark Get
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
    }
    return _tableView;
}

@end
