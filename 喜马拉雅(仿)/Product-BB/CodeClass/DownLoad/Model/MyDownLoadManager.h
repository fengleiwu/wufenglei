//
//  MyDownLoadManager.h
//  Product-BB
//
//  Created by 吴峰磊 on 16/7/19.
//  Copyright © 2016年 吴峰磊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyDownLoad.h"
@interface MyDownLoadManager : NSObject

@property (nonatomic , strong)NSMutableDictionary *dic;//存放下载任务

+(MyDownLoadManager *)defaultManager;

//创建一个下载任务
-(MyDownLoad *)creatDownload:(NSString *)url;

-(void)removeDownloadTask:(NSString *)url;

@end
