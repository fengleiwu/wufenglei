//
//  BroadcastListViewController.h
//  Product-BB
//
//  Created by 林建 on 16/7/13.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BroadcastListViewController : UIViewController

@property (nonatomic, assign) NSInteger categoryId;
@property (nonatomic, strong) NSString *topTitleName;
// 记录上一个页面的 早安上海、排行榜
@property (nonatomic, assign) NSInteger locationId;
@property (nonatomic, assign) NSInteger rankId;
// 记录上一个页面的最上面的四个 button
@property (nonatomic, assign) NSInteger topBtnTag;


@end
