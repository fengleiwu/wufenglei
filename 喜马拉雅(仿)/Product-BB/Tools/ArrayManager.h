//
//  ArrayManager.h
//  Product-BB
//
//  Created by 吴峰磊 on 16/7/21.
//  Copyright © 2016年 吴峰磊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArrayManager : NSObject


@property(nonatomic , strong)NSMutableArray *Array;
@property(nonatomic , strong)NSMutableArray *oneArray;
@property(nonatomic , assign)CGFloat progress;



+(ArrayManager *)shareManager;


@end
