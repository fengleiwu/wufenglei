//
//  DBManager.h
//  Product-BB
//
//  Created by lanou on 16/7/19.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBManager : NSObject

@property(nonatomic , strong)FMDatabase *dataBase;
+(DBManager *)shareManager;

//关闭数据库
-(void)close;



@end
