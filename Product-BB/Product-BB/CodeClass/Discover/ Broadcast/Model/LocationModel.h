//
//  LocationModel.h
//  Product-BB
//
//  Created by 林建 on 16/7/12.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocationModel : NSObject
@property (nonatomic, strong)NSString *coverLarge;
@property (nonatomic, strong)NSString *coverSmall;
@property (nonatomic, strong)NSString *programName;
@property (nonatomic, strong)NSString *playCount;
@property (nonatomic, strong)NSString *name;

+(NSMutableArray *)ModelConfigureWithJsonDic:(NSDictionary *)jsonDic;
@end
