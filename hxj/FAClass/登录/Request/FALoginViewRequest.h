//
//  FALoginViewRequest.h
//  hxj
//
//  Created by keneng6 on 2017/10/26.
//  Copyright © 2017年 焦亚鑫. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FALoginModel.h"


@interface FALoginViewRequest : NSObject

+ (void)requestLoginWithUser:(NSString*)user pw:(NSString*)pw request:(void(^)(FALoginModel *loginModel, NSString *errorMsg))request;

@end
