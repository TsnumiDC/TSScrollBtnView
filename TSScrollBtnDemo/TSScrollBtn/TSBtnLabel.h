//
//  TSBtnLabel.h
//
//  Created by Dylan on 15/12/24.
//  Copyright (c) 2015年 TS. All rights reserved.
//

/**   背景的高度    the height of backView     */
#define TSbackH 200.f
/**   背景的颜色    the color of backView      */
#define TSBackColor [UIColor yellowColor]
/**   每一个按钮的宽度   the width of button       */
#define TSBtnLableBtnW 80.f
/**   按钮的间距       the spide of every button    */
#define TSBtnLableSpide 10.f
/**   按钮的高度        the height of every button  */
#define TSBtnLableBtnH 40.f
/**   横向有几个按钮    the count of button in a line     */
#define HorizontalCount 4
/**   按钮选择后的颜色   the color of selected button      */
#define TSBtnSelectColor [UIColor redColor]
/**   字体大小      size of the title         */
#define TSBtnTitleFont 15


#import <UIKit/UIKit.h>
#import "TSScrollBtnView.h"

@class TSBtnLabel;//传入按钮名称数组，通过代理传出点击的按钮
@protocol TSBtnLabelDelegate <NSObject>

- (void)TSBtnLabelBtnTouch:(UIButton *)button;

@end

@interface TSBtnLabel : UIView

@property (nonatomic,copy)NSMutableArray * btnArray;

@property (nonatomic,strong)NSArray * nameArray;

@property (nonatomic,weak)id<TSBtnLabelDelegate>delegate;

@property (nonatomic,assign)NSInteger pageNow;

@end
