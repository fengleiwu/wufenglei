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
        
        
        NSString *title = [set stringForColumn:@"title"];
        NSString *musicUrl = [set stringForColumn:@"musicUrl"];
        NSString *musicImg = [set stringForColumn:@"musicImg"];
        NSString *musicPath = [set stringForColumn:@"musicPath"];
        NSString *musicName = [set stringForColumn:@"musicName"];
        NSString *musicCount = [set stringForColumn:@"musicCount"];
        NSString *musicAlbumid = [set stringForColumn:@"musicAlbumid"];
        NSString *musicComments = [set stringForColumn:@"musicComments"];
        NSString *musicLikes = [set stringForColumn:@"musicLikes"];
        NSString *musicCoverMiddle = [set stringForColumn:@"musicCoverMiddle"];
        NSString *musicTitle = [set stringForColumn:@"musicTitle"];
        [array addObject:@[title,musicUrl,musicImg,musicPath,musicName,musicCount,musicAlbumid,musicComments,musicLikes,musicCoverMiddle,musicTitle]];
        
        
        
}
    return array;
}

//@property (nonatomic, strong) NSString *musicURL;
//@property (nonatomic, strong) NSString *totalTitle;大标题
//@property (nonatomic, strong) NSString *liveTitle;副标题
//@property (nonatomic, strong) NSString *playCount;播放次数
//@property (nonatomic, strong) NSString *bgImage;//图片


@end
