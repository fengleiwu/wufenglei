//
//  DetailPayModel.h
//  Product-BB
//
//  Created by lanou on 16/7/14.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DetailPayModel : NSObject

@property(nonatomic , strong)NSString *intro;
@property(nonatomic , strong)NSString *introRich;
@property(nonatomic , strong)NSString *nickname;
@property(nonatomic , strong)NSString *personalSignature;
@property(nonatomic , strong)NSString *smallLogo;
@property(nonatomic , strong)NSString *uid;
@property(nonatomic , strong)NSString *album_score;
@property(nonatomic , strong)NSString *content;
@property(nonatomic , strong)NSString *smallHeader;
@property(nonatomic , strong)NSString *likes;
@property(nonatomic , strong)NSString *replyCount;
@property(nonatomic , strong)NSString *followers;


+(NSMutableArray *)list:(NSDictionary *)dic;
+(DetailPayModel *)detail:(NSDictionary *)dic;
+(DetailPayModel *)user:(NSDictionary *)dic;


@end
