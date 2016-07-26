//
//  MyDownLoad.m
//  Product-BB
//
//  Created by lanou on 16/7/19.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "MyDownLoad.h"

@interface MyDownLoad()<NSURLSessionDownloadDelegate>
@property (nonatomic , strong)NSURLSessionDownloadTask *task;
@property (nonatomic , copy)DidDownload didDownload;
@property (nonatomic , copy)Downloading downloading;

@end
@implementation MyDownLoad


-(void)dealloc{
    _delegate = nil;
//    NSLog(@"%s",__FUNCTION__);
}

+(MyDownLoad *)shareMyDownLoad
{
    static MyDownLoad *down = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        down = [[MyDownLoad alloc]init];
    });
    return down;
}


-(instancetype)initWith:(NSString *)url
{
    self = [super init];
    if (self) {
        //设置下载配置
        NSURLSessionConfiguration *cfg = [NSURLSessionConfiguration defaultSessionConfiguration];
        //根据配置创建网络回话
        NSURLSession *session = [NSURLSession sessionWithConfiguration:cfg delegate:self delegateQueue:[NSOperationQueue mainQueue]];
        _task = [session downloadTaskWithURL:[NSURL URLWithString:url]];
        _url = url;
    }
    return self;
}


-(void)start
{
    [_task resume];
}

-(void)stop
{
    [_task suspend];
}

-(void)cancle
{
    [_task cancel];
}

//下载完成
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location
{
    //caches
    NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(13, 1, 1)lastObject];
    //拼接下载文件路径
    NSString *filePath = [cachesPath stringByAppendingPathComponent:downloadTask.response.suggestedFilename];
//    NSLog(@"文件路径------>%@",downloadTask.response.suggestedFilename);
    NSFileManager *fm = [NSFileManager defaultManager];
//    NSLog(@"原始保存路径------>%@",location.path);
    [fm moveItemAtPath:location.path toPath:filePath error:nil];
    if (_didDownload) {
        _didDownload(filePath,_url);
    }
    if (_delegate && [_delegate respondsToSelector:@selector(removeDownloadTask:)]) {
        [_delegate removeDownloadTask:_url];
    }
    [session invalidateAndCancel];//取消 关闭会话
    
}

//下载中
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
      didWriteData:(int64_t)bytesWritten
 totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    float progress = (float)totalBytesWritten/totalBytesExpectedToWrite;
    _progress = progress * 100;
    if (_downloading) {
        //速度,进度
        _downloading(bytesWritten , _progress , totalBytesExpectedToWrite);
    }
}

//监听下载
-(void)monitorDownload:(Downloading)downloading DidDownload:(DidDownload)didDownload
{
    //Download(参数)
    _didDownload = didDownload;
    _downloading = downloading;
    
}




@end
