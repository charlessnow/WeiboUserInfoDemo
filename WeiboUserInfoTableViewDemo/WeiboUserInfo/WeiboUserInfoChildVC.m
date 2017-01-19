//
//  WeiboUserInfoChildVC.m
//  WeiboUserInfoTableViewDemo
//
//  Created by 牛严 on 2017/1/18.
//  Copyright © 2017年 牛严. All rights reserved.
//

#import "WeiboUserInfoChildVC.h"

@interface WeiboUserInfoChildVC ()

@end

@implementation WeiboUserInfoChildVC

static CGFloat headerAboveHeight = 200.f;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark 设置滚动位置
- (void)setMainVCOffsetY:(CGFloat)offsetY
{
    if (offsetY <= self.tableView.contentOffset.y && offsetY >= headerAboveHeight) {
        return;
    }
    [self.tableView setContentOffset:CGPointMake(0, offsetY)];
}

#pragma mark UIScrollViwe Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    [self.delegate slideContentOffsetY:offsetY childVC:self];
}

@end
