//
//  recommendMoreModel.h
//  Product-BB
//
//  Created by 吴峰磊 on 16/7/13.
//  Copyright © 2016年 吴峰磊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface recommendMoreModel : NSObject


@property(nonatomic , strong)NSString *title;
@property(nonatomic , strong)NSString *coverMiddle;
@property(nonatomic , strong)NSString *intro;
@property(nonatomic , strong)NSString *tracks;
@property(nonatomic , strong)NSString *playsCounts;
@property(nonatomic , strong)NSString *albumId;

+(NSMutableArray *)recommendMore:(NSDictionary *)dic;

@end
