//
//  WeiboUserInfoVC.m
//  WeiboUserInfoTableViewDemo
//
//  Created by 牛严 on 2017/1/18.
//  Copyright © 2017年 牛严. All rights reserved.
//

#import "WeiboUserInfoVC.h"
#import "WeiboUserInfoHeaderView.h"
#import "WeiboUserInfoChildVC.h"
#import "WeiboUserInfoTitleView.h"

@interface WeiboUserInfoVC ()<UIScrollViewDelegate,WeiboUserInfoChildVCDelegate,WeiboUserInfoTitleViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSArray<WeiboUserInfoChildVC *> *childVCs;
@property (nonatomic, strong) WeiboUserInfoChildVC *currentVC;
@property (nonatomic, strong) WeiboUserInfoHeaderView *headerView;

@property (nonatomic, strong) WeiboUserInfoTitleView *titleView;

@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, assign) CGFloat headerOffsetY;

@end

@implementation WeiboUserInfoVC

static CGFloat headerHeight = 200.f;
static CGFloat headerAboveHeight = 200.f;
static CGFloat titleViewHeight = 40.f;

#pragma mark LifeCircle
- (instancetype)initWithChildVCs:(NSArray *)childVCs
{
    self = [super init];
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
        self.automaticallyAdjustsScrollViewInsets = NO;
        self.childVCs = childVCs;
        self.currentPage = 0;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

#pragma mark WeiboUserInfoTitleViewDelegate
- (void)didClickedTitleIndex:(NSInteger)index
{
    [self.scrollView setContentOffset:CGPointMake(index * SCREEN_WIDTH, 0) animated:YES];
}

#pragma mark WeiboUserInfoChildVCDelegate
- (void)slideContentOffsetY:(CGFloat)offsetY childVC:(WeiboUserInfoChildVC *)viewController
{
    //控制header
    if (offsetY <= headerAboveHeight) {
        self.headerOffsetY = offsetY;
    }else {
        self.headerOffsetY = headerAboveHeight + headerHeight;
    }
    //控制标题栏
    if (offsetY <= headerHeight - titleViewHeight - 64 && offsetY >= 0) {
        self.titleView.center = CGPointMake(self.titleView.center.x, headerHeight - titleViewHeight/2 - offsetY);
    }else if (offsetY < 0) {
        self.titleView.center = CGPointMake(self.titleView.center.x, CGRectGetMaxY(self.headerView.frame) - titleViewHeight/2);
    }else {
        self.titleView.center = CGPointMake(self.titleView.center.x, 64 + titleViewHeight/2);
    }
}

#pragma mark UIScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSUInteger index = round(scrollView.contentOffset.x / scrollView.frame.size.width);
    if (index != self.currentPage) {
        [self.titleView slideToTitleWithIndex:index];
        self.currentPage = index;
    }
    WeiboUserInfoChildVC *vc = self.childVCs[index];
    if (self.headerOffsetY <= headerHeight) {
        [vc setMainVCOffsetY:self.headerOffsetY];
    }else {
        [vc setMainVCOffsetY:headerHeight];
    }
}

//系统setcontenoffset调用
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    NSUInteger index = round(scrollView.contentOffset.x / scrollView.frame.size.width);
    self.currentVC = self.childVCs[index];
    self.currentPage = index;
    if (self.currentVC.view.superview) return;
    self.currentVC.view.frame = scrollView.bounds;
    [self.scrollView addSubview:self.currentVC.view];
}

//手动滑动调用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    if (self.currentVC.view.superview) return;
    self.currentVC.view.frame = scrollView.bounds;
    [self.scrollView addSubview:self.currentVC.view];
}

#pragma mark Set
- (void)setHeaderOffsetY:(CGFloat)headerOffsetY
{
    _headerOffsetY = headerOffsetY;
    CGRect frame = self.headerView.frame;
    frame.origin.y = -200 - _headerOffsetY;
    self.headerView.frame = frame;
}

- (void)setChildVCs:(NSArray *)childVCs
{
    _childVCs = [childVCs copy];
    for (WeiboUserInfoChildVC *vc in _childVCs) {
        vc.delegate = self;
    }
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:_childVCs[0].view];
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.titleView];
}

#pragma mark Get
- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        [_scrollView setContentSize:CGSizeMake(SCREEN_WIDTH * _childVCs.count, SCREEN_HEIGHT)];
    }
    return _scrollView;
}

- (WeiboUserInfoHeaderView *)headerView
{
    if(!_headerView){
        _headerView = [[WeiboUserInfoHeaderView alloc]initWithFrame:CGRectMake(0, -headerAboveHeight, SCREEN_WIDTH, headerHeight + headerAboveHeight)];
    }
    return _headerView;
}

- (WeiboUserInfoTitleView *)titleView
{
    if (!_titleView) {
        _titleView = [[WeiboUserInfoTitleView alloc]initWithFrame:CGRectMake(0, headerHeight - titleViewHeight, SCREEN_WIDTH, titleViewHeight) titles:@[@"标题一",@"标题二",@"标题三"]];
        _titleView.delegate = self;
    }
    return _titleView;
}

@end
