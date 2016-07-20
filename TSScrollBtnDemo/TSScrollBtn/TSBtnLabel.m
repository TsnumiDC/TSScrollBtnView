//
//  TSBtnLabel.m
//  新浪新闻联系
//
//  Created by Dylan on 15/12/24.
//  Copyright (c) 2015年 TS. All rights reserved.
//

#import "TSBtnLabel.h"
@interface TSBtnLabel()
/**   背景视图   backView       */
@property (nonatomic,strong)UIView * backView;
@end
@implementation TSBtnLabel
#pragma  mark lazy
- (UIView *)backView
{
    if (_backView==nil) {
        _backView=[[UIView alloc]initWithFrame:CGRectMake(0, 64+TSScrwH, [UIScreen mainScreen].bounds.size.width, TSbackH)];
        _backView.backgroundColor=TSBackColor;
    }
    return _backView;
}

- (NSMutableArray *)btnArray
{
    if (_btnArray == nil) {
        _btnArray =[NSMutableArray array];
    }
    return _btnArray;
}

#pragma mark set
- (void)setNameArray:(NSArray *)nameArray
{
    int i = 0;
    int j = HorizontalCount;
    for (NSString * title in nameArray)
    {
        UIButton * btn=[[UIButton alloc]init];
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:TSBtnSelectColor forState:UIControlStateSelected];
        btn.backgroundColor=[UIColor whiteColor];
        CGFloat btnX=TSBtnLableSpide*(i%j+1)+TSBtnLableBtnW*(i%j);
        CGFloat btnY=(TSBtnLableBtnH+TSBtnLableSpide)*(i/j);
        btn.frame=CGRectMake(btnX, btnY, TSBtnLableBtnW, TSBtnLableBtnH);
        btn.frame=CGRectMake(btnX, btnY, TSBtnLableBtnW, TSBtnLableBtnH);
        [self.backView addSubview:btn];
         btn.tag=i+2000;
        [btn addTarget:self action:@selector(btnTouch:) forControlEvents:UIControlEventTouchUpInside];
        i++;
        [self.btnArray addObject:btn];

    }
    _nameArray=nameArray;
}

- (void)setPageNow:(NSInteger)pageNow
{
    for (UIButton * allBtn in self.btnArray) {
        allBtn.selected=NO;
        allBtn.userInteractionEnabled=YES;
        
        if ((allBtn.tag-2000)==pageNow)
        {
            allBtn.selected=YES;
            allBtn.userInteractionEnabled=NO;
        }
    }
}

- (id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        
        self.frame=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height);
        UIView * backgoudnView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        backgoudnView.backgroundColor=[UIColor darkGrayColor];
        [self addSubview:backgoudnView];
        backgoudnView.alpha=0.7;
        UITapGestureRecognizer * pan=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backViewAction)];
        pan.numberOfTapsRequired=1;
        [backgoudnView addGestureRecognizer:pan];
        [self addSubview:self.backView];
    }
    return self;
}

#pragma mark btnAction
- (void)btnTouch:(UIButton *)btn
{
    self.pageNow=(btn.tag-2000);
    if (self.delegate!=nil)
    {
        [self.delegate TSBtnLabelBtnTouch:btn];
    }
    [self removeFromSuperview];
}

- (void)backViewAction
{
    [self removeFromSuperview];
}


@end
