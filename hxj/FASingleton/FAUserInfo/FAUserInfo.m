//
//  FAUserInfo.m
//  hxj
//
//  Created by keneng6 on 2017/10/26.
//  Copyright © 2017年 焦亚鑫. All rights reserved.
//

#import "FAUserInfo.h"


#define UserInfoKey @"UserInfoKey" //用户信息key


@implementation FAUserInfo

+ (instancetype)share {
    static FAUserInfo *share = nil;
    static dispatch_once_t onceT;
    dispatch_once(&onceT, ^{
        share = [self new];
    });
    return share;
}


#pragma mark - 登录 登出
/**
 *   登录app及im
 *
 */
- (void)loginWithInfo:(FAUserInfo *)info success:(success)success fail:(fail)fail  {
    
    [self dealWithLoginInfo:info];
    [self saveUserInfo];
    
}


/**
 *   退出登录app及im
 *
 */
- (void)logoutComption:(void(^)(NSString *message,
                                NSString *errorMsg))comption {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kAppLoginOut object:nil];

}

#pragma mark - 本地存储操作
/**
 *  保存到本地
 *
 */
- (void)saveUserInfo {
    NSDictionary *dic = [self toDictionary];
    [[CacheDeal getInstancetype] saveObject:dic key:UserInfoKey];
}

/**
 *  清除本地用户信息
 */
- (void)clearUserInfo {
    //    [UMessage removeAlias:[@([UserInfoClass share].uid) stringValue] type:@"jh" response:^(id  _Nonnull responseObject, NSError * _Nonnull error) {
    //
    //    }];
    
    [[CacheDeal getInstancetype] removeDataKey:UserInfoKey];
}

/**
 *  保存用户信息
 *
 *  @param imUserClass imInfo
 */
//+ (void)saveIMUserClass:(IMUserClass *)imUserClass;

#pragma mark -
- (void)dealWithLoginInfo:(FAUserInfo*)info {

    
    [[NSNotificationCenter defaultCenter] postNotificationName:kAppLoginSuccess object:nil];
    
//    [UMessage setAlias:[@(info.uid) stringValue] type:@"jh" response:^(id  _Nonnull responseObject, NSError * _Nonnull error) {
//
//    }];
    
}


@end
