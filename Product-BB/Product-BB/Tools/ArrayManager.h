//
//  ArrayManager.h
//  Product-BB
//
//  Created by lanou on 16/7/21.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArrayManager : NSObject


@property(nonatomic , strong)NSMutableArray *Array;
@property(nonatomic , strong)NSMutableArray *oneArray;
@property(nonatomic , assign)CGFloat progress;



+(ArrayManager *)shareManager;


@end
