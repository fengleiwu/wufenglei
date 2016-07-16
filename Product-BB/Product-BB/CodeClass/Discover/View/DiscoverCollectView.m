//
//  DiscoverCollectView.m
//  Product-BB
//
//  Created by lanou on 16/7/12.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "DiscoverCollectView.h"

@interface DiscoverCollectView()<UICollectionViewDataSource , UICollectionViewDelegate>
@property(nonatomic , strong)NSMutableArray *arr;
@property(nonatomic , strong)UICollectionView *collect;
@end

@implementation DiscoverCollectView

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


-(void)creatCollectView
{
    UICollectionViewFlowLayout *lay = [[UICollectionViewFlowLayout alloc]init];
    lay.itemSize = CGSizeMake((kScreenWidth - 40) / 3 , (kScreenWidth - 40) / 3 + 70);
    lay.minimumInteritemSpacing = 5;
    lay.minimumLineSpacing = 5;
    lay.sectionInset = UIEdgeInsetsMake(0, 5, 0, 5);
    
    self.collect = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) collectionViewLayout:lay];
    self.collect.delegate = self;
    self.collect.dataSource = self;
    self.collect.backgroundColor = [UIColor whiteColor];
    [self.collect registerClass:[DiscoverCollectionViewCell class] forCellWithReuseIdentifier:@"ss"];
    [self addSubview:self.collect];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DiscoverCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ss" forIndexPath:indexPath];
    focusImagesModel *model = self.arr[indexPath.row];
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
