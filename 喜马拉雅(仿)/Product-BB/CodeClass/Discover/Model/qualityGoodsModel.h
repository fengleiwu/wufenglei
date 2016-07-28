//
//  qualityGoodsModel.h
//  Product-BB
//
//  Created by 吴峰磊 on 16/7/15.
//  Copyright © 2016年 吴峰磊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface qualityGoodsModel : NSObject
@property(nonatomic , strong)NSString *coverPathSmall;
@property(nonatomic , strong)NSString *footnote;
@property(nonatomic , strong)NSString *releasedAt;
@property(nonatomic , strong)NSString *specialId;
@property(nonatomic , strong)NSString *subtitle;
@property(nonatomic , strong)NSString *title;
@property(nonatomic , strong)NSString *contentType;


+(NSMutableArray *)qualityGood:(NSDictionary *)dic;


+(NSMutableSet *)set:(NSDictionary *)dic;


@end
