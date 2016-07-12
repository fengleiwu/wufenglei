//
//  ChatViewController.m
//  EMDemo
//
//  Created by lanou on 16/7/6.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "ChatViewController.h"
#import <EMSDK.h>
@interface ChatViewController ()<EMChatManagerDelegate,UITableViewDataSource,UITableViewDelegate,UITextViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic , strong)EMConversation *conversation;
@property (nonatomic , strong)NSMutableArray *conversationlists;//保存会话
@property (nonatomic , strong)UITextView *myTextView;
@end
@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.tabBarController.tabBar.hidden = YES;
    self.title = _chatter;
   _conversation = [[EMClient sharedClient].chatManager getConversation:_chatter type:EMConversationTypeChat createIfNotExist:YES];
    [self sortConversations];
    [[EMClient sharedClient].chatManager addDelegate:self delegateQueue:nil];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    
    //键盘将要出来
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyBoardShow:) name:UIKeyboardWillShowNotification object:nil];
    //键盘将要消失
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyBoardHide:) name:UIKeyboardWillHideNotification object:nil];
    [self.view addSubview:self.myTextView];
    
    
    // Do any additional setup after loading the view.
}

-(UITextView *)myTextView
{
    if (!_myTextView) {
        _myTextView = [[UITextView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height - 100, self.view.frame.size.width, 40)];
        _myTextView.backgroundColor = [UIColor orangeColor];
        _myTextView.delegate = self;
        _myTextView.returnKeyType = UIReturnKeySend;
        

    }
    return _myTextView;
}

//键盘出现
-(void)keyBoardShow:(NSNotification *)note
{
    //UIKeyboardAnimationDurationUserInfoKey 动画时间
    //UIKeyboardFrameEndUserInfoKey 键盘出现后的位置
    //note.userInfo[UIKeyboardAnimationDurationUserInfoKey];
    CGRect newRect = [note.userInfo[UIKeyboardFrameEndUserInfoKey]CGRectValue];
    [UIView animateWithDuration:[note.userInfo [UIKeyboardAnimationDurationUserInfoKey]floatValue] animations:^{
        self.myTextView.transform = CGAffineTransformMakeTranslation(0, -newRect.size.height - self.myTextView.frame.size.height + 100);
    }];
    NSLog(@"键盘出来了");
    NSLog(@"%@",note);
}

//键盘消失
-(void)keyBoardHide:(NSNotification *)note
{
    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey]floatValue] animations:^{
        self.myTextView.transform = CGAffineTransformIdentity;
        
    } completion:^(BOOL finished) {
        self.myTextView.text = @"";
    }];
}

#pragma mark---textViewDelegate
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        //上传
        [self sendMessage:textView.text];
        textView.text = nil;
        return NO;
    }
    return YES;
}



-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.myTextView resignFirstResponder];
}


-(void)viewWillAppear:(BOOL)animated
{
    [[EMClient sharedClient].chatManager removeDelegate:self];
}

-(NSMutableArray *)conversationlists
{
    if (!_conversationlists) {
        _conversationlists = [NSMutableArray array];
    }
    return _conversationlists;
}

#pragma mark ---按时间获取会话数据并排序
-(void)sortConversations{
    [self.conversationlists removeAllObjects];
    NSArray *myConversations = [_conversation loadMoreMessagesWithType:EMMessageBodyTypeText before:-1 limit:-1 from:[[EMClient sharedClient]currentUsername] direction:EMMessageSearchDirectionUp];
    NSArray *chatterConversations = [_conversation loadMoreMessagesWithType:EMMessageBodyTypeText before:-1 limit:-1 from:_chatter direction:EMMessageSearchDirectionUp];
    [self.conversationlists addObjectsFromArray:myConversations];
    [self.conversationlists addObjectsFromArray:chatterConversations];
    if (self.conversationlists.count == 0) {
        return;
    }
    for (NSInteger i = 0; i < self.conversationlists.count - 1; i++) {
        for (NSInteger j = 0; j < self.conversationlists.count - 1 - i; j++) {
            EMMessage *one = self.conversationlists[j];
            EMMessage *two = self.conversationlists[j + 1];
            if (one.timestamp > two.timestamp) {
                [self.conversationlists exchangeObjectAtIndex:j withObjectAtIndex:j + 1];
            }
        }
    }
    [_tableView reloadData];
}

#pragma mark ---发送消息
-(void)sendMessage:(NSString *)text
{
    EMTextMessageBody *body = [[EMTextMessageBody alloc]initWithText:text];
    EMMessage *message = [[EMMessage alloc]initWithConversationID:_chatter from:[[EMClient sharedClient]currentUsername] to:_chatter body:body ext:nil];
    [[EMClient sharedClient].chatManager asyncSendMessage:message progress:^(int progress) {
        } completion:^(EMMessage *message, EMError *error) {
        if (!error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self sortConversations];
            });
        }else{
            NSLog(@"%d",error.code);
        }
    }];
}

#pragma mark --- 接收消息
-(void)didReceiveMessages:(NSArray *)aMessages
{
    [self sortConversations];
    
}


#pragma mark ---tableViewSources
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.conversationlists.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"chatcell" forIndexPath:indexPath];
    EMMessage *message = self.conversationlists[indexPath.row];
    EMTextMessageBody *body = (EMTextMessageBody *)message.body;
    cell.textLabel.text = body.text;
    if ([message.from isEqualToString:[[EMClient sharedClient]currentUsername]]) {
        cell.textLabel.textColor = [UIColor redColor];
    }
    
    return cell;
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
