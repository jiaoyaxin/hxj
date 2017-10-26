//
//  HUDView.h
//  zjproject
//
//  Created by rockontrol on 15/4/15.
//  Copyright (c) 2015年 rockontrol. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MBProgressHUD/MBProgressHUD.h>

@protocol HUDViewDelegate <NSObject>

@optional
- (void)closeWindowBy;

@end

@interface HUDView : UIView

{
    MBProgressHUD *HUD;
    
    //全局弹出提示框
    UIView *mainWindow;
    __weak id mainWindowView;
}

@property (nonatomic, weak) id<HUDViewDelegate> delegate;

+ (instancetype)getInstancetype;

/**
 *  高级提醒框
 *
 */
- (void)windowAlertBy:(id)view
         isTouchClose:(BOOL)isTouchClose
                color:(UIColor *)color
             animated:(BOOL)animated
          addDelegate:(id<HUDViewDelegate>)delegate;

/**
 *  关闭上边的高级提醒框
 */
- (void)closeWindowAlertWithanimated:(BOOL)animated;

/**
 *  关闭上边的高级提醒框
 */
- (void)closeWindowAlertWithanimated:(BOOL)animated
                            complete:(void(^)())complete;

/**
 *  显示等待视图
 *
 */
- (void)showWaitView:(NSString*)noticeMsg;
- (void)showWaitView:(NSString*)noticeMsg byView:(UIView*)view;

/**
 *  关闭等待视图
 */
- (void)closeHUD;

/**
 *  具备回调的消息提醒功能
 *
 */
- (void)showAlertView:(NSString*)noticeMsg
               byView:(UIView*)view
           completion:(void(^)())completion;

/**
 *  具备回调的消息提醒功能
 *
 */
- (void)showAlertView:(NSString*)noticeMsg
               byView:(UIView*)view
                delay:(int)delay
           completion:(void(^)())completion;

/**
 *  警告视图
 *
 */
+ (void)alertView:(NSString*)title content:(NSString*)content;

/**
 *  提醒视图
 *
 */
+ (void)alertMessage:(NSString*)title view:(UIView*)view;




///**
// *  正在进行显示
// *
// */
//+ (void)showWithStatus:(NSString *)string;
//
///**
// *  出错显示
// *
// */
//+ (void)showErrorWithStatus:(NSString *)string;
//
///**
// *  成功显示
// *
// */
//+ (void)showSuccessWithStatus:(NSString *)string;
//
///**
// *  隐藏
// */
//+ (void)dismiss;



@end













