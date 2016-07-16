//
//  TableListModel.h
//  Product-BB
//
//  Created by 林建 on 16/7/13.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TableListModel : NSObject
@property (nonatomic, strong)NSString *coverLarge;
@property (nonatomic, strong)NSString *intro;
@property (nonatomic, strong)NSString *title;
@property (nonatomic, strong)NSString *playsCounts;
@property (nonatomic, strong)NSString *tracks;

+ (NSMutableArray *)modelConfigureWithDic:(NSDictionary *)jsonDic;
@end
