//
//  hotRecommendsModel.h
//  Product-BB
//
//  Created by lanou on 16/7/12.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface hotRecommendsModel : NSObject

@property(nonatomic , strong)NSString *coverMiddle;
@property(nonatomic , strong)NSString *intro;
@property(nonatomic , strong)NSString *title;
@property(nonatomic , strong)NSString *albumId;
@property(nonatomic , strong)NSString *displayDiscountedPrice;
@property(nonatomic , strong)NSString *nickname;
@property(nonatomic , strong)NSString *playsCounts;
@property(nonatomic , strong)NSString *score;
@property(nonatomic , strong)NSString *tracks;
@property (nonatomic, strong)NSString *categoryId;
@property(nonatomic , strong)NSString *displayPrice;



+(NSMutableArray *)hotRecommends:(NSDictionary *)dic;


+(NSMutableArray *)title:(NSDictionary *)dic1;

@end
