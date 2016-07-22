//
//  MyMusicDownLoadTable.h
//  Product-BB
//
//  Created by lanou on 16/7/19.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DBManager.h"
@interface MyMusicDownLoadTable : NSObject



@property(nonatomic , strong)FMDatabase *dataBase;

//建表
-(void)creatTable;
//插入
-(void)insertIntoTable:(NSArray *)Info;
//取出
-(NSArray *)selectAll;

//删除数据
-(void)delegateNoteWithTableName:(NSString *)tableName myId:(NSString *)myID;

-(void)delegateNoteWithTableName:(NSString *)tableName musicUrl:(NSString *)musicUrl;


#pragma mark --- 播放历史数据 HistoryOfPlay

//建表
-(void)creatHistoryOfPlayTable;
//插入
-(void)insertIntoHistoryOfPlayTable:(NSArray *)Info;
//取出
-(NSArray *)selectAllInHistoryOfPlay;

//删除数据
-(void)delegateNoteWithHistoryOfPlayTableName:(NSString *)tableName musicURL:(NSString *)musicURL;



@end
