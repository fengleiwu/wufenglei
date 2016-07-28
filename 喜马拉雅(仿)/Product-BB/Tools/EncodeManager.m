//
//  EncodeManager.m
//  数据安全
//
//  Created by I三生有幸I on 16/6/1.
//  Copyright © 2016年 盛辰. All rights reserved.
//

#import "EncodeManager.h"

@implementation EncodeManager
+ (EncodeManager *)shareInstance
{
    static EncodeManager *manager = nil;
    if (manager == nil)
    {
        manager = [[EncodeManager alloc] init];
    }
    return manager;
}
/**********
 
 以下是归档反归档的操作方法
 
 **********/

#pragma mark --- 复杂对象（单一Model数据模型）的归档 ---
- (NSData *)archiverModel:(id)model modelKey:(NSString *)modelKey
{
    NSMutableData *data = [NSMutableData data];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
    [archiver encodeObject:model forKey:modelKey];
    [archiver finishEncoding];
    return data;
}

#pragma mark -- 复杂对象（单独Model）反归档 ---
// 传入归档model写入文件的路径 返回该model  要通过model对象 得到model归档时的key值
- (id)unArchiverModelWithFilePath:(NSString *)filePath modelKey:(NSString *)modelKey
{
    // 2.从路径中获取数据
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    // 3.创建反归档对象
    NSKeyedUnarchiver *unArchiver = [[NSKeyedUnarchiver alloc]initForReadingWithData:data];
    // 4.进行对model的反归档读取
    id model = [unArchiver decodeObjectForKey:modelKey];
    return model;
}

#pragma mark --- 复杂对象（数组装载model）归档
- (NSData *)archiverArray:(NSArray *)array arrayKey:(NSString *)arrayKey
{
    NSMutableData *data = [NSMutableData data];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
    [archiver encodeObject:array forKey:arrayKey];
    [archiver finishEncoding];
    return data;
}

#pragma mark --- 复杂对象 (数组装载model)反归档
- (NSArray *)unArchiverArrayWithFilePath:(NSString *)filePath arrayKey:(NSString *)arrayKey
{
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSKeyedUnarchiver *unArchiver = [[NSKeyedUnarchiver alloc]initForReadingWithData:data];
    NSArray *array = [unArchiver decodeObjectForKey:arrayKey];
    return array;
}

/**********
 
 以下是在沙盒中Documents/Caches路径下操作文件或文件夹管理的方法
 
 **********/

#pragma mark --- 创建/获取文件夹的方法 ---
// 传入文件夹的名称 返回整个路径 传入0 在documents文件下创建文件夹 传入1 在caches文件下创建文件夹
- (NSString *)creatOrGetFileWithFileName:(NSString *)fileName type:(FilePathType)type
{
    NSString *filePath;
    if (type == DocmuntsType)
    {
        filePath = [[self documentsFilePath] stringByAppendingPathComponent:fileName];
    }
    else
    {
        filePath = [[self cachesFilePath] stringByAppendingPathComponent:fileName];
    }
    NSFileManager *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:filePath])
    {
        [manager createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return filePath;
}

#pragma mark --- 创建/获取文档的方法 ---
// 传入文档的名称 返回整个路径  传入0 在documents文件下创建文档 传入1 在caches文件下创建文件
- (NSString *)creatOrGetDocWithWithDocName:(NSString *)docName type:(FilePathType)type
{
    NSString *filePath;
    if (type == DocmuntsType)
    {
        filePath = [[self documentsFilePath] stringByAppendingPathComponent:docName];
    }
    else
    {
        filePath = [[self cachesFilePath] stringByAppendingPathComponent:docName];
    }
    NSFileManager *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:filePath])
    {
        [manager createFileAtPath:filePath contents:nil attributes:nil];
    }
    return filePath;
}



#pragma mark --- 获取Documents路径 ---
- (NSString *)documentsFilePath
{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
}

#pragma mark --- 获取Library/Caches路径 ---
- (NSString *)cachesFilePath
{
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    
}

@end
