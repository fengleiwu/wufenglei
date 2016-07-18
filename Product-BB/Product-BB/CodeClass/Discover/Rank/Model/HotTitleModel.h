//
//  HotTitleModel.h
//  Product-BB
//
//  Created by 林建 on 16/7/14.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HotTitleModel : NSObject
@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSString *idd;
@property (nonatomic, strong)NSString *keyy;





+ (NSMutableArray *)modelConfigureWithDic:(NSDictionary *)jsonDic;




@end
