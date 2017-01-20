//
//  WeiboUserInfoTitleView.m
//  WeiboUserInfoTableViewDemo
//
//  Created by 牛严 on 2017/1/19.
//  Copyright © 2017年 牛严. All rights reserved.
//

#import "WeiboUserInfoTitleView.h"

@interface WeiboUserInfoTitleView ()

@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSMutableArray<UILabel *> *labels;
@property (nonatomic, assign) CGFloat labelWid;

@property (nonatomic, strong) UIView *bottomLine;

@end

@implementation WeiboUserInfoTitleView

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.labels = [NSMutableArray array];
        self.titles = titles;
        self.labels[0].textColor = [UIColor redColor];
        [self addSubview:self.bottomLine];
    }
    return self;
}

#pragma mark titleLabel切换效果
- (void)slideToTitleWithIndex:(NSInteger)index
{
    CGFloat targetX = index * self.labelWid + self.labelWid/2;
    [UIView animateWithDuration:0.2 animations:^{
        self.bottomLine.center = CGPointMake(targetX, self.bottomLine.center.y);
    }];
    for (int i = 0 ; i < _titles.count; i ++ ) {
        if (i == index) {
            [UIView animateWithDuration:0.2 animations:^{
                self.labels[i].textColor = [UIColor redColor];
            }];
        }else{
            [UIView animateWithDuration:0.2 animations:^{
                self.labels[i].textColor = [UIColor blackColor];
            }];
        }
    }
}

- (void)labelClicked:(UITapGestureRecognizer *)sender
{
    
    UILabel *label = (UILabel *)sender.view;
    NSInteger index = label.tag;
    [self slideToTitleWithIndex:index];
    [self.delegate didClickedTitleIndex:index];
}

#pragma mark Set
- (void)setTitles:(NSArray *)titles
{
    _titles = [titles copy];
    self.labelWid = SCREEN_WIDTH/_titles.count;
    for (int i = 0; i < _titles.count; i ++) {
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(i * self.labelWid, 0, self.labelWid, 40)];
        titleLabel.text = _titles[i];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.tag = i;
        titleLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *re = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labelClicked:)];
        [titleLabel addGestureRecognizer:re];
        [self addSubview:titleLabel];
        [self.labels addObject:titleLabel];
    }
}

#pragma mark Get
- (UIView *)bottomLine
{
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height - 2, self.labelWid, 2)];
        _bottomLine.backgroundColor = [UIColor redColor];
    }
    return _bottomLine;
}

@end
