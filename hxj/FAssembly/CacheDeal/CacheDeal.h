//
//  CacheDeal.h
//
//
//  Created by rockontrol on 14-6-16.
//  Copyright (c) 2014年 rockontrol. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CacheDeal : NSObject

{
    NSUserDefaults *ud;
    
    NSMutableDictionary *mDic;
}

+(instancetype)getInstancetype;

/**
 *功能：测试是否记录了某个键
 *@param key true时为登记了，false为没有登记
 *@return 是否记录了某个键
 */
-(BOOL)isRegisterKey:(NSString*)key;

/**
 *功能：保存字符串数据
 *@param stringdata 字符串数据
 *@param key 数据
 */
-(void)saveStringValue:(NSString*)stringdata key:(NSString*)key;

/**
 *功能：获取指定键值
 *@param key 键名
 */
-(id)getStringKey:(NSString*)key;

/**
 *功能：删除指定键值
 *@param key 键名
 */
-(void)removeDataKey:(NSString*)key;

/**
 *功能：保存对象到缓存中去
 *@param object 对象
 *@param key 键名
 */
-(void)saveObject:(id)object key:(NSString*)key;

/**
 *功能：获取指定键的对象
 *@param key 指定键名
 *@return 返回对象
 */
-(id)getObject:(NSString*)key;

+ (NSArray *)getArrayByCacheKey:(NSString *)cacheKey
                             sp:(NSString *)sp;

+ (void)saveArrayByCacheKey:(NSString *)cacheKey
                    objects:(NSArray *)objects
                         sp:(NSString *)sp;

@end














