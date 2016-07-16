//
//  focusImagesModel.h
//  Product-BB
//
//  Created by lanou on 16/7/11.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface focusImagesModel : NSObject

@property(nonatomic , strong)NSString *albumId;
@property(nonatomic , strong)NSString *pic;
@property(nonatomic , strong)NSString *intro;
@property(nonatomic , strong)NSString *title;
@property(nonatomic , strong)NSString *coverMiddle;
@property(nonatomic , strong)NSString *coverPath;
@property(nonatomic , strong)NSString *footnote;
@property(nonatomic , strong)NSString *subtitle;
@property(nonatomic , strong)NSString *specialId;
@property(nonatomic , strong)NSString *contentType;




+(NSMutableArray *)focusImages:(NSDictionary *)dic;

+(NSMutableArray *)editorRecommendAlbums:(NSDictionary *)dic;

+(NSMutableArray *)specialColumn:(NSDictionary *)dic;


@end
