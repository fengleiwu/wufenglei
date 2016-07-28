//
//  RankListModel.h
//  Product-BB
//
//  Created by 林建 on 16/7/14.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RankListModel : NSObject
@property (nonatomic, strong)NSString *title;
@property (nonatomic, strong)NSString *coverPath;
@property (nonatomic, strong)NSString *title1;
@property (nonatomic, strong)NSString *title2;
@property (nonatomic, strong)NSString *contentType;

+(NSMutableArray *)ModelConfigureWithJsonDic:(NSDictionary *)jsonDic;
@end
