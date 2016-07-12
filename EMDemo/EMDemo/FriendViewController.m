//
//  FriendViewController.m
//  EMDemo
//
//  Created by lanou on 16/7/6.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "FriendViewController.h"
#import <EMSDK.h>
#import "ChatViewController.h"
@interface FriendViewController ()<UITableViewDataSource , UITableViewDelegate , EMContactManagerDelegate>
@property(nonatomic , strong)NSMutableArray *rosterLists;//好友
@property (strong, nonatomic) IBOutlet UITableView *tableView;
//ss
@end

@implementation FriendViewController

-(NSMutableArray *)rosterLists
{
    if (!_rosterLists) {
        _rosterLists = [NSMutableArray array];
    }
    return _rosterLists;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[EMClient sharedClient].contactManager addDelegate:self delegateQueue:nil];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[EMClient sharedClient].contactManager removeDelegate:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    EMError *error = nil;
    NSArray *userlist = [[EMClient sharedClient].contactManager getContactsFromServerWithError:&error];
    [self.rosterLists addObjectsFromArray:userlist];
    //self.tabBarController.tabBar.hidden = NO;
   // [self.rosterLists addObjectsFromArray:[[EMClient sharedClient].contactManager getContactsFromDB]];//从数据库获取
    // Do any additional setup after loading the view.
}

#pragma mark ---

-(void)didReceiveAgreedFromUsername:(NSString *)aUsername
{
    [self.rosterLists removeAllObjects];
    EMError *error = nil;
  NSArray *userlist = [[EMClient sharedClient].contactManager getContactsFromServerWithError:&error];
    [self.rosterLists addObjectsFromArray:userlist];
    //[self.rosterLists addObjectsFromArray:[[EMClient sharedClient].contactManager getContactsFromDB]];
    [_tableView reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.rosterLists.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ss" forIndexPath:indexPath];
    
    cell.textLabel.text = self.rosterLists[indexPath.row];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChatViewController *chatVC = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([ChatViewController class])];
    chatVC.chatter = self.rosterLists[indexPath.row];
    [self.navigationController pushViewController:chatVC animated:YES];
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
