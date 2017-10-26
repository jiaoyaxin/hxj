//
//  BaseViewController.m
//  hxj
//
//  Created by keneng6 on 2017/10/25.
//  Copyright © 2017年 焦亚鑫. All rights reserved.
//

#import "BaseViewController.h"
#import "FALoginViewController.h"


#define kDefaultBackgroudColor  [UIColor whiteColor]
#define kDefaultTintColor       [UIColor blackColor]


@interface BaseViewController () <UINavigationControllerDelegate>

@end


@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _IQKeyBoardAutoTool = YES;
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor colorWithNumber:0xf2f2f2];
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeSystem];
    leftButton.frame = CGRectMake(0, 0, 30, 30);
    [leftButton setImage:[[UIImage imageNamed:@"con_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:(UIControlStateNormal)];
    [leftButton addTarget:self action:@selector(backAction) forControlEvents:(UIControlEventTouchUpInside)];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    
    self.navigationItem.hidesBackButton = NO; //隐藏不隐藏UI没区别 隐藏会导致 三个点点出现
    if (self.navigationController.viewControllers.count > 1) {
        self.navigationItem.leftBarButtonItem = leftItem;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:_navBarHidden animated:YES];
    
    self.navigationController.navigationBar.barTintColor = _navBarBackgroudColor ? _navBarBackgroudColor:kDefaultBackgroudColor;
    self.navigationController.navigationBar.barStyle = _navBarBackgroudColor ? UIBarStyleBlack:UIBarStyleDefault;
    //self.navigationController.navigationBar.translucent = _navBarBackgroudColor;
    self.navigationController.navigationBar.tintColor = _navBarTintColor ? _navBarTintColor:kDefaultTintColor;
    self.navigationController.navigationBar.titleTextAttributes =  @{NSForegroundColorAttributeName:_navBarTintColor ? _navBarTintColor:kDefaultTintColor};
    
    if ((self.navigationController.viewControllers.count > 1)&&[self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
        //self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
    else {
        //self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [IQKeyboardManager sharedManager].enable = _IQKeyBoardEnable;
    [IQKeyboardManager sharedManager].enableAutoToolbar = _IQKeyBoardAutoTool;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [IQKeyboardManager sharedManager].enable = NO;
}

#pragma mark -
- (void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)addLeftItemTitle:(NSString*)title action:(SEL)action {
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:action];
    [item setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} forState:UIControlStateNormal];
    NSMutableArray *items = [NSMutableArray new];
    [items addObjectsFromArray:self.navigationItem.leftBarButtonItems];
    [items addObject:item];
    self.navigationItem.leftBarButtonItems = items;
}

- (void)addLeftItemImage:(UIImage *)image action:(SEL)action {
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]  style:UIBarButtonItemStylePlain target:self action:action];
    NSMutableArray *items = [NSMutableArray new];
    [items addObjectsFromArray:self.navigationItem.leftBarButtonItems];
    [items addObject:item];
    self.navigationItem.leftBarButtonItems = items;
}

- (void)addRightItemTitle:(NSString*)title action:(SEL)action {
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:action];
    [item setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} forState:UIControlStateNormal];
    NSMutableArray *items = [NSMutableArray new];
    [items addObjectsFromArray:self.navigationItem.rightBarButtonItems];
    [items addObject:item];
    self.navigationItem.rightBarButtonItems = items;
}

- (void)addRightItemImage:(UIImage *)image action:(SEL)action {
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]  style:UIBarButtonItemStylePlain target:self action:action];
    NSMutableArray *items = [NSMutableArray new];
    [items addObjectsFromArray:self.navigationItem.rightBarButtonItems];
    [items addObject:item];
    self.navigationItem.rightBarButtonItems = items;
}

- (BOOL)checkLogin {
    if([FAUserInfo share].login && ![self isBeingDismissed]) {
        return YES;
    }
    else {
        dispatch_async(dispatch_get_main_queue(), ^{
            BaseViewController *vc = (id)[BaseViewController viewControllerWithSB:SB_LOGIN vcClass:[FALoginViewController class]];
            BaseNavigationController *nav = [[BaseNavigationController alloc]initWithRootViewController:vc];
            [self presentViewController:nav animated:NO completion:nil];
        });
        return NO;
    }
    return NO;
}


#pragma mark -
+ (BaseViewController*)viewControllerWithSB:(NSString*)sbString vcClass:(Class)vcClass {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:sbString bundle:nil];
    BaseViewController *vc = [sb instantiateViewControllerWithIdentifier:NSStringFromClass(vcClass)];
    return vc;
}

- (void)pushViewControllerWithSB:(NSString*)sbString vcClass:(__unsafe_unretained Class)vcClass {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:sbString bundle:nil];
    BaseViewController *vc = [sb instantiateViewControllerWithIdentifier:NSStringFromClass(vcClass)];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)pushViewControllerWithSB:(NSString *)sbString vcClass:(Class)vcClass vcProperty:(BaseViewController *(^)(BaseViewController *))thevc {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:sbString bundle:nil];
    BaseViewController *vc = [sb instantiateViewControllerWithIdentifier:NSStringFromClass(vcClass)];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:thevc(vc) animated:YES];
}


#pragma mark -
- (void)dealloc {
    jLog(@"成功退出并释放视图：%@ %@", NSStringFromClass([self class]), self.title);
}

@end
