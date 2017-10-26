
//
//  HUDView.m
//  zjproject
//
//  Created by rockontrol on 15/4/15.
//  Copyright (c) 2015年 rockontrol. All rights reserved.
//

#import "HUDView.h"
#import "MBProgressHUD.h"
//#include "KGStatusBar.h"
#define kUIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


@implementation HUDView

static HUDView* object = nil;
+ (instancetype)getInstancetype
{
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        object = [[HUDView alloc] init];
    });
    return object;
}

- (void)windowAlertBy:(id)view
         isTouchClose:(BOOL)isTouchClose
                color:(UIColor *)color
             animated:(BOOL)animated
          addDelegate:(id<HUDViewDelegate>)delegate{
    _delegate = delegate;
    mainWindowView = view;
    mainWindow = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [view setCenter:CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height/2)];
    [[UIApplication sharedApplication].keyWindow addSubview:mainWindow];
    [[UIApplication sharedApplication].keyWindow addSubview:view];
    
    //颜色
    if (color == nil) {
        color = [UIColor colorWithWhite:0 alpha:0.5];
    }
    [mainWindow setBackgroundColor:color];
    
    //触摸
    if (isTouchClose) {
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeWindowAlertWithanimated:)];
        [mainWindow addGestureRecognizer:tapGesture];
    }
    if (animated) {
        [mainWindow setAlpha:0];
        [UIView animateWithDuration:0.2 animations:^{
            [mainWindow setAlpha:1];
        } completion:nil];
    }
}

- (void)closeWindowAlertWithanimated:(BOOL)animated{
    WeakSelf(self);
    dispatch_queue_t  queue =  dispatch_get_main_queue();
    dispatch_async(queue, ^{
        if (animated) {
            [UIView animateWithDuration:0.2 animations:^{
                [((UIView*)mainWindowView) setAlpha:0];
                [mainWindow setAlpha:0];
            } completion:^(BOOL finished) {
                [mainWindowView removeFromSuperview];
                mainWindowView = nil;
                [mainWindow setHidden:true];
                [mainWindow removeFromSuperview];
                mainWindow = nil;
                
                if ([weakself.delegate respondsToSelector:@selector(closeWindowBy)]) {
                    [weakself.delegate closeWindowBy];
                }
            }];
        }else{
            if (![weakself.delegate respondsToSelector:@selector(closeWindowBy)]) {
                [mainWindowView removeFromSuperview];
                mainWindowView = nil;
                [mainWindow setHidden:true];
                [mainWindow removeFromSuperview];
                mainWindow = nil;
            } else {
                [weakself.delegate closeWindowBy];
            }
        }
    });
}

- (void)closeWindowAlertWithanimated:(BOOL)animated
                            complete:(void(^)())complete{
    dispatch_queue_t  queue =  dispatch_get_main_queue();
    dispatch_async(queue, ^{
        if (animated) {
            complete();
            [UIView animateWithDuration:0.2 animations:^{
                [((UIView*)mainWindowView) setAlpha:0];
                [mainWindow setAlpha:0];
            } completion:^(BOOL finished) {
                [mainWindowView removeFromSuperview];
                mainWindowView = nil;
                [mainWindow setHidden:true];
                [mainWindow removeFromSuperview];
                mainWindow = nil;
            }];
        }else{
            complete();
            [mainWindowView removeFromSuperview];
            mainWindowView = nil;
            [mainWindow setHidden:true];
            [mainWindow removeFromSuperview];
            mainWindow = nil;
        }
    });
}

- (void)showWaitView:(NSString*)noticeMsg {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    HUD = [[MBProgressHUD alloc] initWithView:window];
    if ([noticeMsg length] == 0) {
        HUD.mode = MBProgressHUDModeText;
    }else{
        HUD.detailsLabelText = noticeMsg;
    }
    [window addSubview:HUD];
    [HUD show:YES];
}

- (void)showWaitView:(NSString*)noticeMsg byView:(UIView*)view{
    HUD = [[MBProgressHUD alloc] initWithView:view];
    if ([noticeMsg length] == 0) {
        HUD.mode = MBProgressHUDModeCustomView;
    }else{
        HUD.detailsLabelText = noticeMsg;
    }
    [view addSubview:HUD];
    [HUD show:YES];
}

- (void)closeHUD
{
    if (HUD) {
        [HUD hide:YES];
        [HUD removeFromSuperview];
        HUD = nil;
    }
}

- (void)showAlertView:(NSString*)noticeMsg
               byView:(UIView*)view
           completion:(void(^)())completion{
    if (view == nil) {
        return;
    }
    HUD = [[MBProgressHUD alloc] initWithView:view];
    [view addSubview:HUD];
    //    HUD.labelText = noticeMsg;
    HUD.detailsLabelText = noticeMsg;
    HUD.mode = MBProgressHUDModeText;
    [HUD showAnimated:YES whileExecutingBlock:^{
        sleep(2);
    } completionBlock:^{
        [HUD removeFromSuperview];
        HUD = nil;
        
        completion();
    }];
}

- (void)showAlertView:(NSString*)noticeMsg
               byView:(UIView*)view
                delay:(int)delay
           completion:(void(^)())completion{
    HUD = [[MBProgressHUD alloc] initWithView:view];
    [view addSubview:HUD];
    //    HUD.labelText = noticeMsg;
    HUD.detailsLabelText = noticeMsg;
    HUD.mode = MBProgressHUDModeText;
    [HUD showAnimated:YES whileExecutingBlock:^{
        sleep(delay);
    } completionBlock:^{
        [HUD removeFromSuperview];
        HUD = nil;
        
        completion();
    }];
}

+ (void)alertView:(NSString*)title content:(NSString*)content
{
    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:title message:content delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alertView show];
}

+ (void)alertMessage:(NSString*)title{
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIWindow *window = app.window;
    
    MBProgressHUD *HUD = [MBProgressHUD HUDForView:window];
    if (HUD) {
        HUD.detailsLabel.text = title;
    }
    else {
        HUD = [[MBProgressHUD alloc] initWithView:window];
        if (title.length == 0) {
            HUD.mode = MBProgressHUDModeCustomView;
        }else{
            HUD.detailsLabelText = title;
        }
        [window addSubview:HUD];
        [HUD show:YES];
        [HUD hide:YES afterDelay:2];
    }
}

+ (void)alertMessage:(NSString*)title view:(UIView*)view{
    if (view == nil) {
        return;
    }
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
    HUD.mode = MBProgressHUDModeText;
    //    hud.labelText = title;
    HUD.detailsLabelText = title;
    HUD.margin = 20.f;
    HUD.yOffset = 150.f;
    HUD.removeFromSuperViewOnHide = YES;
    [HUD hide:YES afterDelay:2];
}

//+ (void)showWithStatus:(NSString *)string{
//    [KGStatusBar showWithStatus:string];
//}
//
//+ (void)showErrorWithStatus:(NSString *)string{
//    [KGStatusBar showErrorWithStatus:string];
//}
//
//+ (void)showSuccessWithStatus:(NSString *)string{
//    [KGStatusBar showSuccessWithStatus:string];
//}
//
//+ (void)dismiss{
//    [KGStatusBar dismiss];
//}

- (void)dealloc{
    _delegate = nil;
}

@end










