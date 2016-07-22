//
//  MyMusicDownLoadTable.m
//  Product-BB
//
//  Created by lanou on 16/7/19.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "MyMusicDownLoadTable.h"

@implementation MyMusicDownLoadTable

- (instancetype)init
{
    self = [super init];
    if (self) {
        _dataBase = [DBManager shareManager].dataBase;
    }
    return self;
}

- (void)creatTable
{
    // 判断是否有表存在
    NSString *query = [NSString stringWithFormat:@"select count(*) from sqlite_master where type = 'table' and name = '%@'",kMyDownloadTable];
    FMResultSet *set = [_dataBase executeQuery:query];
    [set next];
    int count = [set intForColumnIndex:0];
    BOOL exist = count;
    if (exist) {
        NSLog(@"%@表存在",kMyDownloadTable);
    }else{
        // 建表
        // create table 表名(给一个ID  INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL，参数)
        NSString *updata = [NSString stringWithFormat:@"create table %@(musicID  INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL,title text,musicUrl text,musicImg text,musicPath text,musicName text,musicCount text,musicAlbumid text,musicComments text,musicLikes text,musicCoverMiddle text,musicTitle text)",kMyDownloadTable];
        BOOL result = [_dataBase executeUpdate:updata];
        if (result) {
            NSLog(@"%@创建成功",kMyDownloadTable);
        }else
        {
            NSLog(@"%@创建失败",kMyDownloadTable);
        }
    }
    
}
- (void)insertIntoTable:(NSArray *)Info
{
    NSString *updata = [NSString stringWithFormat:@"INSERT INTO %@ (title,musicUrl,musicImg,musicPath,musicName,musicCount,musicAlbumid,musicComments,musicLikes,musicCoverMiddle,musicTitle) values(?,?,?,?,?,?,?,?,?,?,?)",kMyDownloadTable];
    BOOL result = [_dataBase executeUpdate:updata withArgumentsInArray:Info];
    if (result) {
        NSLog(@"插入数据成功");
    }else{
        NSLog(@"插入数据失败");
    }
}
- (NSArray *)selectAll
{
    NSString *query = [NSString stringWithFormat:@"select *from %@",kMyDownloadTable];
    FMResultSet *set = [_dataBase executeQuery:query];
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:[set columnCount]];
    //NSMutableArray *arr = [NSMutableArray arrayWithCapacity:[set columnCount]];
    while ([set next]) {
        
        NSData *musicImg = [set dataForColumn:@"musicImg"];
        NSData *musicCoverMiddle = [set dataForColumn:@"musicCoverMiddle"];

        
        NSString *title = [set stringForColumn:@"title"];
        NSString *musicUrl = [set stringForColumn:@"musicUrl"];
        //NSString *musicImg = [set stringForColumn:@"musicImg"];
        NSString *musicPath = [set stringForColumn:@"musicPath"];
        NSString *musicName = [set stringForColumn:@"musicName"];
        NSString *musicCount = [set stringForColumn:@"musicCount"];
        NSString *musicAlbumid = [set stringForColumn:@"musicAlbumid"];
        NSString *musicComments = [set stringForColumn:@"musicComments"];
        NSString *musicLikes = [set stringForColumn:@"musicLikes"];
        //NSString *musicCoverMiddle = [set stringForColumn:@"musicCoverMiddle"];
        NSString *musicTitle = [set stringForColumn:@"musicTitle"];
        [array addObject:@[title,musicUrl,musicImg,musicPath,musicName,musicCount,musicAlbumid,musicComments,musicLikes,musicCoverMiddle,musicTitle]];
        }
    return array;
}

//删除数据
-(void)delegateNoteWithTableName:(NSString *)tableName myId:(NSString *)myID
{
//    [_dataBase open];
    NSString *string = [NSString stringWithFormat:@"delete from %@ where musicAlbumid = ?",tableName];
    NSString *myIDString = [NSString stringWithFormat:@"%@",myID];
    BOOL flag = [_dataBase executeUpdate:string,myIDString];
       NSLog(@"删除数据flag==%d",flag);
//    [_dataBase close];
    
}

-(void)delegateNoteWithTableName:(NSString *)tableName musicUrl:(NSString *)musicUrl
{
    NSString *string = [NSString stringWithFormat:@"delete from %@ where musicUrl = ?",tableName];
    NSString *myIDString = [NSString stringWithFormat:@"%@",musicUrl];
    BOOL flag = [_dataBase executeUpdate:string,myIDString];
    NSLog(@"删除数据flag==%d",flag);

}

#pragma mark --- 播放历史数据
- (void)creatHistoryOfPlayTable
{
    // 判断是否有表存在
    NSString *query = [NSString stringWithFormat:@"select count(*) from sqlite_master where type = 'table' and name = '%@'",kYourDownloadTable];
    FMResultSet *set = [_dataBase executeQuery:query];
    [set next];
    int count = [set intForColumnIndex:0];
    BOOL exist = count;
    if (exist) {
        NSLog(@"%@表存在",kYourDownloadTable);
    }else{
        // 建表
        // create table 表名(给一个ID  INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL，参数)
        NSString *updata = [NSString stringWithFormat:@"create table %@(musicID  INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL,musicURL text,totalTitle text,liveTitle text,playCount text,bgImage text)",kYourDownloadTable];
        BOOL result = [_dataBase executeUpdate:updata];
        if (result) {
            NSLog(@"%@创建成功",kYourDownloadTable);
        }else
        {
            NSLog(@"%@创建失败",kYourDownloadTable);
        }
    }
}

- (void)insertIntoHistoryOfPlayTable:(NSArray *)Info
{

    NSString *updata = [NSString stringWithFormat:@"INSERT INTO %@ (musicURL,totalTitle,liveTitle,playCount,bgImage) values(?,?,?,?,?)",kYourDownloadTable];
    BOOL result = [_dataBase executeUpdate:updata withArgumentsInArray:Info];
    if (result) {
        NSLog(@"插入数据成功");
    }else{
        NSLog(@"插入数据失败");
    }
}

- (NSArray *)selectAllInHistoryOfPlay
{
    NSString *query = [NSString stringWithFormat:@"select *from %@",kYourDownloadTable];
    FMResultSet *set = [_dataBase executeQuery:query];
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:[set columnCount]];
    //NSMutableArray *arr = [NSMutableArray arrayWithCapacity:[set columnCount]];
    while ([set next]) {
        NSString *musicURL = [set stringForColumn:@"musicURL"];
        NSString *totalTitle = [set stringForColumn:@"totalTitle"];
        NSString *liveTitle = [set stringForColumn:@"liveTitle"];
        NSString *playCount = [set stringForColumn:@"playCount"];
        NSString *bgImage = [set stringForColumn:@"bgImage"];
        
        [array addObject:@[musicURL,totalTitle,liveTitle,playCount,bgImage]];
    }
    return array;
}

//删除数据
-(void)delegateNoteWithHistoryOfPlayTableName:(NSString *)tableName musicURL:(NSString *)musicURL
{
    NSString *string = [NSString stringWithFormat:@"delete from %@ where musicURL = ?",tableName];
    NSString *myIDString = [NSString stringWithFormat:@"%@",musicURL];
    BOOL flag = [_dataBase executeUpdate:string,myIDString];
    NSLog(@"删除数据flag==%d",flag);
    
}


@end
