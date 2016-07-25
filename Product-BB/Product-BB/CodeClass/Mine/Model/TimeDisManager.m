//
//  TimeDisManager.m
//  Product-BB
//
//  Created by 林建 on 16/7/25.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "TimeDisManager.h"

@implementation TimeDisManager

+(TimeDisManager *)defaultManager{
    static TimeDisManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[TimeDisManager alloc]init];
    });
    return manager;
}

-(instancetype)init{
    self = [super init];
    if (self) {
        self.timeDic = [NSMutableDictionary dictionary];
        for (int i = 0; i < 6; i++) {
            if (i == 0) {
                [self.timeDic setValue:@"YES" forKey:[NSString stringWithFormat:@"%d",200 + i]];
            } else {
                [self.timeDic setValue:@"NO" forKey:[NSString stringWithFormat:@"%d",200 + i]];
            }
        }
    }
    return self;
}

@end
