//
//  WeiboUserInfoHeaderView.m
//  WeiboUserInfoTableViewDemo
//
//  Created by 牛严 on 2017/1/18.
//  Copyright © 2017年 牛严. All rights reserved.
//

#import "WeiboUserInfoHeaderView.h"

@interface WeiboUserInfoHeaderView ()

@property (nonatomic, strong) UIImageView *bgView;
@property (nonatomic, strong) UILabel *nameLabel;
@end

@implementation WeiboUserInfoHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.bgView];
        [self addSubview:self.nameLabel];
    }
    return self;
}

#pragma mark Get
- (UIImageView *)bgView
{
    if (!_bgView) {
        _bgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.frame.size.height)];
        _bgView.backgroundColor = [UIColor yellowColor];
    }
    return _bgView;
}

- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 300, SCREEN_WIDTH, 20)];
        _nameLabel.text = @"用户姓名";
        _nameLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _nameLabel;
}

@end
