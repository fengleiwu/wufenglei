//
//  RequestManager.m
//  02UILessonGETRequest
//
//  Created by lanou on 16/5/23.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "RequestManager.h"

@implementation RequestManager


+(void)requestWithUrlString:(NSString *)urlString requestType:(RequestType)requestType parDic:(NSDictionary *)parDic finish:(Finish)finish error:(Error)error;
{
    RequestManager *request = [[RequestManager alloc]init];
    [request requestWithUrlString:urlString requestType:requestType parDic:parDic finish:finish error:error];
    
    }



-(void)requestWithUrlString:(NSString *)urlString requestType:(RequestType)requestType parDic:(NSDictionary *)parDic finish:(Finish)finish error:(Error)error;
{
    //对block属性进行赋值
    self.finish = finish;
    self.error = error;
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.timeoutInterval = 10;
    //如果是POST请求
    if (requestType == RequestPOST) {
        [request setHTTPMethod:@"POST"];
        if (parDic.count > 0) {
            [request setHTTPBody:[self parDicToPOSTData:parDic]];
        }
    }
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            self.error(error);
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                self.finish(data);
                
            });
        }
}];
    
    //调用此方法 才是去异步链接
    [task resume];
}


-(NSData *)parDicToPOSTData:(NSDictionary *)parDic
{
    
    NSMutableArray *array = [NSMutableArray array];
    for (NSString *key in parDic) {
        NSString *string = [NSString stringWithFormat:@"%@=%@",key,parDic[key]];
        [array addObject:string];
    }
//    NSLog(@"array === %@",array);
    NSString *postString = [array componentsJoinedByString:@"&"];
    return [postString dataUsingEncoding:NSUTF8StringEncoding];
    
}





@end
