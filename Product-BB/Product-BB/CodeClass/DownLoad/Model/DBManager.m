//
//  DBManager.m
//  Product-BB
//
//  Created by lanou on 16/7/19.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "DBManager.h"

static DBManager *manager;
@interface DBManager(){
    NSString *_path;//路径之数据
}

@end
static DBManager *manager = nil;
@implementation DBManager

+ (DBManager *)shareManager
{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[DBManager alloc] init];
    });
    return manager;
}
// 初始化方法
- (instancetype)init
{
    self = [super init];
    if (self) {
        // 初始化数据库
        [self initDataBaseWithName:kMySqliteName];
    }
    return self;
}
// 初始化数据库
- (void)initDataBaseWithName:(NSString *)name
{
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(9, 1, 1)lastObject];
    NSString *filePath = [documentPath stringByAppendingString:[NSString stringWithFormat:@"/%@",name]];
    _path = filePath;
//    NSLog(@"================%@",filePath);
    NSFileManager *fm = [NSFileManager defaultManager];
    BOOL exist = [fm fileExistsAtPath:filePath];
    [self connect];
    if (exist) {
//        NSLog(@"数据库%@存在",name);
    }else{
//        NSLog(@"数据库%@不存在",name);
    }
}
- (void)connect
{
    if (!_dataBase) {
        _dataBase = [FMDatabase databaseWithPath:_path];
    }
    if (![_dataBase open]) {
//        NSLog(@"数据库打开失败");
    }else{
//        NSLog(@"数据库打开成功");
    }
    
    
}
// 关闭数据库
- (void)close
{
    [_dataBase close];
    manager = nil;
}
- (void)dealloc
{
    [self close];
}



@end
