//
//  BaseViewController.h
//  hxj
//
//  Created by keneng6 on 2017/10/25.
//  Copyright © 2017年 焦亚鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController


/**
 *  导航条隐藏 默认显示
 */
@property (nonatomic, assign, getter=isNavBarHidden) BOOL navBarHidden;

/**
 *  导航条颜色 不隐藏的时候生效
 */
@property (nonatomic, strong) UIColor *navBarBackgroudColor;

/**
 *  导航条字体 图片颜色 不隐藏的时候生效
 */
@property (nonatomic, strong) UIColor *navBarTintColor;


/**
 *  键盘弹起 默认不弹起
 */
@property (nonatomic, assign) BOOL IQKeyBoardEnable;

/**
 *  键盘弹起 后的tool
 */
@property (nonatomic, assign) BOOL IQKeyBoardAutoTool;

/**
 *  检查登录
 */
- (BOOL)checkLogin;

/**
 *   leftItem
 */
- (void)addLeftItemTitle:(NSString*)title action:(SEL)action;
- (void)addLeftItemImage:(UIImage *)image action:(SEL)action;

/**
 *   rightItem
 */
- (void)addRightItemTitle:(NSString*)title action:(SEL)action;
- (void)addRightItemImage:(UIImage*)image action:(SEL)action;


#pragma mark -
+ (BaseViewController*)viewControllerWithSB:(NSString*)sbString vcClass:(Class)vcClass;
- (void)pushViewControllerWithSB:(NSString*)sbString vcClass:(Class)vcClass;
- (void)pushViewControllerWithSB:(NSString*)sbString vcClass:(Class)vcClass vcProperty:(BaseViewController *(^)(BaseViewController *vc))thevc;

@end

