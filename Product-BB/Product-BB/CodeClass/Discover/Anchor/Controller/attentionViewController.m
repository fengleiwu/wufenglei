//
//  attentionViewController.m
//  Product-BB
//
//  Created by lanou on 16/7/17.
//  Copyright © 2016年 lanou. All rights reserved.
//

//关注界面
#import "attentionViewController.h"
#import "recommendMoreTableViewCell.h"
#import "ListenDetailTableViewCell.h"
#import "attentionModel.h"
#import "AlbumDetailViewController.h"
#import "GFZtableViewController.h"
#import "HFStretchableTableHeaderView.h"
#import "MusicplayViewController.h"
#import "BroadMusicModel.h"

@interface attentionViewController ()<UITableViewDataSource , UITableViewDelegate>
@property (nonatomic , strong)UITableView *tab;
@property (nonatomic , strong)UIView *headView;
@property (nonatomic , strong)attentionModel *model;
@property (nonatomic , strong)NSMutableArray *middleArr;
@property (nonatomic , strong)NSMutableArray *bottomArr;
@property (nonatomic , strong)UIImageView *pImage;
@property (nonatomic , strong)UILabel *nameLabel;
@property (nonatomic , strong)UILabel *introduceLabel;
@property (nonatomic , strong)UIButton *updownBtn;
@property (nonatomic , strong)UIView *DownImageView;
@property (nonatomic , strong)UIImageView *image;
@property (nonatomic , assign)BOOL isUpDown;
@property (nonatomic , strong)UIVisualEffectView *effectview;
@property (nonatomic , strong)HFStretchableTableHeaderView *stretchHeaderView;

@end

@implementation attentionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isUpDown = NO;
    [self creatMiddleAndBottomView];
    self.automaticallyAdjustsScrollViewInsets = NO;
    // Do any additional setup after loading the view.
}


-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = YES;
    [self creatTableView];
}

-(void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = NO;

}

-(void)creatMiddleAndBottomView
{
    NSString *url = @"http://mobile.ximalaya.com/mobile/v1/artist/albums?device=iPhone&pageId=1&pageSize=2&statEvent=pageview%2Fuserlist%40%E6%98%8E%E6%98%9F%E5%A4%A7%E5%92%96&statModule=%E6%98%8E%E6%98%9F%E5%A4%A7%E5%92%96_%E6%9B%B4%E5%A4%9A&statPage=tab%40%E5%8F%91%E7%8E%B0_%E4%B8%BB%E6%92%AD&statPosition=1&toUid=11116807";
    NSString *url1 = [url stringByReplacingOccurrencesOfString:@"Uid=11116807" withString:[NSString stringWithFormat:@"Uid=%@",self.Uid]];
    [RequestManager requestWithUrlString:url1 requestType:RequestGET parDic:nil finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        self.middleArr = [attentionModel middle:dic];
        [self.tab reloadData];
    } error:^(NSError *error) {
        
    }];
    
    NSString *url2 = @"http://mobile.ximalaya.com/mobile/v1/artist/tracks?device=iPhone&pageId=1&pageSize=30&statEvent=pageview%2Fuserlist%40%E6%98%8E%E6%98%9F%E5%A4%A7%E5%92%96&statModule=%E6%98%8E%E6%98%9F%E5%A4%A7%E5%92%96_%E6%9B%B4%E5%A4%9A&statPage=tab%40%E5%8F%91%E7%8E%B0_%E4%B8%BB%E6%92%AD&statPosition=1&toUid=11116807";
    NSString *url3 = [url2 stringByReplacingOccurrencesOfString:@"Uid=11116807" withString:[NSString stringWithFormat:@"Uid=%@",self.Uid]];
    [RequestManager requestWithUrlString:url3 requestType:RequestGET parDic:nil finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        self.bottomArr = [attentionModel bottom:dic];
        [self.tab reloadData];
    } error:^(NSError *error) {
        
    }];
    
}


-(void)creatTableView
{
    self.tab = [[UITableView alloc]initWithFrame:CGRectMake(0,20, kScreenWidth, kScreenHeight  - 20) style:(UITableViewStylePlain)];
    self.tab.delegate = self;
    self.tab.dataSource = self;
    self.tab.rowHeight = 120;
    self.headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 350)];
   
    
    
    NSString *url = @"http://mobile.ximalaya.com/mobile/others/ca/homePage?device=iPhone&statEvent=pageview%2Fuserlist%40%E6%98%8E%E6%98%9F%E5%A4%A7%E5%92%96&statModule=%E6%98%8E%E6%98%9F%E5%A4%A7%E5%92%96_%E6%9B%B4%E5%A4%9A&statPage=tab%40%E5%8F%91%E7%8E%B0_%E4%B8%BB%E6%92%AD&statPosition=1&toUid=11116807";
    
    NSString *url1 = [url stringByReplacingOccurrencesOfString:@"Uid=11116807" withString:[NSString stringWithFormat:@"Uid=%@",self.Uid]];
    [RequestManager requestWithUrlString:url1 requestType:RequestGET parDic:nil finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        self.model = [attentionModel top:dic];
       self.image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 220)];
        
        //self.image.contentMode = UIViewContentModeScaleAspectFill;
        
        
        
        UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        self.effectview = [[UIVisualEffectView alloc] initWithEffect:blur];
        self.effectview.contentMode = UIViewContentModeScaleAspectFill;
        self.effectview.alpha = 0.5;
        self.effectview.frame = CGRectMake(0, 0, self.image.frame.size.width,self.image.frame.size.height);
        
//        self.stretchHeaderView = [HFStretchableTableHeaderView new];
//        [self.stretchHeaderView stretchHeaderForTableView:self.tab withView:self.effectview subViews:self.image];
        self.stretchHeaderView = [HFStretchableTableHeaderView new];
        [self.stretchHeaderView stretchHeaderForTableView:self.tab withView:self.image subViews:self.headView];
        
        [self.image addSubview:self.effectview];
        
        [self.image sd_setImageWithURL:[NSURL URLWithString:self.model.backgroundLogo]];
        self.pImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 20, 80, 80)];
        self.pImage.centerX = kScreenWidth / 2;
        [self.pImage sd_setImageWithURL:[NSURL URLWithString:self.model.mobileMiddleLogo]];
        [self.pImage.layer setMasksToBounds:YES];
        [self.pImage.layer setCornerRadius:40];
        self.DownImageView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 86, 86)];
        self.DownImageView.center = self.pImage.center;
        [self.DownImageView.layer setMasksToBounds:YES];
        [self.DownImageView.layer setCornerRadius:43];
        self.DownImageView.backgroundColor = [UIColor grayColor];
        self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 110, 200, 40)];
        self.nameLabel.text = self.model.nickname;
        CGFloat height = [AdjustHeight adjustHeightByString:self.model.nickname hidth:40 font:17];
        self.nameLabel.width =height + 40;
        self.nameLabel.textColor = [UIColor whiteColor];
        self.nameLabel.centerX = kScreenWidth / 2 - 10;
        self.nameLabel.textAlignment = NSTextAlignmentCenter;
        UIButton *vBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        vBtn.frame = CGRectMake(height + 20, 10, 20, 20);
        [vBtn setImage:[UIImage imageNamed:@"V"] forState:(UIControlStateNormal)];
        vBtn.tintColor = [UIColor redColor];
        [self.nameLabel addSubview:vBtn];
        self.introduceLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 160, 200, 40)];
        self.introduceLabel.centerX = kScreenWidth / 2;
        self.introduceLabel.textAlignment = NSTextAlignmentCenter;
        self.introduceLabel.textColor = [UIColor whiteColor];
        self.introduceLabel.font = [UIFont systemFontOfSize:13];
        self.introduceLabel.text = self.model.personalSignature;
        self.updownBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.updownBtn.frame = CGRectMake(0, 200, 200, 20);
        self.updownBtn.centerX = kScreenWidth / 2;
        [self.updownBtn setImage:[UIImage imageNamed:@"箭头"] forState:(UIControlStateNormal)];
        [self.updownBtn setTintColor:[UIColor whiteColor]];
        [self.updownBtn addTarget:self action:@selector(updownAction:) forControlEvents:(UIControlEventTouchUpInside)];
        UIButton *guanzhuBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        guanzhuBtn.frame = CGRectMake(30, 230, kScreenWidth - 60, 40);
        guanzhuBtn.backgroundColor = [UIColor redColor];
        [guanzhuBtn setTitle:@"关注" forState:(UIControlStateNormal)];
        [guanzhuBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        NSArray *arr1 = @[@"关注的人",@"粉丝",@"赞过的"];
        NSString *st1 = [NSString stringWithFormat:@"%@",self.model.followings];
        NSString *st2 = [NSString string];
        CGFloat f = [self.model.followers floatValue];
        if (f >= 10000) {
            st2 = [NSString stringWithFormat:@"%.1f万",f / 10000];
        }else if (f < 10000){
            st2 = [NSString stringWithFormat:@"%@",self.model.followers];
        }
        NSString *st3 = [NSString stringWithFormat:@"%@",self.model.favorites];
        NSArray *arr2 = @[st1 , st2 , st3];
        for (int i = 0; i < 3; i++) {
            UIButton *btn = [UIButton buttonWithType:(UIButtonTypeSystem)];
            btn.frame = CGRectMake(20 + (kScreenWidth - 50)/3 * i, 280, (kScreenWidth - 50)/3, 60);
            [btn setTag:i + 1];
            [btn addTarget:self action:@selector(gfzBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
            UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, (kScreenWidth - 50)/3, 30)];
            UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 30, (kScreenWidth - 50)/3, 30)];
            label1.font = [UIFont systemFontOfSize:15];
            label2.textColor = [UIColor grayColor];
            label2.font = [UIFont systemFontOfSize:14];
            label1.text = arr2[i];
            label2.text = arr1[i];
            label1.textAlignment = NSTextAlignmentCenter;
            label2.textAlignment = NSTextAlignmentCenter;
            [btn addSubview:label1];
            [btn addSubview:label2];
            [self.headView addSubview:btn];
        }
        UIButton *back = [UIButton buttonWithType:(UIButtonTypeSystem)];
        back.frame = CGRectMake(20, 20, 30, 30);
        [back setImage:[UIImage imageNamed:@"箭头 (2)"] forState:(UIControlStateNormal)];
        [back addTarget:self action:@selector(backAction) forControlEvents:(UIControlEventTouchUpInside)];
        [back setTintColor:[UIColor whiteColor]];
        [self.headView insertSubview:self.image atIndex:0];
         [self.headView addSubview:guanzhuBtn];
        [self.headView addSubview:self.DownImageView];
        [self.headView addSubview:self.pImage];
        [self.headView addSubview:self.nameLabel];
        [self.headView addSubview:self.introduceLabel];
        [self.headView addSubview:back];
        [self.headView addSubview:self.updownBtn];
        self.tab.tableHeaderView = self.headView;
        [self.view addSubview:self.tab];
    } error:^(NSError *error) {
        
    }];
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.stretchHeaderView scrollViewDidScroll:scrollView];
    if (self.tab.contentOffset.y<0) {
        CGFloat f = 220 - self.tab.contentOffset.y;
        self.effectview.height = f;
        self.effectview.width = 2*kScreenWidth;
        
        }
    [self.image addSubview:self.effectview];

}

- (void)viewDidLayoutSubviews
{
    [self.stretchHeaderView resizeView];
    self.effectview.frame = self.image.frame;
    [self.image addSubview:self.effectview];


}






-(void)gfzBtnAction:(UIButton *)btn
{
    GFZtableViewController *gfz = [[GFZtableViewController alloc]init];
    gfz.uid = self.Uid;
    gfz.inter = btn.tag;
    [self.navigationController pushViewController:gfz animated:YES];
}

-(void)updownAction:(UIButton *)btn
{
    if (self.isUpDown == NO) {
        [UIView animateWithDuration:1 animations:^{
            self.pImage.transform = CGAffineTransformMakeTranslation(0, -110);
            self.nameLabel.transform = CGAffineTransformMakeTranslation(0, -110);
            self.introduceLabel.transform = CGAffineTransformMakeTranslation(0, -110);
            self.DownImageView.transform = CGAffineTransformMakeTranslation(0, -110);
          self.introduceLabel.height = [AdjustHeight adjustHeightByString:self.model.personalSignature width:200 font:13];
            self.introduceLabel.numberOfLines = 0;
        } completion:^(BOOL finished) {
            }];
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        animation.toValue = [NSNumber numberWithFloat:M_PI * 2];
        animation.duration = 1;
        animation.repeatCount = 1;
        [self.pImage.layer addAnimation:animation forKey:nil];
        [self.DownImageView.layer addAnimation:animation forKey:nil];
        self.isUpDown = YES;
        [self.updownBtn setImage:[UIImage imageNamed:@"箭头 (1)"] forState:(UIControlStateNormal)];
            }else if (self.isUpDown == YES){
                [UIView animateWithDuration:1 animations:^{
                    self.pImage.transform = CGAffineTransformMakeTranslation(0, 0);
                    self.nameLabel.transform = CGAffineTransformMakeTranslation(0, 0);
                    self.introduceLabel.transform = CGAffineTransformMakeTranslation(0, 0);
                    self.DownImageView.transform = CGAffineTransformMakeTranslation(0, 0);

                    self.introduceLabel.numberOfLines = 1;
                    self.introduceLabel.height = 40;
                    } completion:^(BOOL finished) {
                    }];
                CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
                animation.toValue = [NSNumber numberWithFloat:-M_PI * 2];
                animation.duration = 1;
                animation.repeatCount = 1;
                [self.pImage.layer addAnimation:animation forKey:nil];
                [self.DownImageView.layer addAnimation:animation forKey:nil];
                self.isUpDown = NO;
                [self.updownBtn setImage:[UIImage imageNamed:@"箭头"] forState:(UIControlStateNormal)];
}
}


-(void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return self.middleArr.count;
    }else{
        return self.bottomArr.count;
        
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        recommendMoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ss"];
        if (!cell) {
            cell = [[recommendMoreTableViewCell alloc]initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"ss"];
        }
        attentionModel *model = self.middleArr[indexPath.row];
        [cell creatAttentionMiddle:model];
        return cell;
    }else{
        ListenDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"sss"];
        if (!cell) {
            cell = [[ListenDetailTableViewCell alloc]initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"sss"];
        }
        attentionModel *model = self.bottomArr[indexPath.row];
        [cell creatAttentionCell:model];
        return cell;
    }
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"发布的专辑";
    }else{
        return @"发布的声音";
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        attentionModel *model = self.middleArr[indexPath.row];
        AlbumDetailViewController *album = [[AlbumDetailViewController alloc]init];
        album.url = model.albumId;
        if (model.isPaid == true) {
            album.uid = model.uid;
            album.isPaid = YES;
            album.row = indexPath.row;
            album.nickName = self.model.nickname;
        }else{
        album.inter = 4;
        }
        [self.navigationController pushViewController:album animated:YES];
    } else {
        attentionModel *model = self.bottomArr[indexPath.row];
        if (model.playUrl64 == nil) {
//            NSLog(@"需要购买才能听");
        } else {
            MusicplayViewController *playVC = [[MusicplayViewController alloc]init];
            playVC.newmodelArray = [BroadMusicModel modelCOnfigureWithAttentionModel:self.bottomArr];
            
            [MyPlayerManager defaultManager].index = indexPath.row;
            [MyPlayerManager defaultManager].musicLists = playVC.newmodelArray;
            
            [self presentViewController:playVC animated:YES completion:nil];
        }
    }
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
