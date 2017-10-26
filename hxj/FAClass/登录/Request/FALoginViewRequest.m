//
//  FALoginViewRequest.m
//  hxj
//
//  Created by keneng6 on 2017/10/26.
//  Copyright © 2017年 焦亚鑫. All rights reserved.
//

#import "FALoginViewRequest.h"

@implementation FALoginViewRequest

+ (void)requestLoginWithUser:(NSString *)user pw:(NSString *)pw request:(void (^)(FALoginModel *, NSString *))request {
    
    NSMutableDictionary *param = [NSMutableDictionary new];
    [param setObject:user forKey:@"phone"];
    [param setObject:pw forKey:@"pwd"];

    [HttpHelper httpDataRequest:kUrlUserLogin paramDictionary:param request:^(id response) {
        
        NSString *msg = response[@"msg"];
        if ([msg isEqualToString:@"success"]) {
            FALoginModel *loginModel = [[FALoginModel alloc] initWithDictionary:response];
            request(loginModel, nil);
        }
        else {
            request(nil, msg);
        }
    } fail:^(NSString *error) {
        request (nil, error);
    }];
    
}
@end
