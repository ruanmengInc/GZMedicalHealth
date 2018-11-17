//
//  YYHttpTool.h
//  jadeCircle
//
//  Created by guGuangZhou on 2017/8/29.
//  Copyright © 2017年 guGuangZhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YYCache/YYCache.h>

typedef void (^SuccessBlock)(NSDictionary * requestDic, NSString * msg);
typedef void (^FailureBlock)(NSString *errorInfo);
typedef void (^loadProgress)(float progress);

@interface YYHttpTool : NSObject


/**
 *  Get请求 不对数据进行缓存
 *
 *  @param urlStr  url
 *  @param success 成功的回调
 *  @param failure 失败的回调
 */


+(void)getRequestUrlStr:(NSString *)urlStr isMyFriends:(BOOL)isMyFriendsHeader success:(SuccessBlock)success failure:(FailureBlock)failure;


/**
 *  Get请求 对数据进行缓存
 *
 *  @param urlStr  url
 *  @param success 成功的回调
 */


+(void)getRequestCacheUrlStr:(NSString *)urlStr isMyFriends:(BOOL)isMyFriendsHeader success:(SuccessBlock)success failure:(FailureBlock)failuer ;



/**
 *  Post请求 不对数据进行缓存
 *
 *  @param parameters post参数
 *  @param success    成功的回调
 *  @param failure    失败的回调
 */

+(void)postRequestUrlStrIsHeader:(BOOL)isHeader WithDic:(NSDictionary *)parameters success:(SuccessBlock )success failure:(FailureBlock)failure;


/**
 *  Post请求 对数据进行缓存
 *
 *  @param parameters post参数
 *  @param success    成功的回调
 *  @param failure    失败的回调
 */

+(void)postREquestCacheUrlStrIsHeader:(BOOL)isHeader isMyFriends:(BOOL)isMyFriendsHeader WithDic:(NSDictionary *)parameters success:(SuccessBlock )success failure:(FailureBlock)failure;

/**
 更换uid、appid、appsercet
 
 */
+ (void)postIsHeader:(BOOL)isHeader isMyFriends:(BOOL)isMyFriendsHeader params:(NSDictionary *)params success:(SuccessBlock )success failure:(FailureBlock)failure;

/**
 更换uid、appid、appsercet
 
 */
+ (void)postIsHeader:(BOOL)isHeader isOtherMyFriends:(BOOL)isOtherMyFriends params:(NSDictionary *)params success:(SuccessBlock )success failure:(FailureBlock)failure;

/**
 *  上传单个文件
 *
 *  @param urlStr       服务器地址
 *  @param parameters   参数
 *  @param attach       上传的key
 *  @param data         上传的问价
 *  @param loadProgress 上传的进度
 *  @param success      成功的回调
 *  @param failure      失败的回调
 */

+(void)upLoadDataWithUrlStr:(NSString *)urlStr isMyFriends:(BOOL)isMyFriendsHeader withDic:(NSDictionary *)parameters imageKey:(NSString *)attach withData:(NSData *)data upLoadProgress:(loadProgress)loadProgress success:(SuccessBlock)success failure:(FailureBlock)failure;


@end
