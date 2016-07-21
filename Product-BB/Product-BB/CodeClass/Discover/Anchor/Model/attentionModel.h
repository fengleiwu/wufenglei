//
//  attentionModel.h
//  Product-BB
//
//  Created by lanou on 16/7/17.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface attentionModel : NSObject


@property(nonatomic , strong)NSString *backgroundLogo;
@property(nonatomic , strong)NSString *albums;
@property(nonatomic , strong)NSString *followers;//粉丝
@property(nonatomic , strong)NSString *followings;//关注
@property(nonatomic , strong)NSString *location;
@property(nonatomic , strong)NSString *mobileMiddleLogo;
@property(nonatomic , strong)NSString *nickname;
@property(nonatomic , strong)NSString *personalSignature;
@property(nonatomic , strong)NSString *personDescribe;
@property(nonatomic , strong)NSString *tracks;
@property(nonatomic , strong)NSString *uid;
@property(nonatomic , strong)NSString *favorites;//赞过的


@property(nonatomic , strong)NSString *albumId;
@property(nonatomic , strong)NSString *coverLarge;//
@property(nonatomic , strong)NSString *playTimes;
@property(nonatomic , strong)NSString *shares;
@property(nonatomic , strong)NSString *status;
@property(nonatomic , strong)NSString *title;
@property(nonatomic , strong)NSString *updatedAt;

@property(nonatomic , strong)NSString *discountedPrice;
@property(nonatomic , assign)BOOL isPaid;
@property(nonatomic , strong)NSString *displayDiscountedPrice;
@property(nonatomic , strong)NSString *price;
@property(nonatomic , strong)NSString *priceTypeId;
@property(nonatomic , strong)NSString *score;
@property(nonatomic , strong)NSString *totalTrackCount;



@property(nonatomic , strong)NSString *createdAt;
@property(nonatomic , strong)NSString *duration;
@property(nonatomic , strong)NSString *likes;
@property(nonatomic , strong)NSString *opType;
@property(nonatomic , strong)NSString *playPathAacv224;
@property(nonatomic , strong)NSString *playtimes;
@property(nonatomic , strong)NSString *playUrl64;
@property(nonatomic , strong)NSString *processState;
@property(nonatomic , strong)NSString *trackId;
@property(nonatomic , strong)NSString *userSource;
@property(nonatomic , strong)NSString *comments;
@property(nonatomic , strong)NSString *displayPrice;



+(attentionModel *)top:(NSDictionary *)dic;

+(NSMutableArray *)middle:(NSDictionary *)dic;

+(NSMutableArray *)bottom:(NSDictionary *)dic;

+(NSMutableArray *)price:(NSDictionary *)dic;



@end
