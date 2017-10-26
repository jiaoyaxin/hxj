//
//  SettingHeader.h
//  JinheHealthy
//
//  Created by keneng6 on 16/9/14.
//  Copyright © 2016年 焦亚鑫. All rights reserved.
//

#ifndef SettingHeader_h
#define SettingHeader_h


#import "UrlSetting.h"
#import "ColorSetting.h"
#import "SDKKeySetting.h"
#import "NoticeSetting.h"

#define CanHttpLog YES



#define kUserTypeDoctor 1
#define kUserTypeCustomer 0


#define WeakSelf(type)    __weak __typeof(type) weak##type = type;
#define StrongSelf(type)  __strong __typeof(type) strong##type = type;

#define AppResignFirstResponder [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];

// ios10  not work bec echeme !!!
//#ifdef DEBUG
//#define jLog(format, ...) NSLog(format, ## __VA_ARGS__)
//
//#else
//#define jLog(format, ...)
//#endif
#ifdef DEBUG
#define jLog(format, ...) printf("\n[%s] %s [第%d行] %s\n", __TIME__, __PRETTY_FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String]);
#else
#define jLog(format, ...)
#endif



/**
 本地文档地址
 */
//数据库定义
#define DBName @"jinheLV.db"
#define DBPath @"DB"
#define DBVersion @"1.0.1"

//音乐文件文件夹名字
#define MusicPath @"MusicPath"

//地址文件的文件夹名和文件名
#define JinHeAddress @"JinHeAddress"
#define JinHeAddressArea @"JinHeAddressArea.json"

/**
 *  地区文件的版本
 */
#define AreaVersion @"AreaVersion"


#pragma mark - Storyboard 故事版
// 应该用泛型枚举 替换下面
#define SB_MINE @"StoryboardMinePage"
#define SB_LOGIN @"StoryboardLogin"
//#define SB_MINE @"StoryboardMinePage"
//#define SB_MINE @"StoryboardMinePage"



//记录天气信息
#define WEATHER @"weather"

#define kFontNormal [UIFont systemFontOfSize:13]


#endif /* SettingHeader_h */
