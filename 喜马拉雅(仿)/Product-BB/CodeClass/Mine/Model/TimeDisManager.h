//
//  TimeDisManager.h
//  Product-BB
//
//  Created by 林建 on 16/7/25.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeDisManager : NSObject
@property (nonatomic, strong)NSMutableDictionary *timeDic;

+(TimeDisManager *)defaultManager;

@end
