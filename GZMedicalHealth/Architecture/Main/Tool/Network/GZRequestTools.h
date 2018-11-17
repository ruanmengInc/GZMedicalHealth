//
//  GZRequestTools.h
//  MVVM_小试牛刀
//
//  Created by guGuangZhou on 2017/10/16.
//  Copyright © 2017年 guGuangZhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RACSignal,JSFileConfig;

typedef NS_ENUM(NSInteger, GZRequestType) {
    GZRequestTypeGET = 0,
    GZRequestTypePOST,
    GZRequestTypeDELETE,
    GZRequestTypePUT,
    GZRequestTypePOSTUPLOAD
};

/**
 *  简单用RAC封装的请求下
 */
@interface GZRequestTools : NSObject

+ (RACSignal *)js_getURL:(NSString *)url para:(NSMutableDictionary *)para;

+ (RACSignal *)js_postURL:(NSString *)url para:(NSMutableDictionary *)para isHeader:(BOOL)isHeader;

+ (RACSignal *)js_deleteURL:(NSString *)url para:(NSMutableDictionary *)para;

+ (RACSignal *)js_putURL:(NSString *)url para:(NSMutableDictionary *)para;

+ (RACSignal *)js_uploadURL:(NSString *)url para:(NSMutableDictionary *)para files:(NSMutableArray <JSFileConfig *>*)files;

@end


/**
 *  用来封装上文件数据的模型类
 */
@interface JSFileConfig : NSObject
/**
 *  文件数据
 */
@property (nonatomic, strong) NSData *fileData;

/**
 *  服务器接收参数名
 */
@property (nonatomic, copy) NSString *name;

/**
 *  文件名
 */
@property (nonatomic, copy) NSString *fileName;

/**
 *  文件类型
 */
@property (nonatomic, copy) NSString *mimeType;

+ (instancetype)fileConfigWithfileData:(NSData *)fileData
                                  name:(NSString *)name
                              fileName:(NSString *)fileName
                              mimeType:(NSString *)mimeType;

- (instancetype)initWithfileData:(NSData *)fileData
                            name:(NSString *)name
                        fileName:(NSString *)fileName
                        mimeType:(NSString *)mimeType;


@end
