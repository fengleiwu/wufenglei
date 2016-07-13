//
//  RequestManager.h
//  02UILessonGETRequest
//
//  Created by lanou on 16/5/23.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>

//请求数据成功之后进行回调
typedef void(^Finish)(NSData *data);
//请求数据失败之后进行回调 返回NSError
typedef void(^Error)(NSError *error);
//请求方式的枚举
typedef NS_ENUM(NSInteger,RequestType){
    RequestGET,
    RequestPOST
};
@interface RequestManager : NSObject
@property(nonatomic , copy)Finish finish;
@property(nonatomic , copy)Error error;


+(void)requestWithUrlString:(NSString *)urlString requestType:(RequestType)requestType parDic:(NSDictionary *)parDic finish:(Finish)finish error:(Error)error;


@end
