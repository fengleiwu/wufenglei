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

@property (nonatomic, strong)NSString *albumId;
@property (nonatomic, assign)NSInteger inter;
@property(nonatomic , assign)BOOL isPaid;
@property(nonatomic , assign)NSInteger row;//第几个
@property(nonatomic , strong)NSString *uid;//uid
@property(nonatomic , strong)NSString *nickname;

@property(nonatomic , strong)NSString *score;
@property(nonatomic , strong)NSString *displayPrice;

+ (NSMutableArray *)modelConfigureWithDic:(NSDictionary *)jsonDic;
@end
