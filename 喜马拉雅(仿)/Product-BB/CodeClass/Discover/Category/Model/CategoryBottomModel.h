//
//  CategoryBottomModel.h
//  Product-B
//
//  Created by 吴峰磊 on 16/7/12.
//  Copyright © 2016年 吴峰磊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CategoryBottomModel : NSObject

@property (nonatomic, strong) NSString *coverPath;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong)  NSString *myid;

+ (NSMutableArray *)modelConfigureWithDic:(NSDictionary *)jsonDic;

@end
