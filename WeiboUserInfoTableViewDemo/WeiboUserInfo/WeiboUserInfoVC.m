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

@interface WeiboUserInfoVC ()<UIScrollViewDelegate,WeiboUserInfoChildVCDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSArray<WeiboUserInfoChildVC *> *childVCs;
@property (nonatomic, strong) WeiboUserInfoChildVC *currentVC;
@property (nonatomic, strong) WeiboUserInfoHeaderView *headerView;

@property (nonatomic, strong) UIView *titleView;
@property (nonatomic, strong) NSMutableArray<UILabel *> *titleLabels;
@property (nonatomic, strong) UIView *titleLine;

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
        self.titleLabels = [NSMutableArray array];
        self.childVCs = childVCs;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

#pragma mark WeiboUserInfoChildVCDelegate
- (void)slideContentOffsetY:(CGFloat)offsetY childVC:(WeiboUserInfoChildVC *)viewController
{
    if (offsetY <= headerAboveHeight) {
        self.headerOffsetY = offsetY;
    }else {
        self.headerOffsetY = headerAboveHeight + headerHeight;
    }
}

#pragma mark UIScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSUInteger index = round(scrollView.contentOffset.x / scrollView.frame.size.width);
    WeiboUserInfoChildVC *vc = self.childVCs[index];
    if (self.headerOffsetY <= headerHeight) {
        [vc setMainVCOffsetY:self.headerOffsetY];
    }else {
        [vc setMainVCOffsetY:headerHeight];
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    NSUInteger index = round(scrollView.contentOffset.x / scrollView.frame.size.width);
    self.currentVC = self.childVCs[index];
}

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
    self.titleLabels[0].textColor = [UIColor redColor];
    
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

- (UIView *)titleView
{
    if (!_titleView) {
        CGFloat labelWid = SCREEN_WIDTH/_childVCs.count;
        _titleView = [[UIView alloc]initWithFrame:CGRectMake(0, headerHeight - titleViewHeight, SCREEN_WIDTH, titleViewHeight)];
        _titleView.backgroundColor = [UIColor whiteColor];
        for (int i = 0; i < _childVCs.count; i ++) {
            UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(i * labelWid, 0, labelWid, titleViewHeight)];
            titleLabel.text = _childVCs[i].title;
            titleLabel.textAlignment = NSTextAlignmentCenter;
            [_titleView addSubview:titleLabel];
            [_titleLabels addObject:titleLabel];
        }
    }
    return _titleView;
}

@end
