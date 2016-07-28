//
//  WEBModel.h
//  Product-BB
//
//  Created by 吴峰磊 on 16/7/12.
//  Copyright © 2016年 吴峰磊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WEBModel : NSObject


@property(nonatomic , strong)NSString *cover;
@property(nonatomic , strong)NSString *link;


+(NSMutableArray *)webWith:(NSDictionary *)dic;


@end
