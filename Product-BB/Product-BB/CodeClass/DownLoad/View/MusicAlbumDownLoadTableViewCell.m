//
//  MusicAlbumDownLoadTableViewCell.m
//  Product-BB
//
//  Created by lanou on 16/7/19.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "MusicAlbumDownLoadTableViewCell.h"

@implementation MusicAlbumDownLoadTableViewCell

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
        self.imageV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 100, 100)];
        self.titleL = [[UILabel alloc]initWithFrame:CGRectMake(120, 10, kScreenWidth - 120 - 60, 40)];
        self.fuTitleL = [[UILabel alloc]initWithFrame:CGRectMake(120, 60, kScreenWidth - 120 - 60, 20)];
        self.fuTitleL.textColor = [UIColor grayColor];
        self.fuTitleL.font = [UIFont systemFontOfSize:15];
        self.btn1 = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.btn1.frame = CGRectMake(120, 90, 20, 20);
        [self.btn1 setImage:[UIImage imageNamed:@"audio_wave"] forState:(UIControlStateNormal)];
        [self.btn1 setTintColor:[UIColor grayColor]];
        self.numbelL = [[UILabel alloc]initWithFrame:CGRectMake(145, 90, 50, 20)];
        self.numbelL.font = [UIFont systemFontOfSize:12];
        self.numbelL.textColor = [UIColor grayColor];
        self.btn2 = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.btn2.frame = CGRectMake(210, 90, 20, 20);
        [self.btn2 setImage:[UIImage imageNamed:@"folder"] forState:(UIControlStateNormal)];
        [self.btn2 setTintColor:[UIColor grayColor]];
        self.fileL = [[UILabel alloc]initWithFrame:CGRectMake(235, 90, 50, 20)];
        self.fileL.font = [UIFont systemFontOfSize:12];
        self.fileL.textColor = [UIColor grayColor];
        self.rubbishBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.rubbishBtn.frame = CGRectMake(kScreenWidth - 40, 45, 30, 30);
        [self.rubbishBtn setImage:[UIImage imageNamed:@"trash"] forState:(UIControlStateNormal)];
        [self.rubbishBtn setTintColor:[UIColor grayColor]];
        [self.contentView addSubview:self.imageV];
        [self.contentView addSubview:self.titleL];
        [self.contentView addSubview:self.fuTitleL];
        [self.contentView addSubview:self.btn1];
        [self.contentView addSubview:self.numbelL];
        [self.contentView addSubview:self.btn2];
        [self.contentView addSubview:self.fileL];
        [self.contentView addSubview:self.rubbishBtn];
    }
    return self;
}

-(void)creatCell:(NSArray *)arr
{
    NSArray *arr1 = [arr lastObject];


    self.imageV.image = [UIImage imageWithData:arr1[9]];
    
    //[self.imageV sd_setImageWithURL:[NSURL URLWithString:arr1[9]]];
    self.titleL.text = arr1[10];
    self.fuTitleL.text = arr1[10];
    self.numbelL.text = [NSString stringWithFormat:@"%ld集",arr.count];
    
    
}



@end
