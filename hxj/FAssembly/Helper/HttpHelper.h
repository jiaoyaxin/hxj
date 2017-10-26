//
//  HttpHelper.h
//  zjproject
//
//  Created by rockontrol on 15/4/14.
//  Copyright (c) 2015年 rockontrol. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpHelper : NSObject

/**
 *  Post
 *
 *  @param urlString url
 *  @param paramDictionary 参数
 *  @param request 回调（response字典 已摘去value NULL的key， 并不是服务器没有返回）
 */
+ (void)httpDataRequest:(NSString*)urlString
        paramDictionary:(NSDictionary*)paramDictionary
                request:(void(^)(id response))request
                   fail:(void(^)(NSString *error))backError;


// 上传图片
+ (void)httpImagePostRequest:(UIImage*)image
                     request:(void(^)(UIImage *image, NSString *imageKey, NSString *errorMsg))request;


@end












