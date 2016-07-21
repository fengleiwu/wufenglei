//
//  EncodeManager.h
//  数据安全
//
//  Created by I三生有幸I on 16/6/1.
//  Copyright © 2016年 盛辰. All rights reserved.
//

#import <Foundation/Foundation.h>
// 创建文件或者文档所在的路径
typedef NS_ENUM(NSInteger, FilePathType) {
    DocmuntsType,
    CachesType
};

@interface EncodeManager : NSObject
/*
 一、沙盒文件管理操作功能
 1.Model归档 传入Model 以及 key值
 2.反归档Model 传入文档名称 以及 key值
 3.数组归档 传入数组 以及key值
 4.反归档数组 传入文档名称 以及key值
 
 二、创建/获取 文件夹 和 文档的功能
 1.传入文件夹名称在Documents/Caches创建或者获取文件夹整体路径的的功能
 2传入文档名称在Documents/Caches创建或者获取文档整体路径的功能
 */
+ (EncodeManager *)shareInstance;

/**********
 
 以下是归档反归档的操作方法
 
 **********/
#pragma mark --- 复杂对象（单独Model）归档 ---
// 传入model 进行归档 返回model的NSData
- (NSData *)archiverModel:(id)model modelKey:(NSString *)modelKey;

#pragma mark -- 复杂对象（单独Model）反归档 ---
// 传入归档model写入文件的路径 返回该model 后面传入model对象 要通过model对象 得到model归档时的key值
- (id)unArchiverModelWithFilePath:(NSString *)filePath modelKey:(NSString *)modelKey;


#pragma mark --- 复杂对象（数组装载model）归档
- (NSData *)archiverArray:(NSArray *)array arrayKey:(NSString *)arrayKey;

#pragma mark --- 复杂对象 (数组装载model)反归档
- (NSArray *)unArchiverArrayWithFilePath:(NSString *)filePath arrayKey:(NSString *)arrayKey;





/**********
 
 以下是在沙盒中Documents/Caches路径下操作文件或文件夹管理的方法
 
 **********/

#pragma mark --- 创建/获取文件夹的方法 ---
// 传入文件夹的名称 返回整个路径 传入0 在documents文件下创建文件夹 传入1 在caches文件下创建文件夹
- (NSString *)creatOrGetFileWithFileName:(NSString *)fileName type:(FilePathType)type;

#pragma mark --- 创建/获取文档的方法 ---
// 传入文档的名称 返回整个路径  传入0 在documents文件下创建文档 传入1 在caches文件下创建文件
- (NSString *)creatOrGetDocWithWithDocName:(NSString *)docName type:(FilePathType)type;


#pragma mark --- 获取Documents路径 ---
- (NSString *)documentsFilePath;

#pragma mark --- 获取Library/Caches路径 ---
- (NSString *)cachesFilePath;

@end
