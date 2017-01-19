//
//  WeiboUserInfoChildVC.h
//  WeiboUserInfoTableViewDemo
//
//  Created by 牛严 on 2017/1/18.
//  Copyright © 2017年 牛严. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WeiboUserInfoChildVC;

@protocol WeiboUserInfoChildVCDelegate <NSObject>

- (void)slideContentOffsetY:(CGFloat)offsetY childVC:(WeiboUserInfoChildVC *)viewController;

@end



@interface WeiboUserInfoChildVC : UIViewController

@property (nonatomic, readonly, strong) UITableView *tableView;

@property (nonatomic, weak) id<WeiboUserInfoChildVCDelegate> delegate;

- (void)setMainVCOffsetY:(CGFloat)offsetY;

@end
