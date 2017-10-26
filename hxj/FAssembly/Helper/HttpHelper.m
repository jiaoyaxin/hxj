//
//  HttpHelper.m
//  zjproject
//
//  Created by rockontrol on 15/4/14.
//  Copyright (c) 2015年 rockontrol. All rights reserved.
//

#import "HttpHelper.h"
#import <AFNetworking/AFNetworking.h>


#define kNetworkNotReachable @"网络连接已断开"


@implementation HttpHelper

+ (void)httpDataRequest:(NSString*)urlString
        paramDictionary:(NSDictionary*)paramDictionary
                request:(void (^)(id))request
                   fail:(void (^)(NSString *))backError
{
    //if (![AFNetworkReachabilityManager manager].reachable) return error(kNetworkNotReachable);
    
    NSMutableDictionary *theDic = [[NSMutableDictionary alloc] initWithDictionary:paramDictionary];
    
    // 验证参数
    FAUserInfo *userInfo = [FAUserInfo share];
    if (userInfo) {
        NSString *uid;
        id p = [theDic objectForKey:@"uid"];
        if ([p isKindOfClass:[NSString class]]) uid = p;
        if ([p isKindOfClass:[NSNumber class]]) uid = [(NSNumber*)p stringValue];
        
        if (uid == nil || uid.length == 0) {
            //[theDic setObject:[NSString stringWithFormat:@"%ld", (long)userInfo.uid] forKey:@"uid"];
        }
//        NSString *ReqUserToken = [theDic objectForKey:@"ReqUserToken"];
//        if (ReqUserToken == nil || ReqUserToken.length == 0) {
//            [theDic setObject:userInfoClass.userToken forKey:@"ReqUserToken"];
//        }
    }
    // 标明ios设备 非必需
    //[theDic setObject:@"2" forKey:@"phoneType"];
    
    // go
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    AFJSONResponseSerializer *responseSetting = [AFJSONResponseSerializer new];
    responseSetting.removesKeysWithNullValues = YES;
    manager.responseSerializer = responseSetting;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];

    AFJSONRequestSerializer *requestSetting = [AFJSONRequestSerializer new];
    //manager.requestSerializer = requestSetting;

    if (CanHttpLog) jLog(@"-----\n🌈%@\n%@",urlString,theDic);
    [manager POST:urlString
       parameters:theDic progress:^(NSProgress * _Nonnull uploadProgress) {
           
       } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
           request(responseObject);
           
           NSData *dataR = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
           NSString *url = task.currentRequest.URL.absoluteString;

           if (CanHttpLog) jLog(@"-----\n🌈%@\n👍%@", url, dataR ? [[NSString alloc] initWithData:dataR encoding:NSUTF8StringEncoding] : [NSData new]);
           //为了变成ntf-8 要不可以直接 （%@， dic）
           
       } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
           backError([error localizedDescription]);
           if (CanHttpLog) jLog(@"-----\n👋%@", [error localizedDescription]);
           
       }];
}

// 上传图片
+ (void)httpImagePostRequest:(UIImage*)image
                     request:(void (^)(UIImage *, NSString *, NSString *))request {
    
//    NSMutableDictionary *parameters = [NSMutableDictionary new];
//    [parameters setValue:@"fileName" forKey:@"file_1"];

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:kUrlImagePost parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [formData appendPartWithFileData:UIImagePNGRepresentation(image) name:@"fileName" fileName:@"ios_image.jpg" mimeType:@"image/jpeg"];

    } progress:^(NSProgress * _Nonnull uploadProgress) {
        NSString *p = [NSString stringWithFormat:@"%.0f", (double)uploadProgress.completedUnitCount/uploadProgress.totalUnitCount * 100];
        jLog(@"%@", [p stringByAppendingString:@"%"]);
        //[CustomView alertMessage:[p stringByAppendingString:@"%"]];
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (CanHttpLog) jLog(@"-----\n%@", responseObject);
        NSInteger Code = [[responseObject objectForKey:@"code"] integerValue];
        if (Code == 1) {
            NSArray *ary = responseObject[@"data"];
            if (ary.count > 0) {
                request(image, ary.firstObject, nil);
            }
        } else {
            request (nil, nil, responseObject[@"message"]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        request (nil, nil, [error localizedDescription]);
    }];
    
}


@end












