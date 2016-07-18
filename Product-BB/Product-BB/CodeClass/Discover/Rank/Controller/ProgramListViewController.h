//
//  ProgramListViewController.h
//  Product-BB
//
//  Created by 林建 on 16/7/14.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProgramListViewController : UIViewController
@property (nonatomic, strong)NSString *urlStr;
@property (nonatomic, strong)NSString *titleStr;
@property (nonatomic, assign)NSInteger conset;
@property (nonatomic, assign)BOOL collset;
@property (nonatomic, assign)BOOL isClick;
@end
