//
//  OJNetWorkTools.h
//  OJNetWorkTools
//
//  Created by OneJ on 2017/3/17.
//  Copyright © 2017年 Onej. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OJNetWorkTools : NSObject
/**
 网络请求方式 POST / GET
 */
typedef enum {
    POST,
    GET
}RequestMethod;


/**
 网络请求数据返回数据格式(XML , JSON)
 */
typedef enum {
    XML,
    JSON
}DataFormat;


/**
 *
 *  类方法,实例化当前数据请求对象
 *
 *  @return 当前请求对象
 */
+ (instancetype)shareRequestData;


/**
 *
 *  请求数据 (session 请求)
 *
 *  @param URLStr     URL 地址
 *  @param parameters 请求所需参数
 *  @param method     POST / GET (默认 GET 请求)
 *  @param success    请求成功回调函数
 *  @param fail       请求失败回调函数
 *
 */
- (void)requestDataURL:(NSString *)URLStr
            parameters:(NSDictionary *)parameters
                method:(RequestMethod)method
               success:(void(^)(NSData *data , NSURLResponse *response))success
                  fail:(void(^)(NSError *error))fail;


/**
 *
 *   请求数据,并对数据进行解析
 *
 *  @param URLStr     URL 地址
 *  @param parameters 请求所需参数
 *  @param method     POST / GET (默认 GET 请求)
 *  @param format     返回数据形势(XML / JSON)
 *  @param success    请求成功回调函数
 *  @param fail       请求失败回调函数
 *
 */
- (void)requestDataURL:(NSString *)URLStr
            parameters:(NSDictionary *)parameters
                method:(RequestMethod)method
            dataFormat:(DataFormat)format
               success:(void (^)(id data,NSURLResponse *response))success
                  fail:(void (^)(NSError *))fail;




@end
