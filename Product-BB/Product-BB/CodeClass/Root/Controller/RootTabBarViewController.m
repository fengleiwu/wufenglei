//
//  RootTabBarViewController.m
//  Product-BB
//
//  Created by lanou on 16/7/11.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "RootTabBarViewController.h"
#import "DiscoverViewController.h"
#import "DownLoadViewController.h"
#import "MineViewController.h"
#import "MusicplayViewController.h"
#import "SubscriptionViewController.h"
@interface RootTabBarViewController ()
@property (nonatomic , strong)UIButton *btn;

@property (nonatomic , assign)BOOL isPlay;
@property (nonatomic, strong) NSMutableArray *playArray;
@property (nonatomic, strong) NSString *btnImage;

@end

@implementation RootTabBarViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.isPlay = NO;
    DiscoverViewController *disc = [[DiscoverViewController alloc]init];
    SubscriptionViewController *sub = [[SubscriptionViewController alloc]init];
    MusicplayViewController *play = [[MusicplayViewController alloc]init];
    DownLoadViewController *down = [[DownLoadViewController alloc]init];
    MineViewController *mine = [[MineViewController alloc]init];
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, -16, self.tabBar.frame.size.width, self.tabBar.frame.size.height +20)];
    self.btn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.btn.frame = CGRectMake(0, 0, self.tabBar.frame.size.height, self.tabBar.frame.size.height);
    [self.btn.layer setMasksToBounds:YES];
    [self.btn.layer setCornerRadius:self.tabBar.frame.size.height/2];
    self.btn.center = CGPointMake(self.tabBar.centerX, self.tabBar.centerY - 10);
    [self.btn setBackgroundImage:[UIImage imageNamed:@"music_icon_play_highlighted@3x"] forState:(UIControlStateNormal)];
    [self.btn addTarget:self action:@selector(playAction) forControlEvents:(UIControlEventTouchUpInside)];
    imageV.image = [UIImage imageNamed:@"tabbar_bg@3x"];
    [self.tabBar insertSubview:imageV atIndex:0];
    self.tabBar.tintColor = [UIColor orangeColor];
    //覆盖原生Tabbar的上横线
    [[UITabBar appearance] setShadowImage:[self createImageWithColor:[UIColor clearColor]]];
    [[UITabBar appearance] setBackgroundImage:[self createImageWithColor:[UIColor clearColor]]];
    [self creatTab:disc title:@"发现" name:@"" image:[UIImage imageNamed:@"发现"]];
    [self creatTab:sub title:@"订阅听" name:@"" image:[UIImage imageNamed:@"订阅"]];
    [self creatTab:play title:nil name:nil image:nil];
    [self creatTab:down title:@"下载听" name:@"" image:[UIImage imageNamed:@"download下载"]];
    [self creatTab:mine title:@"我的" name:@"" image:[UIImage imageNamed:@"我的"]];
    
    [self.view addSubview:self.btn];
    
    
    
    
    
    
    //
    [MyPlayerManager defaultManager].blockWithArray = ^(NSMutableArray *arr) {
        self.playArray = arr;
    };
    [MyPlayerManager defaultManager].blockWithBool = ^(BOOL isp) {
        self.isPlay = isp;
    };
//        [MyPlayerManager defaultManager].blockWithImage = ^(NSString *image) {
//            [self.btn setBackgroundImage:[UIImage imageNamed:image] forState:(UIControlStateNormal)];
//        };

}
#pragma mark ---- 创建tabBar视图控制器 ----
-(void)creatTab:(UIViewController *)view title:(NSString *)title name:(NSString *)name image:(UIImage *)image
{
    UINavigationController *naVC = [[UINavigationController alloc]initWithRootViewController:view];
    NSDictionary *dic = @{NSFontAttributeName : [UIFont systemFontOfSize:13]};
    [[UITabBarItem appearance] setTitleTextAttributes:dic forState:(UIControlStateNormal)];
    [view.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bg_nav@2x"] forBarMetrics:0];
    view.title = name;
    naVC.tabBarItem = [[UITabBarItem alloc]initWithTitle:title image:image tag:100];
    [self addChildViewController:naVC];
}



#pragma mark ---btnAction
-(void)playAction
{
    if (self.isPlay == NO) {
        [self.btn setBackgroundImage:[UIImage imageNamed:@"music_icon_stop_highlighted@3x"] forState:(UIControlStateNormal)];
        self.isPlay = YES;
    }else{
        [self.btn setBackgroundImage:[UIImage imageNamed:@"music_icon_play_highlighted@3x"] forState:(UIControlStateNormal)];
        self.isPlay = NO;
    }
}

#pragma mark ----- 覆盖线条方法 -----
-(UIImage *)createImageWithColor:(UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

//#pragma mark ----btnAction
//-(void)playAction
//{
//    
//    _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(circleAnimationTypeOne) userInfo:nil repeats:YES];
//    
//    [_timer fire];
//    self.circle = [[CircleAnimation alloc]initWithFrame:CGRectMake(0, 0, self.btn.frame.size.width, self.btn.frame.size.height) backgroundImage:nil addAtView:self.btn];
//   self.circle.shapeLayer.strokeEnd = 0;
//    self.circle.shapeLayer.strokeStart = 0;
//    self.circle.shapeLayer.strokeColor = [UIColor blackColor].CGColor;
//    [self.circle addProgressBar];
//}
//
//-(void)circleAnimationTypeOne
//{
//    if (self.circle.shapeLayer.strokeEnd > 1 && self.circle.shapeLayer.strokeStart < 1) {
//        self.circle.shapeLayer.strokeStart += 0.1;
//    }else if(self.circle.shapeLayer.strokeStart == 0){
//        self.circle.shapeLayer.strokeEnd += 0.1;
//    }
//    
//    if (self.circle.shapeLayer.strokeEnd == 0) {
//        self.circle.shapeLayer.strokeStart = 0;
//    }
//    
//    if (self.circle.shapeLayer.strokeEnd == self.circle.shapeLayer.strokeStart) {
//        self.circle.shapeLayer.strokeEnd = 0;
//    }
//
//}





/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
