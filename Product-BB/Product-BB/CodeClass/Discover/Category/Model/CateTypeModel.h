//
//  CateTypeModel.h
//  Product-BB
//
//  Created by 林建 on 16/7/13.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CateTypeModel : NSObject
@property (nonatomic, strong)NSString *keywordName;
@property (nonatomic, strong)NSString *keywordId;
@property (nonatomic, strong)NSString *idd;
@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSString *key;
@property (nonatomic, assign)BOOL isCellSelected;


+ (NSMutableArray *)modelConfigureWithDic:(NSDictionary *)jsonDic;
@end
