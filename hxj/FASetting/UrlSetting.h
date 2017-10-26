//
//  UrlSetting.h
//  JinheHealthy
//
//  Created by keneng6 on 16/9/14.
//  Copyright © 2016年 焦亚鑫. All rights reserved.
//

#ifndef UrlSetting_h
#define UrlSetting_h
#endif /* UrlSetting_h */

#ifndef Api_IP
#define Api_IP @"https://www.jhx365.com"   // 主
#endif


#define RequestSize 20
#define RequestSkip(num) ((NSInteger)num-1)*RequestSize



#define BaseUrl(api_IP, lastUrl) ([NSString stringWithFormat:@"%@%@", (api_IP), (lastUrl)])

#pragma mark - 分享
/**
 *  分享路径
 */
#define kShareUrlDongtai(dynamicID, shareUID) ([NSString stringWithFormat:@"http://cdn3.ttce.cn/ttce_treate/mobile/share.html?action=dynamic&dynamicID=%@&shareUID=%ld", dynamicID, (long)(shareUID)])

#pragma mark - 图片上传
/**
 *  图片上传
 */
#define kUrlImagePost BaseUrl(Api_IP, @"/medical-assist/japi/medical/Ad/getAdList")

#pragma mark - 登录注册
/**
 *  登录
 */
#define kUrlUserLogin BaseUrl(Api_IP, @"/userLoginSubmit.do?")


#pragma mark - 广告 直播
/**
 *  获取最新广告
 */
#define kUrlImagePost BaseUrl(Api_IP, @"/medical-assist/japi/medical/Ad/getAdList")
/**
 *  获取录播列表
 */
#define kUrlGetLvList BaseUrl(Api_IP, @"/medical-assist/japi/medical/Ad/getPlaybackList")

