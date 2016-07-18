//
//  AnchorModel.h
//  Product-BB
//
//  Created by lanou on 16/7/16.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AnchorModel : NSObject

@property(nonatomic , strong)NSString *title;
@property(nonatomic , strong)NSString *middleLogo;
@property(nonatomic , strong)NSString *nickname;
@property(nonatomic , strong)NSString *followersCounts;
@property(nonatomic , strong)NSString *tracksCounts;
@property(nonatomic , strong)NSString *uid;
@property(nonatomic , strong)NSString *verifyTitle;
@property(nonatomic , strong)NSString *isVerified;
@property(nonatomic , strong)NSString *displayStyle;
@property(nonatomic , strong)NSString *myId;

@property(nonatomic , strong)NSString *personDescribe;
@property(nonatomic , strong)NSString *name;
@property(nonatomic , strong)NSString *smallLogo;


+(NSMutableArray *)famous:(NSDictionary *)dic;


+(NSMutableArray *)normal:(NSDictionary *)dic;

+(NSMutableArray *)famousTitle:(NSDictionary *)dic;

+(NSMutableArray *)normalTitle:(NSDictionary *)dic;

+(NSMutableArray *)songer:(NSDictionary *)dic;

+(NSMutableArray *)famousMyID:(NSDictionary *)dic;

+(NSMutableArray *)moreSuperStar:(NSDictionary *)dic;

+(NSMutableArray *)moreNormal:(NSDictionary *)dic;

+(NSMutableArray *)normalName:(NSDictionary *)dic;
@end
