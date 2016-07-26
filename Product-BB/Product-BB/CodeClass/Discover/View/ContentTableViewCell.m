//
//  ContentTableViewCell.m
//  Product-BB
//
//  Created by lanou on 16/7/14.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "ContentTableViewCell.h"

@implementation ContentTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 100, 40)];
        self.contentLabel.font = [UIFont systemFontOfSize:17];
        self.contentLabel.text = @"内容简介";
        self.contentTextView = [[UILabel alloc]initWithFrame:CGRectMake(5, 40, kScreenWidth - 10, 100)];
        //self.contentTextView.scrollEnabled = YES;
        self.contentTextView.font = [UIFont systemFontOfSize:14];
        self.contentTextView.numberOfLines = 0;
        self.contentTextView.textAlignment = NSTextAlignmentLeft;
        self.moreBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.moreBtn.frame = CGRectMake(5, 150, kScreenWidth - 10, 40);
        [self.moreBtn setTitle:@"查看更多内容" forState:(UIControlStateNormal)];
        self.moreBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.moreBtn];
        [self.contentView addSubview:self.contentLabel];
        [self.contentView addSubview:self.contentTextView];
}
    return self;
}

-(void)creatCell:(NSString *)url
{
    NSString *URL = @"http://mobile.ximalaya.com/mobile/v1/album?albumId=308981&device=iPhone&pageSize=20&source=5&statEvent=pageview%2Falbum%40266276&statModule=%E5%B0%8F%E7%BC%96%E6%8E%A8%E8%8D%90&statPage=tab%40%E5%8F%91%E7%8E%B0_%E6%8E%A8%E8%8D%90&statPosition=1&trackId=18143253";
    URL = [URL stringByReplacingOccurrencesOfString:@"albumId=308981" withString:[NSString stringWithFormat:@"albumId=%@",url]];
        [RequestManager requestWithUrlString:URL requestType:RequestGET parDic:nil finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        AlbumDetailModel *model = [AlbumDetailModel album:dic];
        self.contentTextView.text = model.intro;
        CGRect frame = self.contentView.frame;
        frame.size.height = [AdjustHeight adjustHeightByString:model.intro width:kScreenWidth - 10 font:14];
        
       //self.contentTextView.editable = NO;
            } error:^(NSError *error) {
//        NSLog(@"%@",error);
    }];
    
}


-(void)creatPayCell:(DetailPayModel *)model
{
    self.contentTextView.text = model.intro;
}


@end
