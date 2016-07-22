//
//  MyDownLoad.h
//  Product-BB
//
//  Created by lanou on 16/7/19.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void(^Downloading) (long long bytesWritten , NSInteger progress ,long long allTimes);//下载中,返回瞬时速度和进度
typedef void(^DidDownload) (NSString *savePath , NSString *url);//下载完成,返回保存路径和下载地址
@protocol  MyDownLoadDelegate <NSObject>

-(void)removeDownloadTask:(NSString *)url;

@end
@interface MyDownLoad : NSObject


@property(nonatomic , strong)NSString *url;//下载地址
@property(nonatomic , assign)NSInteger progress;//下载进度
@property(nonatomic , assign)id<MyDownLoadDelegate>delegate;

+(MyDownLoad *)shareMyDownLoad;

//给个下载地址 初始化
-(instancetype)initWith:(NSString *)url;
//开始下载
-(void)start;
//监听下载的方法
-(void)monitorDownload:(Downloading)downloading DidDownload:(DidDownload)didDownload;

-(void)stop;

-(void)cancle;





@end
