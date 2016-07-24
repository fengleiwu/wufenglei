//
//  ArrayManager.m
//  Product-BB
//
//  Created by lanou on 16/7/21.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "ArrayManager.h"

@implementation ArrayManager


+(ArrayManager *)shareManager
{
    static ArrayManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ArrayManager alloc]init];
    });
    return manager;
}

-(instancetype)init
{
    self = [super init];
    if (self) {
        self.Array = [NSMutableArray array];
        self.oneArray = [NSMutableArray array];
    }
    return self;
}

@end
