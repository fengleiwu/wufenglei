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

+(NSMutableArray *)hotRecommends:(NSDictionary *)dic;


+(NSMutableArray *)title:(NSDictionary *)dic1;

@end
