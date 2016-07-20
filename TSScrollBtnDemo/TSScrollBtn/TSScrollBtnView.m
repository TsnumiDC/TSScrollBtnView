//
//  TSScrollBtn.m
//  TSScrollBtn
//
//  Created by Dylan on 15/12/23.
//  Copyright (c) 2015年 TS. All rights reserved.
//


#import "TSScrollBtnView.h"
#import "TSBtnLabel.h"
@interface TSScrollBtnView ()<TSBtnLabelDelegate>
/**   底部滚动视图  the backView is a scrollView        */
@property (nonatomic,strong)UIScrollView * scrollView;
/**   右侧弹出视图  the view will show when we touch the menuBtn       */
@property (nonatomic,strong)TSBtnLabel * btnLabel;
/**   底部移动的小视图  the animation view at the bottom       */
@property (nonatomic,strong)UIView * animationView;
/**   右侧弹出视图    the button at right     */
@property (nonatomic,strong)UIButton * menuBtn;
/**  这个数组传入按钮  save all buttons        */
@property (nonatomic,strong)NSMutableArray * btnArray;
@end

@implementation TSScrollBtnView
#pragma mark lazy
- (UIButton *)menuBtn
{
    if (_menuBtn==nil) {
        _menuBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _menuBtn.frame=CGRectMake([UIScreen mainScreen].bounds.size.width-TSBtnW, 0, TSBtnW, TSScrwH);
        [_menuBtn setImage:[UIImage imageNamed:@"showItemView"] forState:UIControlStateNormal];
        [_menuBtn setImage:[UIImage imageNamed:@"closeItemView"] forState:UIControlStateSelected];
        [_menuBtn addTarget:self action:@selector(menuBtnTouch) forControlEvents:UIControlEventTouchUpInside];
    }
    return _menuBtn;
}

- (UIScrollView *)scrollView
{
    if (_scrollView==nil)
    {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ([UIScreen mainScreen].bounds.size.width-TSBtnW), TSScrwH)];
        _scrollView.showsHorizontalScrollIndicator=NO;
        _scrollView.showsVerticalScrollIndicator=NO;
    }
    return _scrollView;
}

- (NSMutableArray *)btnArray
{
    if (_btnArray == nil) {
        _btnArray =[NSMutableArray array];
    }
    return _btnArray;
}

- (UIView *)animationView
{
    if (_animationView==nil)
    {
        self.animationView=[[UIView alloc]initWithFrame:CGRectMake(TSBtnSpid, (TSScrwH-TSAnimationViewH), TSbtnW, TSAnimationViewH)];
        self.animationView.backgroundColor=TSAnimationColor;
    }
    return _animationView;
}

#pragma mark set
- (void)setNameArray:(NSArray *)nameArray
{
    self.scrollView.contentSize=CGSizeMake((TSBtnSpid+TSbtnW)*nameArray.count+TSBtnSpid, TSScrwH);
    int i = 0;
    for (NSString * title in nameArray)
    {
        UIButton * btn=[[UIButton alloc]init];
        [btn setTitle:title forState:UIControlStateNormal];
        btn.titleLabel.font=[UIFont systemFontOfSize:TSTitleFont];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:TSAnimationColor forState:UIControlStateSelected];
        CGFloat btnX=TSBtnSpid*(i+1)+TSbtnW*i;
        CGFloat btnY=0;
        btn.frame=CGRectMake(btnX, btnY, TSbtnW, TSScrwH);
        [self.scrollView addSubview:btn];
        btn.tag=1000+i;
        [btn addTarget:self action:@selector(btnTouch:) forControlEvents:UIControlEventTouchUpInside];
        i++;
        [self.btnArray addObject:btn];
    }
    [self.scrollView bringSubviewToFront:self.animationView];
    _nameArray=nameArray;
}

- (void)setPageNow:(NSInteger)pageNow
{
    //通过这个方法从主控制器获得当前被选择的按钮序号
    //get the pageNow
    for (UIButton * allBtn in self.btnArray)
    {
        allBtn.selected=NO;
        allBtn.userInteractionEnabled=YES;
        if ((allBtn.tag-1000)==pageNow)
        {
            allBtn.selected=YES;
            allBtn.userInteractionEnabled=NO;
        }
    }
    _pageNow=pageNow;
    //小红线的移动,并且使得选中的按钮位与屏幕中间
    //move the animationView
    __weak typeof(self) weakSelf= self;
    [UIView animateWithDuration:0.5 animations:^
    {
        CGFloat x=TSBtnSpid*(pageNow+1)+TSbtnW*pageNow;
        
        weakSelf.animationView.frame=CGRectMake(x, TSScrwH-TSAnimationViewH, TSbtnW, TSAnimationViewH) ;
    }];
    
    NSLog(@"%f,%f",self.animationView.frame.origin.x,self.frame.size.width/2);
    if (self.animationView.frame.origin.x>=self.frame.size.width/2)
    {
        [UIView animateWithDuration:0.5 animations:^
        {
            CGFloat x=weakSelf.animationView.frame.origin.x-(self.frame.size.width/2);
            
            weakSelf.scrollView.contentOffset=CGPointMake(x, 0);
        }];
    }
    else
    {
        [UIView animateWithDuration:0.5 animations:^{
            weakSelf.scrollView.contentOffset=CGPointMake(0, 0);
        }];
    }
}

+ (instancetype)scrollBtnViewWithnameArray:(NSArray *)nameArray
{
    TSScrollBtnView * scrollBtnView=[[TSScrollBtnView alloc]initWithFrame:CGRectZero];
    scrollBtnView.nameArray=nameArray;
    return scrollBtnView;
}

- (id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame])
    {
        self.frame=CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, TSScrwH);
        self.backgroundColor=[UIColor whiteColor];
        [self addSubview: self.scrollView];
        [self.scrollView addSubview:self.animationView];
        [self addSubview: self.menuBtn];
    }
    return self;
}

#pragma mark btnAction
- (void)menuBtnTouch
{
    //右侧按钮点击事件
    //如果是闭合状态，点击之后创建选择视图
    //the action of right menuBtn
    if(!self.menuBtn.selected)
    {
        TSBtnLabel * btnLable=[TSBtnLabel new];
        btnLable.nameArray=self.nameArray;
        btnLable.delegate=self;
        btnLable.pageNow=self.pageNow;
        NSLog(@"%ld",self.pageNow);
        [self.delegate TSScrollBtnMenuTouchGetView:btnLable];
        self.btnLabel=btnLable;
    }
    else
    {
        //如果是展开状态，移除
        [self.btnLabel removeFromSuperview];
    }
    self.menuBtn.selected=!self.menuBtn.selected;
}

- (void)btnTouch:(UIButton *)btn
{
    self.pageNow=(btn.tag-1000);
    if (btn.tag>=2000)
    {
        self.pageNow=(btn.tag-2000);
    }
    NSLog(@"btn.tag:%ld",self.pageNow);
    
    if (self.menuBtn.selected)
    {
        self.menuBtn.selected=NO;
        [self.btnLabel removeFromSuperview];
    }
    if (self.delegate)
    {
        [self.delegate TSScrollBtnTouchWithIndex:self.pageNow];
    }
}

- (void)TSBtnLabelBtnTouch:(UIButton *)button
{
    [self btnTouch:button];
}
@end
