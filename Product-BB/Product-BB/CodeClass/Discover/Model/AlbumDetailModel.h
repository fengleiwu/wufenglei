//
//  AlbumDetailModel.h
//  Product-BB
//
//  Created by lanou on 16/7/13.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlbumDetailModel : NSObject

@property(nonatomic , strong)NSString *comments;//评论个数
@property(nonatomic , strong)NSString *playPathAacv224;
@property(nonatomic , strong)NSString *smallLogo;//主播头像
@property(nonatomic , strong)NSString *duration;
@property(nonatomic , strong)NSString *likes;
@property(nonatomic , strong)NSString *playTrackId;
@property(nonatomic , strong)NSString *tags;
@property(nonatomic , strong)NSString *tracks;
@property(nonatomic , strong)NSString *updatedAt;
@property(nonatomic , strong)NSString *categoryId;
@property(nonatomic , strong)NSString *categoryName;
@property(nonatomic , strong)NSString *createdAt;
@property(nonatomic , strong)NSString *intro;
@property(nonatomic , strong)NSString *introRich;
@property(nonatomic , strong)NSString *uid;

@property(nonatomic , strong)NSString *playTimes;
@property(nonatomic , strong)NSString *playtimes;//播放次数
@property(nonatomic , strong)NSString *playUrl64;//播放URL
@property(nonatomic , strong)NSString *coverMiddle;//播放image
@property(nonatomic , strong)NSString *title;
@property(nonatomic , strong)NSString *nickname;


@property(nonatomic , assign)BOOL isPlay;



+(AlbumDetailModel *)album:(NSDictionary *)dic;
+(NSMutableArray *)tracks:(NSDictionary *)dic;
+(AlbumDetailModel *)user:(NSDictionary *)dic;
+(NSMutableArray *)payArray:(NSDictionary *)dic;

@end
