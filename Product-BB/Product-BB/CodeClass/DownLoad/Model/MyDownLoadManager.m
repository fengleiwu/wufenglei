//
//  MyDownLoadManager.m
//  Product-BB
//
//  Created by lanou on 16/7/19.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "MyDownLoadManager.h"


static MyDownLoadManager *manager = nil;

@interface MyDownLoadManager()<MyDownLoadDelegate>
//@property (nonatomic , strong)NSMutableDictionary *dic;//存放下载任务

@end


@implementation MyDownLoadManager


+(MyDownLoadManager *)defaultManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager  = [[MyDownLoadManager alloc]init];
    });
    return manager;
}

-(NSMutableDictionary *)dic
{
    if (!_dic) {
        _dic = [[NSMutableDictionary alloc]init];
    }
    return _dic;
}

-(MyDownLoad *)creatDownload:(NSString *)url
{
    MyDownLoad *task = self.dic[url];
    if (!task) {
        task = [[MyDownLoad shareMyDownLoad]initWith:url];
        
        [self.dic setValue:task forKey:url];
    }
    task.delegate = self;
    return task;
}

-(void)removeDownloadTask:(NSString *)url
{
    [self.dic removeObjectForKey:url];
}









@end
