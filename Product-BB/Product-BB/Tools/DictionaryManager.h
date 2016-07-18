//
//  DictionaryManager.h
//  Product-BB
//
//  Created by 林建 on 16/7/18.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DictionaryManager : NSObject

@property (nonatomic, strong)NSMutableDictionary *shareDic;

+(DictionaryManager *)shareInstance;

@end
