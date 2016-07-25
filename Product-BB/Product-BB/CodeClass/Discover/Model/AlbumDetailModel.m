//
//  AlbumDetailModel.m
//  Product-BB
//
//  Created by lanou on 16/7/13.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "AlbumDetailModel.h"

@implementation AlbumDetailModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}


//[self.imageV sd_setImageWithURL:[NSURL URLWithString:model.smallLogo]];
//self.titleL.text = model.title;
//self.fuTitleL.text = model.nickname;
//CGFloat f = [model.playtimes floatValue];
//if (f > 10000) {
//    self.label1.text = [NSString stringWithFormat:@"%.1f万",f / 10000];
//}if (f/10000 > 10000) {
//    self.label1.text = [NSString stringWithFormat:@"%.1f亿",f / 10000 / 10000];
//}if (f <= 10000) {
//    self.label1.text = [NSString stringWithFormat:@"%@",model.playtimes];
//}
//
//CGFloat g = [model.likes floatValue];
//if (g > 10000) {
//    self.label2.text = [NSString stringWithFormat:@"%.1f万",g / 10000];
//}if (g <= 10000) {
//    self.label2.text = [NSString stringWithFormat:@"%@",model.likes];
//}
//
//CGFloat h = [model.comments floatValue];
//if (h > 10000) {
//    self.label3.text = [NSString stringWithFormat:@"%.1f万",h / 10000];
//}if (h <= 10000) {
//    self.label3.text = [NSString stringWithFormat:@"%@",model.comments];
//}
//if (model.playUrl64 == nil) {
//    [table insertIntoTable:@[model.title,model.playPath64,musicData,savePath,model.nickname,model.playsCounts,@"111",model.commentsCounts,model.favoritesCounts,albumData,self.self.titleArr[1]]];
//}else{
//    [table insertIntoTable:@[model.title,model.playUrl64,musicData,savePath,model.nickname,model.playtimes,model.albumId,model.comments,model.likes,albumData,self.titleArr[1]]];
//
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.smallLogo forKey:@"smallLogo"];
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.nickname forKey:@"nickname"];
    [aCoder encodeObject:self.playtimes forKey:@"playtimes"];
    [aCoder encodeObject:self.likes forKey:@"likes"];
    [aCoder encodeObject:self.comments forKey:@"comments"];
    [aCoder encodeObject:self.playPath64 forKey:@"playPath64"];
    [aCoder encodeObject:self.playUrl64 forKey:@"playUrl64"];
    [aCoder encodeObject:self.albumId forKey:@"albumId"];
    
}


-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.title = [aDecoder decodeObjectForKey:@"title"];
        self.smallLogo = [aDecoder decodeObjectForKey:@"smallLogo"];
        self.nickname = [aDecoder decodeObjectForKey:@"nickname"];
        self.playtimes = [aDecoder decodeObjectForKey:@"playtimes"];
        self.likes = [aDecoder decodeObjectForKey:@"likes"];
        self.comments = [aDecoder decodeObjectForKey:@"comments"];
        self.playPath64 = [aDecoder decodeObjectForKey:@"playPath64"];
        self.playUrl64 = [aDecoder decodeObjectForKey:@"playUrl64"];
        self.albumId = [aDecoder decodeObjectForKey:@"albumId"];
    }
    return self;
}


+(AlbumDetailModel *)album:(NSDictionary *)dic
{
    NSDictionary *data = dic[@"data"];
    NSDictionary *album = data[@"album"];
    AlbumDetailModel *model = [[AlbumDetailModel alloc]init];
    [model setValuesForKeysWithDictionary:album];
    return model;
}


+(NSMutableArray *)tracks:(NSDictionary *)dic
{
    NSMutableArray *arr = [NSMutableArray array];
    NSDictionary *data = dic[@"data"];
    NSDictionary *tracks = data[@"tracks"];
    NSArray *list = tracks[@"list"];
    for (NSDictionary *dic1 in list) {
        AlbumDetailModel *model = [[AlbumDetailModel alloc]init];
        [model setValuesForKeysWithDictionary:dic1];
        MyMusicDownLoadTable *table = [[MyMusicDownLoadTable alloc]init];
        NSArray *tableArray = [table selectAll];
        if (tableArray.count > 0) {
            for (NSArray *arr in tableArray) {
                if ([arr containsObject:model.playUrl64]) {
                    model.type = DiDdwonload;
                    model.flag = 3;
                }
            }
        }
        
        [arr addObject:model];
    }
    return arr;
    
}

+(AlbumDetailModel *)user:(NSDictionary *)dic
{
    NSDictionary *data = dic[@"data"];
    NSDictionary *user = data[@"user"];
    AlbumDetailModel *model = [[AlbumDetailModel alloc]init];
    [model setValuesForKeysWithDictionary:user];
    return model;
}


+(NSMutableArray *)payArray:(NSDictionary *)dic
{
    NSMutableArray *arr = [NSMutableArray array];
    NSDictionary *data = dic[@"data"];
    NSArray *list = data[@"list"];
    for (NSDictionary *dic1 in list) {
        AlbumDetailModel *model = [[AlbumDetailModel alloc]init];
        [model setValuesForKeysWithDictionary:dic1];
        [arr addObject:model];
    }
    return arr;
}



+(NSMutableArray *)arr:(NSDictionary *)dic
{
    NSMutableArray *arr1 = [NSMutableArray array];
    NSArray *list = dic[@"list"];
    for (NSDictionary *dic1 in list) {
        AlbumDetailModel *model = [[AlbumDetailModel alloc]init];
        [model setValuesForKeysWithDictionary:dic1];
        [arr1 addObject:model];
    }
    return arr1;
}



@end
