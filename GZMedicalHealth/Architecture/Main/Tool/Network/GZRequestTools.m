//
//  GZRequestTools.m
//  MVVM_小试牛刀
//
//  Created by guGuangZhou on 2017/10/16.
//  Copyright © 2017年 guGuangZhou. All rights reserved.
//

#import "GZRequestTools.h"

@implementation GZRequestTools


+ (RACSignal *)js_postURL:(NSString *)url para:(NSMutableDictionary *)para isHeader:(BOOL)isHeader{
    
    return [self js_baseRequestWithType:GZRequestTypePOST URL:url para:para isHeader:isHeader];
}

+ (RACSignal *)js_getURL:(NSString *)url para:(NSMutableDictionary *)para{
    
    return [self js_baseRequestWithType:GZRequestTypeGET URL:url para:para isHeader:NO];
}

+ (RACSignal *)js_deleteURL:(NSString *)url para:(NSMutableDictionary *)para{
    
    return [self js_baseRequestWithType:GZRequestTypeDELETE URL:url para:para isHeader:NO];
}

+ (RACSignal *)js_putURL:(NSString *)url para:(NSMutableDictionary *)para{
    
    return [self js_baseRequestWithType:GZRequestTypePUT URL:url para:para isHeader:NO];
}

+ (RACSignal *)js_uploadURL:(NSString *)url para:(NSMutableDictionary *)para files:(NSMutableArray <JSFileConfig *>*)files{
    return [self js_baseRequestWithType:GZRequestTypePOSTUPLOAD URL:url para:para files:files isHeader:NO];
}

+ (RACSignal *)js_baseRequestWithType:(GZRequestType)type URL:(NSString *)url para:(NSMutableDictionary *)para isHeader:(BOOL)isHeader{
    return [self js_baseRequestWithType:type URL:url para:para files:nil isHeader:isHeader];
}

+ (RACSignal *)js_baseRequestWithType:(GZRequestType)type URL:(NSString *)url para:(NSMutableDictionary *)para files:(NSMutableArray <JSFileConfig *>*)files isHeader:(BOOL)isHeader {
    
    RACReplaySubject *subject = [RACReplaySubject subject];
    
    AFHTTPSessionManager *manage = [AFHTTPSessionManager manager];
    manage.requestSerializer.timeoutInterval = 30.f;
    AFJSONResponseSerializer *response = [AFJSONResponseSerializer serializer];
    response.removesKeysWithNullValues = YES;
    manage.responseSerializer = response;
    manage.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html",@"text/plain",@"image/jpeg",@"image/png",@"application/octet-stream",@"text/json",nil];
    
    if (isHeader) {
        [manage.requestSerializer setValue:[GZTool isAppid] forHTTPHeaderField:@"appid"];
        [manage.requestSerializer setValue:[GZTool isAppsecret] forHTTPHeaderField:@"appsecret"];
    }
    
    switch (type) {
        case GZRequestTypeGET:
        {
            [manage GET:url
             parameters:para
               progress:nil
                success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    [subject sendNext:responseObject];
                    [subject sendCompleted];
                }
                failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    [subject sendError:error];
                }];
            
        }
            break;
        case GZRequestTypePOST:
        {
            [manage POST:url
              parameters:para
                progress:nil
                 success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
                     //                     NSHTTPURLResponse * responses = (NSHTTPURLResponse *)task.response;
                     
                     [subject sendNext:responseObject];
                     [subject sendCompleted];
                 }
                 failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
                     [subject sendError:error];
                 }];
            
        }
            break;
            
        case GZRequestTypePUT:
        {
            [manage PUT:url
             parameters:para
                success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
                    //                     NSHTTPURLResponse * responses = (NSHTTPURLResponse *)task.response;
                    [subject sendNext:responseObject];
                    [subject sendCompleted];
                }
                failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
                    [subject sendError:error];
                }];
            
        }
            break;
            
        case GZRequestTypeDELETE:
        {
            [manage DELETE:url
                parameters:para
                   success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
                       //                     NSHTTPURLResponse * responses = (NSHTTPURLResponse *)task.response;
                       [subject sendNext:responseObject];
                       [subject sendCompleted];
                   }
                   failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
                       [subject sendError:error];
                   }];
            
        }
            break;
        case GZRequestTypePOSTUPLOAD:
        {
            [manage POST:url
              parameters:para
constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
    
    for (JSFileConfig *file in files) {
        [formData appendPartWithFileData:file.fileData name:file.name fileName:file.fileName mimeType:file.mimeType];
    }
}
                progress:^(NSProgress * _Nonnull uploadProgress) {
                    [subject sendNext:uploadProgress];
                }
                 success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                     [subject sendCompleted];
                 }
                 failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                     [subject sendError:error];
                 }];
            
        }
            break;
            
    }
    return subject;
}

@end


/**
 *  用来封装上传参数
 */
@implementation JSFileConfig

+ (instancetype)fileConfigWithfileData:(NSData *)fileData
                                  name:(NSString *)name
                              fileName:(NSString *)fileName
                              mimeType:(NSString *)mimeType {
    
    return [[self alloc] initWithfileData:fileData
                                     name:name
                                 fileName:fileName
                                 mimeType:mimeType];
}

- (instancetype)initWithfileData:(NSData *)fileData
                            name:(NSString *)name
                        fileName:(NSString *)fileName
                        mimeType:(NSString *)mimeType {
    
    if (self = [super init]) {
        
        _fileData = fileData;
        _name = name;
        _fileName = fileName;
        _mimeType = mimeType;
    }
    return self;
}

@end
