//
//  AlbumDetailViewController.h
//  Product-BB
//
//  Created by lanou on 16/7/13.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlbumDetailViewController : UIViewController

@property(nonatomic , strong)NSString *url;//albumid
@property(nonatomic , assign)NSInteger inter;//有购买不传  没购买传>3


@property(nonatomic , assign)BOOL isPaid;
@property(nonatomic , assign)NSInteger row;//第几个
@property(nonatomic , strong)NSString *uid;//uid
@property(nonatomic , strong)NSString *nickName;

@property(nonatomic , strong)NSString *score;
@property(nonatomic , strong)NSString *displayPrice;




@end
