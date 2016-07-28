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
@property (nonatomic, strong)NSString *albumCoverUrl290;
@property (nonatomic, strong)NSString *intro;
@property (nonatomic, strong)NSString *title;
@property (nonatomic, strong)NSString *playsCounts;
@property (nonatomic, strong)NSString *tracks;
@property (nonatomic, strong)NSString *recReason;

@property(nonatomic , strong)NSString *albumId;
@property(nonatomic , assign)BOOL isPaid;
@property(nonatomic , strong)NSString *nickname;
@property(nonatomic , strong)NSString *trackId;
@property(nonatomic , strong)NSString *trackTitle;
@property(nonatomic , strong)NSString *uid;
@property(nonatomic , strong)NSString *coverMiddle;
@property(nonatomic , strong)NSString *commentsCount;
@property(nonatomic , strong)NSString *score;
@property(nonatomic , strong)NSString *displayDiscountedPrice;



+ (NSMutableArray *)modelConfigureWithDic:(NSDictionary *)jsonDic;
@end
