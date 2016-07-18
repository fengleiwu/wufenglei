//
//  attentionFanZanModel.h
//  Product-BB
//
//  Created by lanou on 16/7/17.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface attentionFanZanModel : NSObject

@property(nonatomic , strong)NSString *followers;
@property(nonatomic , strong)NSString *nickname;
@property(nonatomic , strong)NSString *smallLogo;
@property(nonatomic , strong)NSString *tracks;
@property(nonatomic , strong)NSString *uid;
@property(nonatomic , assign)BOOL isVerified;
@property(nonatomic , strong)NSString *ptitle;//粉丝  关注

@property(nonatomic , strong)NSString *albumId;
@property(nonatomic , strong)NSString *coverMiddle;
@property(nonatomic , strong)NSString *createdAt;
@property(nonatomic , strong)NSString *categoryId;
@property(nonatomic , strong)NSString *comments;
@property(nonatomic , strong)NSString *duration;
@property(nonatomic , strong)NSString *playtimes;
@property(nonatomic , strong)NSString *playUrl64;
@property(nonatomic , strong)NSString *shares;
@property(nonatomic , strong)NSString *title;
@property(nonatomic , strong)NSString *trackId;
@property(nonatomic , strong)NSString *userSource;
@property(nonatomic , strong)NSString *isPaid;



+(NSMutableArray *)guanzhu:(NSDictionary *)dic;

//+(NSMutableArray *)fensi:(NSDictionary *)dic;
//
//+(NSMutableArray *)zanguo:(NSDictionary *)dic;


@end
