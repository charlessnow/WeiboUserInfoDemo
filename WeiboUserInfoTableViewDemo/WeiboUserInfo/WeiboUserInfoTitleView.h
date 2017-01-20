//
//  WeiboUserInfoTitleView.h
//  WeiboUserInfoTableViewDemo
//
//  Created by 牛严 on 2017/1/19.
//  Copyright © 2017年 牛严. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WeiboUserInfoTitleViewDelegate <NSObject>

- (void)didClickedTitleIndex:(NSInteger)index;

@end

@interface WeiboUserInfoTitleView : UIView

@property (nonatomic, weak) id<WeiboUserInfoTitleViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles;

- (void)slideToTitleWithIndex:(NSInteger)index;

@end
