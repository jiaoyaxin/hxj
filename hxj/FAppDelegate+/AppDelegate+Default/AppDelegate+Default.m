//
//  AppDelegate+Default.m
//  hxj
//
//  Created by keneng6 on 2017/10/26.
//  Copyright © 2017年 焦亚鑫. All rights reserved.
//

#import "AppDelegate+Default.h"

@implementation AppDelegate (Default)

- (void)appDefault {
    [UINavigationBar appearance].tintColor = [UIColor blackColor];
    [UINavigationBar appearance].barTintColor = [UIColor colorWithNumber:kWhiteColor];
    [UINavigationBar appearance].barStyle = UIBarStyleDefault;
    [UINavigationBar appearance].translucent = NO;
    
    [UITabBar appearance].tintColor = [UIColor blackColor];
    [UITabBar appearance].barTintColor = [UIColor colorWithNumber:kWhiteColor];
    [UITabBar appearance].barStyle = UIBarStyleDefault;
    [UITabBar appearance].translucent = NO;
    
    [UILabel appearance].font = kFontNormal;
    [UILabel appearance].textColor = [UIColor colorWithNumber:kTitleColor];
}

@end
