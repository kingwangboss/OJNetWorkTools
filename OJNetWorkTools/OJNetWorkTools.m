//
//  OJNetWorkTools.m
//  OJNetWorkTools
//
//  Created by OneJ on 2017/3/17.
//  Copyright © 2017年 Onej. All rights reserved.
//

#import "OJNetWorkTools.h"

#import "XMLReaders.h"
@implementation OJNetWorkTools

+ (instancetype)shareRequestData
{
    
    static OJNetWorkTools *singleToken;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        if (singleToken == nil) {
            singleToken = [[OJNetWorkTools alloc] init];
        }
        
    });
    return singleToken;
}

/**
 *
 *  请求数据 (session 请求)
 *
 *  @param URLStr     URL 地址
 *  @param parameters 请求所需参数
 *  @param method     POST / GET (默认 GET 请求)
 *  @param success    请求成功回调函数
 *  @param fail      请求失败回调函数
 *
 */
- (void)requestDataURL:(NSString *)URLStr
            parameters:(NSDictionary *)parameters
                method:(RequestMethod)method
               success:(void (^)(NSData *data , NSURLResponse *response))success
                  fail:(void (^)(NSError *error))fail
{
    
    NSURL *URL = nil;
    NSMutableURLRequest *request = nil;
    if (method == POST) {
        //判断 URL
        if (URLStr != nil) {
            URL = [NSURL URLWithString:URLStr];
            request = [NSMutableURLRequest requestWithURL:URL];
        }else {
            NSError *error = [NSError errorWithDomain:@"error" code:0 userInfo:@{@"error":@"URL 错误!"}];
            fail(error);
            return;
        }
        request.HTTPMethod = @"POST";
        if (parameters != nil){
            NSString *parametersStr = [self NSDictionaryToNSString:parameters];
            NSData *bodyData = [parametersStr dataUsingEncoding:NSUTF8StringEncoding];
            request.HTTPBody = bodyData;
        }
    }else {
        //判断 URL
        if (URLStr != nil) {
            if (parameters != nil){
                NSMutableString *str = [NSMutableString stringWithFormat:@"%@?%@",URLStr,[self NSDictionaryToNSString:parameters]];
                URL = [NSURL URLWithString:str];
            }else {
                URL = [NSURL URLWithString:URLStr];
            }
            request = [NSMutableURLRequest requestWithURL:URL];
        }else {
            NSError *error = [NSError errorWithDomain:@"error" code:0 userInfo:@{@"error":@"URL 错误!"}];
            fail(error);
            return;
        }
    }
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error == nil && data != nil){
            success(data,response);
        }else {
            fail(error);
        }
    }];
    [dataTask resume];
}

/**
 *
 *  请求数据,并对数据进行解析
 *
 *  @param URLStr       URL 地址
 *  @param parameters   请求所需参数
 *  @param method       POST / GET (默认 GET 请求)
 *  @param format       返回数据形势(XML / JSON)
 *  @param success      请求成功回调函数
 *  @param fail         请求失败回调函数
 *
 */
- (void)requestDataURL:(NSString *)URLStr
            parameters:(NSDictionary *)parameters
                method:(RequestMethod)method
            dataFormat:(DataFormat)format
               success:(void (^)( id data,NSURLResponse *response))success
                  fail:(void (^)(NSError *))fail
{
    
    [self requestDataURL:URLStr parameters:parameters method:method success:^(NSData *data, NSURLResponse *response) {
        id result = nil;
        if (format == JSON){
            NSError *error = nil;
            result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:&error];
            if (!error){
                success(result , response);
            }else {
                fail(error);
            }
        }else if (format == XML){
            NSError *error = nil;
            result = [XMLReaders dictionaryForXMLData:data error:&error];
            if (!error){
                success(result , response);
            }else {
                fail(error);
            }
        }else {
            NSError *error = [NSError errorWithDomain:@"error" code:0 userInfo:@{@"error":@"返回数据类型错误!"}];
            fail(error);
            return;
        }
        
    } fail:^(NSError *error) {
        fail(error);
    }];
}


/**
 *
 *  将 NSDictionary 装换为符合网络请求参数形势 NSString
 *
 *  @param dic 网络请求参数
 *
 *  @return 转换后字符串
 */
- (NSString *)NSDictionaryToNSString:(NSDictionary *)dic
{
    
    NSMutableString *parametersStr = [NSMutableString string];
    for (NSString *key in dic ) {
        [parametersStr appendFormat:@"%@=%@&",key,[dic objectForKey:key]];
    }
    return [parametersStr substringToIndex:([parametersStr length] - 1)];
}



@end
