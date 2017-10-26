//
//  FAUserInfo.h
//  hxj
//
//  Created by keneng6 on 2017/10/26.
//  Copyright © 2017年 焦亚鑫. All rights reserved.
//

#import <jastor/Jastor.h>

typedef void(^success)(void);
typedef void(^fail)(NSString *err);


@interface FAUserInfo : Jastor

@property (nonatomic, assign, getter=isLogin) BOOL login;

@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *pwd;


#pragma mark - share
+ (instancetype)share;


#pragma mark - 登录 登出
/**
 *   登录app及im
 *
 */
- (void)loginWithInfo:(FAUserInfo*)info success:(success)success fail:(fail)fail;

- (void)aotuLoginWithInfo:(FAUserInfo*)info success:(success)success fail:(fail)fail;

/**
 *   退出登录app及im
 *
 */
- (void)logoutComption:(void(^)(NSString *message,
                                NSString *errorMsg))comption;

#pragma mark - 本地存储操作
/**
 *  读取本地用户信息 并自动登录
 *
 */
- (void)loadUserInfo:(void(^)(NSString *name, NSString *pw))info success:(success)success fail:(fail)fail;

/**
 *  保存到本地
 */
- (void)saveUserInfo;

/**
 *  清除本地用户信息
 */
- (void)clearUserInfo;
@end
