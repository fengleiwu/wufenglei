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

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.smallLogo forKey:@"smallLogo"];
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.nickname forKey:@"nickname"];
    [aCoder encodeObject:self.playtimes forKey:@"playtimes"];
    [aCoder encodeObject:self.likes forKey:@"likes"];
    [aCoder encodeObject:self.comments forKey:@"comments"];
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

@end
