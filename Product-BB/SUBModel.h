//
//  SUBModel.h
//  Product-BB
//
//  Created by 林建 on 16/7/18.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SUBModel : NSObject
@property (nonatomic, strong)NSString *coverLarge;
@property (nonatomic, strong)NSString *albumCoverUrl290;
@property (nonatomic, strong)NSString *intro;
@property (nonatomic, strong)NSString *title;
@property (nonatomic, strong)NSString *playsCounts;
@property (nonatomic, strong)NSString *tracks;
@property (nonatomic, strong)NSString *recReason;

+ (NSMutableArray *)modelConfigureWithDic:(NSDictionary *)jsonDic;
@end
