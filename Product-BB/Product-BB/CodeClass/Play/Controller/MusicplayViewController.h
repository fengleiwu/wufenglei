//
//  BroadcastPlayViewController.h
//  Product-B
//
//  Created by lanou on 16/7/14.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MusicplayViewController : UIViewController

// 接收传进来的 modelArray
@property (nonatomic,strong) NSMutableArray *newmodelArray;
// 判断传过来的 URL 是 a3u8
@property (nonatomic, strong) NSString *playPath32;
// 判断点击是哪个 row
@property (nonatomic, assign) NSInteger clickRow;


@end
