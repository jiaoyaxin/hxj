//
//  BaseTabBarController.m
//  hxj
//
//  Created by keneng6 on 2017/10/25.
//  Copyright © 2017年 焦亚鑫. All rights reserved.
//

#import "BaseTabBarController.h"

#import "FAHomePageViewController.h"
#import "FAMinePageViewController.h"


@interface BaseTabBarController ()

@end


@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *navArrary = @[
                           [self createNavigationController:[FAHomePageViewController class] image:@"tabbar_con" title:@"首页" sb:nil],
                           [self createNavigationController:[FAMinePageViewController class] image:@"" title:@"我的" sb:SB_MINE],
                           ];
    
    [self setViewControllers:navArrary];
    self.tabBar.barTintColor = [UIColor colorWithNumber:kWhiteColor];
    self.tabBar.translucent = NO;
    self.tabBar.tintColor = [UIColor colorWithNumber:kRedColor];
    self.selectedIndex = 0;
    
}

- (BaseNavigationController*)createNavigationController:(Class)class image:(NSString*)image title:(NSString*)title sb:(NSString*)sb{
    
    BaseViewController *vc;
    if (sb) {
        vc = [BaseViewController viewControllerWithSB:sb vcClass:class];
    }
    else {
        vc = [class new];
    }
    
    BaseNavigationController *nav = [[BaseNavigationController alloc]initWithRootViewController:vc];
    nav.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nav.tabBarItem.selectedImage = [UIImage imageNamed:[image stringByAppendingString:@"_s"]];
    //[nav.tabBarItem setImageInsets:UIEdgeInsetsMake(5, 0, -5, 0)];
    
    nav.title = title;
    [nav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} forState:UIControlStateNormal]; // text color normal
    [nav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithNumber:kRedColor]} forState:UIControlStateSelected];
    
    return nav;
}

@end
