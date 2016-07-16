//
//  AnchorTableViewController.h
//  Product-BB
//
//  Created by lanou on 16/7/16.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnchorTableViewController : UIViewController

@property(nonatomic , strong)UITableView *table;

+(AnchorTableViewController *)shareManager;

-(void)creatTableView:(CGRect)frame;


@end
