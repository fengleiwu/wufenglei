//
//  DingYueModel.m
//  Product-BB
//
//  Created by 林建 on 16/7/23.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "DingYueModel.h"

@implementation DingYueModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{

}

+(NSMutableArray *)modelConfigureWithArray:(NSArray *)array{
    NSMutableArray *Arr = [NSMutableArray array];
    for (NSArray *  arr in array) {
        DingYueModel *model = [[DingYueModel alloc]init];
        model.albumid = arr[0];
        model.inter = arr[1];
        model.isPaid = arr[2];
        model.row = arr[3];
        model.uid = arr[4];
        model.nickName = arr[5];
        model.score = arr[6];
        model.displayPrice = arr[7];
        model.image = arr[8];
        model.bigTitle = arr[9];
        model.smallTitle = arr[10];
        [Arr addObject:model];
    }
    return Arr;
}
@end
