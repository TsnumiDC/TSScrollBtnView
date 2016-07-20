//
//  ViewController.m
//  TSScrollBtnDemo
//
//  Created by Dylan on 7/20/16.
//  Copyright © 2016 Dylan. All rights reserved.
//
#define RGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define RandColor RGBColor(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255))

#import "ViewController.h"
#import "TSScrollBtnView.h"

@interface ViewController ()<TSScrollBtnDelegate,UIScrollViewDelegate>
//save the scrollBtnView
@property (strong,nonatomic)TSScrollBtnView * scrollBtnView;

@property (strong,nonatomic)UIScrollView * scrollView;
@end

@implementation ViewController
- (UIScrollView *)scrollView
{
    if (_scrollView==nil) {
        _scrollView=[[UIScrollView alloc]initWithFrame:self.view.bounds];
        _scrollView.pagingEnabled=YES;
        _scrollView.backgroundColor=[UIColor blackColor];
        _scrollView.delegate=self;
    }
    return _scrollView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.scrollView];
    
    //titleArray
    NSArray * nameArray=@[@"001",@"002",@"003",@"004",@"005",@"006",@"007",@"008",@"009",@"010"];
    //init
    TSScrollBtnView * scrollBtnView = [TSScrollBtnView scrollBtnViewWithnameArray:nameArray];
    self.scrollBtnView=scrollBtnView;
    //addSubView
    [self.view addSubview:scrollBtnView];
    //delegate
    scrollBtnView.delegate=self;
    
    
    self.scrollView.contentSize=CGSizeMake(nameArray.count*[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    for (int i=0; i<nameArray.count; i++)
    {
        UIView * pageView=[UIView new];
        pageView.frame=CGRectMake([UIScreen mainScreen].bounds.size.width*i, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        pageView.backgroundColor= RandColor;
        UILabel * titleLabel=[UILabel new];
        [pageView addSubview:titleLabel];
        titleLabel.frame=CGRectMake(100, 100, 100, 100);
        titleLabel.text=[NSString stringWithFormat:@"page %d",i];
        [self.scrollView addSubview:pageView];
    }
}

#pragma mark TSScrollBtnDelegate
- (void)TSScrollBtnTouchWithIndex:(NSInteger)index
{
    NSLog(@"%lu",index);
    self.scrollView.contentOffset=CGPointMake([UIScreen mainScreen].bounds.size.width*index, 0);
}

- (void)TSScrollBtnMenuTouchGetView:(UIView *)menuView
{
    [self.view addSubview:menuView];
}

#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.scrollBtnView.pageNow=(scrollView.contentOffset.x+100)/([UIScreen mainScreen].bounds.size.width);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
