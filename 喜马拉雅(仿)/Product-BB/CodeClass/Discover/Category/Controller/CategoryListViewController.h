//
//  CategoryListViewController.h
//  Product-BB
//
//  Created by 林建 on 16/7/13.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CategoryListViewController : UIViewController
@property (nonatomic, strong)NSString *titleStr;
@property (nonatomic, strong)NSString *tableStr;
@property (nonatomic, strong)NSString *URLLStr;
@property (nonatomic, assign)NSInteger idd;
@property (nonatomic, assign)NSInteger keyId;
@property (nonatomic, assign)NSInteger conset;
@property (nonatomic, assign)NSInteger start;
@property (nonatomic, assign)NSInteger limit;
@property (nonatomic, assign)BOOL colset;
@property (nonatomic, assign)BOOL reload;
@property (nonatomic, assign)BOOL startOver;
@end
