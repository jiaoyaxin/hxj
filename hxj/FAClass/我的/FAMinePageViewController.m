//
//  FAMinePageViewController.m
//  hxj
//
//  Created by keneng6 on 2017/10/26.
//  Copyright © 2017年 焦亚鑫. All rights reserved.
//

#import "FAMinePageViewController.h"

@interface FAMinePageViewController ()

@end

@implementation FAMinePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBarHidden = YES;
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self checkLogin];
}

@end
