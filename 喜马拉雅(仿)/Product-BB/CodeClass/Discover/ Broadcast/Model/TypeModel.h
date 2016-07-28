//
//  TypeModel.h
//  Product-BB
//
//  Created by 林建 on 16/7/12.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TypeModel : NSObject
@property (nonatomic, strong)NSString *idd;
@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong) NSString *coverLarge;

@property(nonatomic,assign)BOOL isPlay;
@property(nonatomic,strong)NSString *savePath;
@property(nonatomic,assign)BOOL isSelect;

+(NSMutableArray *)ModelConfigureWithJsonDic:(NSDictionary *)jsonDic;
@end
