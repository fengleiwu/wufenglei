//
//  WEBModel.h
//  Product-BB
//
//  Created by lanou on 16/7/12.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WEBModel : NSObject


@property(nonatomic , strong)NSString *cover;
@property(nonatomic , strong)NSString *link;


+(NSMutableArray *)webWith:(NSDictionary *)dic;


@end
