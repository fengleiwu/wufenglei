//
//  ArrayManager.h
//  Product-BB
//
//  Created by lanou on 16/7/21.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArrayManager : NSObject


@property(nonatomic , strong)NSMutableArray *Array;

@property(nonatomic , copy)void(^arr)(NSArray *arr,NSMutableArray *arr2);


+(ArrayManager *)shareManager;


@end
