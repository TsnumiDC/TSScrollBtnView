//
//  TSScrollBtn.h
//  TSScrollBtn
//
//  Created by Dylan on 15/12/23.
//  Copyright (c) 2015年 TS. All rights reserved.
//
/**   每个按钮的宽度     the width of every buttons    */
#define TSbtnW 60.f
/**   整个视图的高度     the height of  TSScrollBtnHeight   */
#define TSScrwH 30.f
/**   右侧弹出菜单按钮的宽度    width of menuBtn on the right     */
#define TSBtnW 50.f
/**   每个按钮的间距      spide betwoon every buttons   */
#define TSBtnSpid 10.f
/**   底部滚动视图的高度   height of animationView      */
#define TSAnimationViewH 3.f
/**   底部滚动视图的颜色（和文字颜色一样）   color of animaton view and title      */
#define TSAnimationColor [UIColor redColor]
/**   字体大小      size of the title         */
#define TSTitleFont 15


#import <UIKit/UIKit.h>
@class TSScrollBtnView;//传入按钮名称，通过代理传出选择视图与按钮号
@protocol TSScrollBtnDelegate <NSObject>
/**   传递点击的页数   trans the page we touched      */
- (void)TSScrollBtnTouchWithIndex:(NSInteger)index;
/**   传递右侧视图     trans the menuView to addSubview    */
- (void)TSScrollBtnMenuTouchGetView:(UIView *)menuView;

@end

@interface TSScrollBtnView : UIView
/**  这个数组传入标题    titleArray  save the buttons title     */
@property (nonatomic,strong)NSArray * nameArray;
/**   代理      delegate   */
@property (nonatomic,weak)id<TSScrollBtnDelegate> delegate;
/**   当前页数     the page of now    */
@property (nonatomic,assign)NSInteger pageNow;

/**   初始化方法，传入标题数组   the method used to init    */
+ (instancetype)scrollBtnViewWithnameArray:(NSArray *)nameArray;

@end



















