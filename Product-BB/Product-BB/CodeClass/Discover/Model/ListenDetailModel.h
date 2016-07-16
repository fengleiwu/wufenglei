//
//  ListenDetailModel.h
//  Product-BB
//
//  Created by lanou on 16/7/15.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ListenDetailModel : NSObject

@property(nonatomic , strong)NSString *title;
@property(nonatomic , strong)NSString *intro;
@property(nonatomic , strong)NSString *smallLogo;
@property(nonatomic , strong)NSString *nickname;
@property(nonatomic , strong)NSString *personalSignature;//听单详情上面和下面的


@property(nonatomic , strong)NSString *albumCoverUrl290;
@property(nonatomic , strong)NSString *myid;
@property(nonatomic , strong)NSString *playsCounts;
@property(nonatomic , strong)NSString *tracksCounts;
@property(nonatomic , strong)NSString *contentType;

@property(nonatomic , strong)NSString *specialId;


@property(nonatomic , strong)NSString *favoritesCounts;
@property(nonatomic , strong)NSString *coverSmall;
@property(nonatomic , strong)NSString *playPath64;
@property(nonatomic , strong)NSString *commentsCounts;


+(ListenDetailModel *)model:(NSDictionary *)dic;

+(NSMutableArray *)arr:(NSDictionary *)dic;

@end
