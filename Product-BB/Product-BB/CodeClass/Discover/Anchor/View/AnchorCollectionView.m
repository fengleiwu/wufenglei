//
//  AnchorCollectionView.m
//  Product-BB
//
//  Created by lanou on 16/7/16.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "AnchorCollectionView.h"


@interface AnchorCollectionView()<UICollectionViewDataSource , UICollectionViewDelegate>
@property(nonatomic , strong)NSMutableArray *arr;
@property(nonatomic , strong)UICollectionView *collect;


@end

@implementation AnchorCollectionView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(instancetype)initWithFrame:(CGRect)frame imageURLs:(NSMutableArray *)arrURLs
{
    self = [super initWithFrame:frame];
    if (self) {
        if (arrURLs.count == 0) {
            return nil;
        }
        self.arr = [NSMutableArray array];
        self.arr = arrURLs;
        [self creatCollectView];
    }
    return self;
}

-(UICollectionView *)collect

{
    if (!_collect) {
        UICollectionViewFlowLayout *lay = [[UICollectionViewFlowLayout alloc]init];
        lay.itemSize = CGSizeMake((kScreenWidth - 40) / 3 , (kScreenWidth - 40) / 3 + 100);
        lay.minimumInteritemSpacing = 5;
        lay.minimumLineSpacing = 5;
        lay.sectionInset = UIEdgeInsetsMake(0, 5, 0, 5);
        
        _collect = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, ((kScreenWidth - 40) / 3 + 100) * 2) collectionViewLayout:lay];
        _collect.delegate = self;
        _collect.dataSource = self;
        _collect.backgroundColor = [UIColor whiteColor];
        _collect.scrollEnabled = NO;
        [_collect registerClass:[AnchorCollectionViewCell class] forCellWithReuseIdentifier:@"ss"];
    }
    return _collect;
}

-(void)creatCollectView
{

    [self addSubview:self.collect];
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    AnchorCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ss" forIndexPath:indexPath];
    AnchorModel *model = self.arr[indexPath.row];
    [cell creatCell:model];
    
    return cell;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.arr.count;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.imageClick(indexPath.row);
}


@end
