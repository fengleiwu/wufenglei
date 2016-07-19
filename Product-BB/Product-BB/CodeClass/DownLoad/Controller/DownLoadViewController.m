//
//  DownLoadViewController.m
//  Product-BB
//
//  Created by lanou on 16/7/11.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "DownLoadViewController.h"
@interface DownLoadViewController ()<UIScrollViewDelegate>
@property (nonatomic , strong)UISegmentedControl *seg;
@property (nonatomic , strong)UIScrollView *scr;
@property (nonatomic , strong)UIView *lineView;
@property (nonatomic , strong)UILabel *memoryLabel;
@end

@implementation DownLoadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navigationController.navigationBar.hidden = YES;
    [self creatSeg];
    [self creatScr];
    [self creatMemoryLabel];
    
    // Do any additional setup after loading the view.
}


#pragma mark 获取内存
// 获取当前设备可用内存(单位：MB）
-(double)availableMemory
{
    vm_statistics_data_t vmStats;
    mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT;
    kern_return_t kernReturn = host_statistics(mach_host_self(),
                                               HOST_VM_INFO,
                                               (host_info_t)&vmStats,
                                               &infoCount);
    
    if (kernReturn != KERN_SUCCESS) {
        return NSNotFound;
    }
    
    return ((vm_page_size *vmStats.free_count) / 1024.0) / 1024.0;
}

// 获取当前任务所占用的内存（单位：MB）
- (double)usedMemory
{
    task_basic_info_data_t taskInfo;
    mach_msg_type_number_t infoCount = TASK_BASIC_INFO_COUNT;
    kern_return_t kernReturn = task_info(mach_task_self(),
                                         TASK_BASIC_INFO,
                                         (task_info_t)&taskInfo,
                                         &infoCount);
    
    if (kernReturn != KERN_SUCCESS
        ) {
        return NSNotFound;
    }
    
    return taskInfo.resident_size / 1024.0 / 1024.0;
}



-(void)creatSeg
{
    self.seg = [[UISegmentedControl alloc]initWithItems:@[@"推荐",@"订阅",@"历史"]];
    self.seg.frame = CGRectMake(0, 20, kScreenWidth, 44);
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:20],
                          NSForegroundColorAttributeName:[UIColor redColor]};
    self.seg.tintColor = [UIColor clearColor];
    [self.seg setTitleTextAttributes:dic forState:(UIControlStateSelected)];
    NSDictionary *dic1 = @{NSFontAttributeName:[UIFont systemFontOfSize:20],
                           NSForegroundColorAttributeName:[UIColor blackColor]};
    [self.seg setTitleTextAttributes:dic1 forState:(UIControlStateNormal)];
    self.lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 43, kScreenWidth / 3, 1)];
    self.lineView.backgroundColor = [UIColor redColor];
    [self.seg addTarget:self action:@selector(segAction) forControlEvents:(UIControlEventValueChanged)];
    
    [self.view addSubview:self.seg];
    [self.seg addSubview:self.lineView];
}

-(void)creatScr
{
    self.scr = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 84, kScreenWidth, kScreenHeight - 84 - 40)];
    self.scr.contentSize = CGSizeMake(kScreenWidth * 3, 0);
    self.scr.pagingEnabled = YES;
    self.scr.delegate = self;
    [self.view addSubview:self.scr];
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.seg.selectedSegmentIndex = self.scr.contentOffset.x / kScreenWidth;
    self.lineView.frame = CGRectMake(kScreenWidth / 3 * self.seg.selectedSegmentIndex, 43, kScreenWidth / 3, 1);
}

-(void)segAction
{
    CGPoint point = CGPointMake(self.seg.selectedSegmentIndex * kScreenWidth, 0);
    self.scr.contentOffset = point;
    self.lineView.frame = CGRectMake(kScreenWidth / 3 * self.seg.selectedSegmentIndex, 43, kScreenWidth / 3, 1);
}


-(void)creatMemoryLabel
{
    self.memoryLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, 20)];
    self.memoryLabel.font = [UIFont systemFontOfSize:12];
    self.memoryLabel.textColor = [UIColor whiteColor];
    self.memoryLabel.textAlignment = NSTextAlignmentCenter;
    self.memoryLabel.backgroundColor = [UIColor grayColor];
    double userMemory = [self usedMemory];
    double available = [self availableMemory];
    
    self.memoryLabel.text = [NSString stringWithFormat:@"已占用%.2fMB,可用%.2fMB",userMemory,available];
    [self.view addSubview:self.memoryLabel];
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
