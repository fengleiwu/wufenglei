//
//  RankModel.h
//  Product-BB
//
//  Created by 林建 on 16/7/12.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RankModel : NSObject

@property (nonatomic, strong)NSString *coverLarge;
@property (nonatomic, strong)NSString *coverSmall;
@property (nonatomic, strong)NSString *playCount;
@property (nonatomic, strong)NSString *programName;
@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSString *programId;
@property (nonatomic, strong)NSString *idd;
@property (nonatomic, strong)NSString *playUrl1;


//@property(nonatomic,assign)BOOL isPlay;
//@property(nonatomic,strong)NSString *savePath;
//@property(nonatomic,assign)BOOL isSelect;

+(NSMutableArray *)ModelConfigureWithJsonDic:(NSDictionary *)jsonDic;
@end
