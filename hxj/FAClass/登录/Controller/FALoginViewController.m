//
//  FALoginViewController.m
//  hxj
//
//  Created by keneng6 on 2017/10/26.
//  Copyright © 2017年 焦亚鑫. All rights reserved.
//

#import "FALoginViewController.h"
#import "FALoginViewRequest.h"


@interface FALoginViewController ()

@end

@implementation FALoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBarHidden = YES;
    
}

- (IBAction)cancelBtnAction:(id)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)loginBtnAction:(id)sender {
    [[HUDView getInstancetype] showWaitView:@"请稍等" byView:self.view];
    [FALoginViewRequest requestLoginWithUser:@"18035101291" pw:@"789456" request:^(FALoginModel *loginModel, NSString *errorMsg) {
        [[HUDView getInstancetype] closeHUD];
        if (errorMsg) {
            [HUDView alertMessage:errorMsg view:self.view];
        }
        else {
            [HUDView alertMessage:@"登录成功" view:self.view];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [FAUserInfo share].login = YES;
                [FAUserInfo share].userId = loginModel.userId;
                [FAUserInfo share].pwd = loginModel.pwd;
                [self.navigationController dismissViewControllerAnimated:YES completion:nil];
            });
            
        }
    }];
}

@end
