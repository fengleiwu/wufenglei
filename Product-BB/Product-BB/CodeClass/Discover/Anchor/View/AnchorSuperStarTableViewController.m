//
//  AnchorSuperStarTableViewController.m
//  Product-BB
//
//  Created by lanou on 16/7/16.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "AnchorSuperStarTableViewController.h"
#import "AnchorModel.h"
#import "AnchorSongerTableViewCell.h"
#import "attentionViewController.h"
@interface AnchorSuperStarTableViewController ()<UIScrollViewDelegate>
@property (nonatomic , strong)NSMutableArray *arr;
@property (nonatomic , strong)UIScrollView *scr;
@property (nonatomic , strong)UISegmentedControl *seg;
@property (nonatomic , strong)NSMutableArray *NewArr;
@property (nonatomic , strong)UITableView *NewTab;
@property (nonatomic , strong)NSMutableArray *HotArr;
@property (nonatomic , strong)UITableView *HotTab;

@property (nonatomic , strong)UITableView *famous;
@end

@implementation AnchorSuperStarTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.inter == 1) {
        [self creatFamousTableView];
    }else if (self.inter == 2){
        [self creatNormalTableView];
        NSString *url = @"http://mobile.ximalaya.com/m/explore_user_list?category_name=finance&condition=hot&device=iPhone&page=1&per_page=20&statEvent=pageview%2Fuserlist%40%E6%83%85%E6%84%9F%E7%94%9F%E6%B4%BB&statModule=%E6%83%85%E6%84%9F%E7%94%9F%E6%B4%BB_%E6%9B%B4%E5%A4%9A&statPage=tab%40%E5%8F%91%E7%8E%B0_%E4%B8%BB%E6%92%AD&statPosition=5";
        NSString *url1 = [url stringByReplacingOccurrencesOfString:@"category_name=finance" withString:[NSString stringWithFormat:@"category_name=%@",self.name]];
        [RequestManager requestWithUrlString:url1 requestType:RequestGET parDic:nil finish:^(NSData *data) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            self.HotArr = [AnchorModel moreSuperStar:dic];
            [self.HotTab reloadData];
        } error:^(NSError *error) {
            
        }];
        
        
        NSString *url2 = @"http://mobile.ximalaya.com/m/explore_user_list?category_name=finance&condition=new&device=iPhone&page=1&per_page=20&statEvent=pageview%2Fuserlist%40%E6%83%85%E6%84%9F%E7%94%9F%E6%B4%BB&statModule=%E6%83%85%E6%84%9F%E7%94%9F%E6%B4%BB_%E6%9B%B4%E5%A4%9A&statPage=tab%40%E5%8F%91%E7%8E%B0_%E4%B8%BB%E6%92%AD&statPosition=5";
        NSString *url3 = [url2 stringByReplacingOccurrencesOfString:@"category_name=finance" withString:[NSString stringWithFormat:@"category_name=%@",self.name]];
        [RequestManager requestWithUrlString:url3 requestType:RequestGET parDic:nil finish:^(NSData *data) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            self.NewArr = [AnchorModel moreSuperStar:dic];
            [self.NewTab reloadData];
        } error:^(NSError *error) {
            
        }];
        
        
        
    }
    
    self.title = self.titleL;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)creatNormalTableView
{
    self.seg = [[UISegmentedControl alloc]initWithItems:@[@"最热",@"最新"]];
    self.seg.frame = CGRectMake(10, 10, kScreenWidth - 20, 40);
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:15],
                          NSForegroundColorAttributeName:[UIColor whiteColor]};
    [self.seg setTitleTextAttributes:dic forState:(UIControlStateSelected)];
    NSDictionary *dic1 = @{NSFontAttributeName:[UIFont systemFontOfSize:15],
                           NSForegroundColorAttributeName:[UIColor orangeColor]};
    [self.seg setTitleTextAttributes:dic1 forState:(UIControlStateNormal)];
    [self.seg setTintColor:[UIColor orangeColor]];
    [self.seg addTarget:self action:@selector(segAction) forControlEvents:(UIControlEventValueChanged)];
    self.seg.selectedSegmentIndex = 0;
    
    [self.view addSubview:self.seg];
    self.scr = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 55, kScreenWidth, kScreenHeight-55)];
    self.scr.contentSize = CGSizeMake(kScreenWidth * 2, 0);
    self.scr.delegate = self;
    self.scr.pagingEnabled = YES;
    [self.view addSubview:self.scr];
    self.HotTab = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 120) style:(UITableViewStylePlain)];
    self.HotTab.delegate = self;
    self.HotTab.dataSource = self;
    self.HotTab.rowHeight = 130;
    [self.scr addSubview:self.HotTab];
    self.NewTab = [[UITableView alloc]initWithFrame:CGRectMake(kScreenWidth, 0, kScreenWidth, kScreenHeight - 120) style:(UITableViewStylePlain)];
    self.NewTab.delegate = self;
    self.NewTab.dataSource = self;
    self.NewTab.rowHeight = 130;
    [self.scr addSubview:self.NewTab];
    
    
}

-(void)segAction
{
    CGPoint point = CGPointMake(self.seg.selectedSegmentIndex * kScreenWidth, 0);
    self.scr.contentOffset = point;
    [self.NewTab reloadData];
    [self.HotTab reloadData];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.seg.selectedSegmentIndex = self.scr.contentOffset.x / kScreenWidth;
    [self.NewTab reloadData];
    [self.HotTab reloadData];
    
}

-(void)creatFamousTableView
{
    self.famous = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 120) style:(UITableViewStylePlain)];
    self.famous.delegate = self;
    self.famous.dataSource = self;
    [self.view addSubview:self.famous];
    self.famous.rowHeight = 130;
    
    NSString *url = @"http://mobile.ximalaya.com/mobile/discovery/v1/anchor/famous?category_id=2&device=iPhone&page=1&per_page=20&statEvent=pageview%2Fuserlist%40%E6%98%8E%E6%98%9F%E5%A4%A7%E5%92%96&statModule=%E6%98%8E%E6%98%9F%E5%A4%A7%E5%92%96_%E6%9B%B4%E5%A4%9A&statPage=tab%40%E5%8F%91%E7%8E%B0_%E4%B8%BB%E6%92%AD&statPosition=1";
    NSString *url1 = [url stringByReplacingOccurrencesOfString:@"category_id=2" withString:[NSString stringWithFormat:@"category_id=%@",self.MyID]];
    [RequestManager requestWithUrlString:url1 requestType:RequestGET parDic:nil finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        self.arr = [AnchorModel moreSuperStar:dic];
        [self.famous reloadData];
    } error:^(NSError *error) {
        
    }];
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.inter == 1) {
        
        return self.arr.count;
    }else if (self.seg.selectedSegmentIndex == 0){
        return self.HotArr.count;
    }else{
        return self.NewArr.count;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AnchorSongerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ss"];
    if (!cell) {
        cell = [[AnchorSongerTableViewCell alloc]initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"ss"];
    }
    if (self.inter == 1) {
        
        AnchorModel *model = self.arr[indexPath.row];
        [cell creatCell:model];
    }else if (self.seg.selectedSegmentIndex == 0){
        AnchorModel *model = self.HotArr[indexPath.row];
        [cell creatCell:model];
    }else if (self.seg.selectedSegmentIndex == 1){
        AnchorModel *model = self.NewArr[indexPath.row];
        [cell creatCell:model];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    attentionViewController *attent = [[attentionViewController alloc]init];
    if (self.inter == 1) {
        
        AnchorModel *model = self.arr[indexPath.row];
        attent.Uid = model.uid;
    }else if (self.seg.selectedSegmentIndex == 0){
        AnchorModel *model = self.HotArr[indexPath.row];
        attent.Uid = model.uid;
   }else if (self.seg.selectedSegmentIndex == 1){
        AnchorModel *model = self.NewArr[indexPath.row];
        attent.Uid = model.uid;
   }
    [self.navigationController pushViewController:attent animated:YES];

}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
