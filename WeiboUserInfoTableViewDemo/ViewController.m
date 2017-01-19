//
//  ViewController.m
//  WeiboUserInfoTableViewDemo
//
//  Created by 牛严 on 2017/1/18.
//  Copyright © 2017年 牛严. All rights reserved.
//

#import "ViewController.h"
#import "WeiboUserInfoVC.h"
#import "FirstVC.h"
#import "SecondVC.h"
#import "ThirdVC.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (IBAction)btnClicked:(id)sender {
    
    FirstVC *firstVC = [[FirstVC alloc]init];
    SecondVC *secondVC = [[SecondVC alloc]init];
    ThirdVC *thirdVC = [[ThirdVC alloc]init];
    
    WeiboUserInfoVC *vc = [[WeiboUserInfoVC alloc]initWithChildVCs:@[firstVC,secondVC,thirdVC]];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
