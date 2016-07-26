//
//  OtherProgramViewController.m
//  Product-BB
//
//  Created by 林建 on 16/7/16.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "OtherProgramViewController.h"
#import "AllMoreTableViewCell.h"
#import "AllHotTableViewCell.h"
#import "AnchorTableViewCell.h"
#import "AllHotModel.h"
#import "attentionViewController.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>

@interface OtherProgramViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *tableV;
@property (nonatomic, strong)UIButton *moreB;
@property (nonatomic, strong)NSMutableArray *squareArr;
@end

@implementation OtherProgramViewController
-(NSMutableArray *)squareArr{
    if (!_squareArr) {
        _squareArr = [NSMutableArray array];
    }
    return _squareArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.titleStr;
    self.view.backgroundColor = [UIColor whiteColor];
    //更多按钮
    self.moreB = [UIButton buttonWithType:UIButtonTypeSystem];
    self.moreB.tintColor = [UIColor blackColor];
    self.moreB.backgroundColor = [UIColor whiteColor];
    self.moreB.frame = CGRectMake(kScreenWidth-70, 10, 30, 30);
    [self.moreB setImage:[UIImage imageNamed:@"更多.png"] forState:UIControlStateNormal];
    [self.moreB addTarget:self action:@selector(moreAction) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:self.moreB];
    [self requestData];
    // Do any additional setup after loading the view.
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.moreB removeFromSuperview];
}

#pragma mark ----- 请求数据 -----
-(void)requestData{
    NSString *str = self.urlStr;
[RequestManager requestWithUrlString:str requestType:RequestGET parDic:nil finish:^(NSData *data) {
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    self.squareArr = [AllHotModel modelConfigureWithDic:dic];
    [self.view addSubview:self.tableV];
} error:^(NSError *error) {
    NSLog(@"error == %@",error);
}];
}

#pragma mark ----- 分享方法 -----
-(void)moreAction{
    //分享
    //1、创建分享参数
    NSArray* imageArray = @[[UIImage imageNamed:@"1004.jpg"]];
    //    （注意：图片必须要在Xcode左边目录里面，名称必须要传正确，如果要分享网络图片，可以这样传iamge参数 images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
    if (imageArray) {
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        //2、分享（可以弹出我们的分享菜单和编辑界面）
        [ShareSDK showShareActionSheet:nil //要显示菜单的视图, iPad版中此参数作为弹出菜单的参照视图，只有传这个才可以弹出我们的分享菜单，可以传分享的按钮对象或者自己创建小的view 对象，iPhone可以传nil不会影响
                                 items:nil
                           shareParams:shareParams
                   onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                       
                       switch (state) {
                           case SSDKResponseStateSuccess:
                           {
                               UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                                   message:nil
                                                                                  delegate:nil
                                                                         cancelButtonTitle:@"确定"
                                                                         otherButtonTitles:nil];
                               [alertView show];
                               break;
                           }
                           case SSDKResponseStateFail:
                           {
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                               message:[NSString stringWithFormat:@"%@",error]
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"OK"
                                                                     otherButtonTitles:nil, nil];
                               [alert show];
                               break;
                           }
                           default:
                               break;
                       }
                   }];
    }
    
}

#pragma mark ----- 创建tableView -----
-(UITableView *)tableV{
    if (!_tableV) {
        _tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64) style:UITableViewStylePlain];
        _tableV.delegate = self;
        _tableV.dataSource = self;
        if (self.indexC == 3 || self.indexC == 7 || self.indexC == 8) {
        [_tableV registerClass:[AllHotTableViewCell class] forCellReuseIdentifier:@"ALLHOTCell"];
        } else if (self.indexC == 100){
        [_tableV registerClass:[AnchorTableViewCell class] forCellReuseIdentifier:@"AnchorCell"];
        } else {
        [_tableV registerClass:[AllMoreTableViewCell class] forCellReuseIdentifier:@"ALLMORECell"];
        }
    }
    return _tableV;
}

#pragma mark ----- tableView协议方法 -----
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.squareArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    AllHotModel *model = self.squareArr[indexPath.row];
    if (self.indexC == 3 || self.indexC == 7 || self.indexC == 8) {
        CGFloat H = [AdjustHeight adjustHeightByString:model.title width:kScreenWidth*9/10-80 font:18];
        return H+50;
    } else {
        return 100;
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AllHotModel *model = self.squareArr[indexPath.row];
    if (self.indexC == 3 || self.indexC == 7 || self.indexC == 8) {
        AllHotTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ALLHOTCell" forIndexPath:indexPath];
        [cell cellConfigureWithModel:model];
        cell.rankL.text = [NSString stringWithFormat:@"%ld",indexPath.row +1];
        if (indexPath.row == 0) {
            cell.rankL.textColor = PKCOLOR(255, 69, 0);
        }
        if (indexPath.row == 1) {
            cell.rankL.textColor = PKCOLOR(255, 160, 0);
        }
        if (indexPath.row == 2) {
            cell.rankL.textColor = PKCOLOR(154, 205, 50);
        }
        return cell;
    } else if (self.indexC == 100){
        AnchorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AnchorCell" forIndexPath:indexPath];
        [cell cellConfigureWithModel:model];
        cell.rankL.text = [NSString stringWithFormat:@"%ld",indexPath.row +1];
        if (indexPath.row == 0) {
            cell.rankL.textColor = PKCOLOR(255, 69, 0);
        }
        if (indexPath.row == 1) {
            cell.rankL.textColor = PKCOLOR(255, 160, 0);
        }
        if (indexPath.row == 2) {
            cell.rankL.textColor = PKCOLOR(154, 205, 50);
        }
        return cell;
    }else {
        AllMoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ALLMORECell" forIndexPath:indexPath];
        [cell cellConfigureWithModel:model];
        cell.rankL.text = [NSString stringWithFormat:@"%ld",indexPath.row +1];
        if (indexPath.row == 0) {
            cell.rankL.textColor = PKCOLOR(255, 69, 0);
        }
        if (indexPath.row == 1) {
            cell.rankL.textColor = PKCOLOR(255, 160, 0);
        }
        if (indexPath.row == 2) {
            cell.rankL.textColor = PKCOLOR(154, 205, 50);
        }
        return cell;
    }
   
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    attentionViewController *attent = [[attentionViewController alloc]init];
    AllHotModel *model = self.squareArr[indexPath.row];
    attent.Uid = model.uid;
    [self.navigationController pushViewController:attent animated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
