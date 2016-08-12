# TSScrollBtnView
a slide view used to give you a more button list
#####1.what is the TSScrollBtnView 
这是一个顶部导航工具栏，这个工具栏可以实现滚动和对界面的翻页控制</br>
This is a top navigation tools，we can use the tools to Turn the page</br>
#####2.how to use it  如何使用它
######init  初始化
```Objective-C
+ (instancetype)scrollBtnViewWithnameArray:(NSArray *)nameArray;
```
######config your scrollView  配置滚动视图
```Objective-C
NSArray * nameArray=@[@"001",@"002",@"003",@"004",@"005",@"006",@"007",@"008",@"009",@"010"];
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
self.scrollBtnView.pageNow=(scrollView.contentOffset.x+100)/([UIScreen mainScreen].bounds.size.width);
}
```
######use the delegate  使用代理方法
```
- (void)TSScrollBtnTouchWithIndex:(NSInteger)index
{
NSLog(@"%lu",index);
self.scrollView.contentOffset=CGPointMake([UIScreen mainScreen].bounds.size.width*index, 0);
}

- (void)TSScrollBtnMenuTouchGetView:(UIView *)menuView
{
[self.view addSubview:menuView];
}
```

`warining:` scrollview.pagingEnabled = YES;
#####3.show you the effect
 ![effect](https://github.com/TsnumiDC/TSScrollBtnView/blob/master/effect.gif)
#####4.how to contact me
Dylan</br>
[blog:blog.dylancc.com](http://blog.dylancc.com)
