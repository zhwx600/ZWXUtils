//
//  ZWXMenuBar.m
//  AAActivityActionDemo
//
//  Created by zhwx on 14-11-27.
//  Copyright (c) 2014年 r-plus. All rights reserved.
//

#import "ZWXMenuBar.h"


//屏幕宽高
#define SCREEN_MAX_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_MAX_WIDTH [UIScreen mainScreen].bounds.size.width

//------------------------- 限制 固定值 -------------------------
#define  MaxRowCount 3  //最大3行 （最大列数 依计算 而定）
#define  ItemSize 57.0  //每个按钮大小。 高度是 （ItemSize + 20(label)）
#define ItemSizeHeight 30.0
#define  TitleNeedHeight 30.0
#define  CancleNeedHeight 50.0
//固定的 【行】 间距 （上下）
const CGFloat  kItemRowSpace = 10.0;
//上下 左右边距设置
const CGFloat kPanelViewTopMargin = 0.0f;
const CGFloat kPanelViewBottomMargin = 0.0f;
const CGFloat kPanelViewLeftMargin = 18.0f;
const CGFloat kPanelViewRightMargin = 18.0f;

const double  kAnimateWithDuration = 0.35;//动画时间

//------------------ 列间距 会根据 每行的个数 计算 -------------------------
const CGFloat  kItemMinColoumnSpace = 15.0;  //最小的列间距值 （左右）





@interface ZWXMenuBarItem()
{
    UIButton* _button;
    UILabel* _label;
}

//标题
@property (nonatomic,copy)NSString* o_title;
//按钮 图片
@property (nonatomic, strong) UIImage *o_image;
@property (nonatomic, strong) UIImage *o_selectImage;


/**
 * 点击事件的 block
 */
@property (nonatomic, copy) ZWXMenuBarItemClickBlcok o_clickBlock;


@end


@implementation ZWXMenuBarItem

-(id) initWithTitle:(NSString *)title image:(UIImage *)image selectedImage:(UIImage *)selectedImage userInfo:(id)userInfo clickBolck:(ZWXMenuBarItemClickBlcok)block
{
    CGRect frame = CGRectZero;
    if (self = [super init]) {
        
        _o_title = title;
        _o_image = image;
        _o_selectImage = selectedImage;
        
        _o_userInfo = userInfo;
        _o_clickBlock = block;
        
        [self setFrame:frame];
        
        
        _button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0,frame.size.width, frame.size.width)];
        [_button setBackgroundImage:_o_image forState:UIControlStateNormal];
        [_button setBackgroundImage:_o_selectImage forState:UIControlStateHighlighted];
        [_button setShowsTouchWhenHighlighted:YES];
        [_button addTarget:self action:@selector(clickUp:) forControlEvents:UIControlEventTouchUpInside];
        [_button setExclusiveTouch:YES];
        
        _label = [[UILabel alloc] initWithFrame:CGRectMake(0, frame.size.height, frame.size.width, 20)];
        _label.backgroundColor = [UIColor clearColor];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.text = _o_title;
        _label.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
        _label.font = [UIFont systemFontOfSize:13.0];
        
        [self addSubview:_button];
        [self addSubview:_label];
        self.backgroundColor = [UIColor clearColor];
        
    }
    
    return self;
}

-(NSString*) title
{
    return self.o_title;
}

-(void)layoutSubviews
{
    [_button setFrame:CGRectMake(0, 0,self.frame.size.width, self.frame.size.width)];
    [_label setFrame:CGRectMake(-5, self.frame.size.width+5, self.frame.size.width+10, 20)];
}

-(void) clickUp:(id)sender
{
    if (_o_dismissBlock) {
        _o_dismissBlock();
    }
    if (_o_clickBlock) {
        _o_clickBlock(self ,self.tag);
    }
}


-(void)setO_image:(UIImage *)o_image
{
    _o_image = o_image;
    [_button setBackgroundImage:_o_image forState:UIControlStateNormal];
}

-(void) setO_selectImage:(UIImage *)o_selectImage
{
    _o_selectImage = o_selectImage;
    [_button setBackgroundImage:_o_selectImage forState:UIControlStateHighlighted];
}

-(void) setO_title:(NSString *)o_title
{
    _o_title = o_title;
    [_label setText:_o_title];
}

-(void) dealloc
{
    //    NSLog(@"%s",__func__);
}
@end





@interface ZWXMenuBar()<UIScrollViewDelegate>
{
    UIPageControl* _pageControl;
    UIScrollView*  _scrollView;
    UILabel* _titleLabel;
    UIButton* _cancelButton;
    
    NSInteger      _pages;//总页数
    
    CGFloat      _realColoumnSpace;//实际列 间距
    CGFloat      _realRowSpace;//实际行 间距
    
    CGFloat      _realRows; // 实际行数
    CGFloat      _realColoumns; //实际列数
    
    BOOL _isShowing;//是否显示状态
    
    UIView *_panelView;//容器 View。 SubView is scrollview、pageControl、cancelbUTTON;
    
    
}

@end


@implementation ZWXMenuBar


/**
 * 用 ZWXMenuBarItem 数组 初始化
 */
-(id)init
{
    //    CGRect frame = CGRectMake(0, 0, SCREEN_MAX_HEIGHT, 0);
    
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        // Initialization code
        
        
    }
    return self;
}

-(void)clearSubViews{
    
    while (self.subviews.count) {
        UIView* child = self.subviews.lastObject;
        [child removeFromSuperview];
    }
}

-(void) setO_items:(NSMutableArray *)o_items
{
    _o_items = [NSMutableArray arrayWithArray:o_items];
    
    //计算一行多少列
    _realColoumns = [self numberOfItemInRow];
    
    //计算多少行数
    _realRows = [self numberOfItemInColoumn];
    
    if (_realColoumns * _realRows <= 0) {
        _pages = 0;
    }else{
        _pages = (_o_items.count / (_realRows*_realColoumns)) + (_o_items.count % (int)(_realRows*_realColoumns) >0? 1 : 0);
    }
    
    [self clearSubViews];
    
    [self initSubView];
}



-(void) initSubView
{
    CGFloat scrollerHeight = [self getPanelViewHeight];
    CGFloat height = scrollerHeight + TitleNeedHeight + CancleNeedHeight;
    _panelView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-height , SCREEN_MAX_WIDTH, height)];
    _panelView.backgroundColor = [UIColor whiteColor];
    _panelView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin);
    _panelView.backgroundColor = [UIColor whiteColor];
    
    
    [self addSubview:_panelView];
    
    //背景
    //    UIImageView* tImageView = [[UIImageView alloc] initWithImage:backImage];
    //    tImageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    //    [self addSubview:tImageView];
    
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, TitleNeedHeight, _panelView.frame.size.width, scrollerHeight)];
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    [_scrollView setShowsHorizontalScrollIndicator:NO];
    [_scrollView setShowsVerticalScrollIndicator:NO];
    
    [_panelView addSubview:_scrollView];
    
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_scrollView.frame) - 15, _panelView.frame.size.width, 10)];
    _pageControl.numberOfPages = _pages;
    _pageControl.currentPage = 5;
    [_pageControl addTarget:self action:@selector(pageChange:) forControlEvents:UIControlEventValueChanged];
    _pageControl.backgroundColor =  [UIColor clearColor];
    [_panelView addSubview:_pageControl];
    
    if (_pages > 1) {
        [_scrollView setScrollEnabled:YES];
        [_pageControl setHidden:NO];
        _scrollView.contentSize = CGSizeMake(_pages * _scrollView.frame.size.width,0);
    }else{
        [_scrollView setScrollEnabled:NO];
        [_pageControl setHidden:YES];
    }
    _scrollView.backgroundColor = [UIColor clearColor];
    
    
    for (NSInteger page = 0; page<_pages; page++) {
        
        for (NSInteger index=page*(_realRows*_realColoumns); index<(page+1)*(_realRows*_realColoumns); index++) {
            
            if(index == _o_items.count)
                break;
            ZWXMenuBarItem* item = [_o_items objectAtIndex:index];
            item.tag = index;
            //            __weak ZWXMenuBar* __myself = self;
            item.o_dismissBlock = ^{
                
            };
            
            NSInteger relativeIndex = index - (page * (_realRows*_realColoumns));
            NSInteger row = relativeIndex/_realColoumns;
            NSInteger coloumn = (relativeIndex % (int)_realColoumns);
            
            CGFloat x = 0;
            //最大列数为 《= 1
            if (_realColoumns <= 1) {
                x = (page * _panelView.frame.size.width) + (_panelView.frame.size.width - ItemSize)/2.0;
            }else{
                x =  (page * _panelView.frame.size.width) + kPanelViewLeftMargin + ((ItemSize+_realColoumnSpace)*coloumn);
            }
            
            CGFloat y = kPanelViewTopMargin + ((ItemSize + ItemSizeHeight +_realRowSpace)*row);
            
            item.frame = CGRectMake(x, y, ItemSize, ItemSize+ItemSizeHeight);
            [item setNeedsLayout];
            [_scrollView addSubview:item];
            
        }
        
    }
    
    [self panelAddTitleLabel];
    
    [self panelAddCancelButton];
    
    [self panelIssueButton];
}

- (void)setO_menuTitle:(NSString *)o_menuTitle{
    _o_menuTitle = o_menuTitle;
    _titleLabel.text = o_menuTitle;
}
#pragma mark- 计算
/**
 * 计算 一页的 最大行数
 */
-(NSUInteger) getPanelViewHeight
{
    return kPanelViewTopMargin + kPanelViewBottomMargin + _realRowSpace*(_realRows -1) + (ItemSize+ItemSizeHeight)*_realRows;
}



/**
 * 计算 一页的 最大行数
 */
-(NSUInteger)numberOfItemInColoumn
{
    
    NSInteger totalRows = (int)_o_items.count/(int)_realColoumns + (int)((_o_items.count%(int)_realColoumns)>0?1:0);
    
    NSInteger onePageRow = 0;
    //小于一样得最大行数 则返回行数
    if (totalRows <= MaxRowCount) {
        onePageRow = totalRows;
    }else{
        onePageRow = MaxRowCount;
    }
    
    //计算出实际 的间隔
    _realRowSpace = kItemRowSpace;
    
    return onePageRow;
    
}


/**
 * 计算 一页的 最大列数
 */
- (NSUInteger)numberOfItemInRow
{
    CGFloat frameWidth = self.frame.size.width;
    
    NSInteger coloumnNumber = 0;
    for (NSInteger i=1; i<100; i++) {
        
        CGFloat tWidth = (ItemSize)*i + (i-1)*kItemMinColoumnSpace + kPanelViewLeftMargin + kPanelViewRightMargin;
        
        //循环检测  item 一样最多容纳的个数
        if (tWidth > frameWidth) {
            coloumnNumber = i-1;
            break;
        }else{
            
        }
    }
    
    if (coloumnNumber > 1) {
        //计算出实际 的间隔
        _realColoumnSpace = (frameWidth - (coloumnNumber*ItemSize) - kPanelViewLeftMargin - kPanelViewRightMargin)/(coloumnNumber-1);
    }
    return coloumnNumber;
}



#pragma mark- page
-(void) pageChange:(UIPageControl*)aPageControl
{
    
    long whichPage = aPageControl.currentPage;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.2f];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    _scrollView.contentOffset = CGPointMake(_scrollView.frame.size.width * whichPage, 0.0f);
    [UIView commitAnimations];
    
}

- (void) scrollViewDidScroll: (UIScrollView *) aScrollView
{
    CGPoint offset = aScrollView.contentOffset;
    _pageControl.currentPage = offset.x / aScrollView.bounds.size.width;
    
    //    NSLog(@"offset x = %f  y = %f ,_pageControl.currentPage = %ld",offset.x,offset.y,_pageControl.currentPage);
    
}



#pragma mark Appearence

- (void)show
{
    // for keyboard overlay.
    // But not perfect fix for all case.
    UIWindow *keyboardWindow = [UIApplication sharedApplication].keyWindow;
    //    for (UIWindow *testWindow in [UIApplication sharedApplication].windows) {
    //        if (![[testWindow class] isEqual:[UIWindow class]]) {
    //            keyboardWindow = testWindow;
    //            break;
    //        }
    //    }
    //
    //    UIView *topView = [[UIApplication sharedApplication].keyWindow.subviews firstObject];
    
    [self showInView:keyboardWindow];
}

- (void)showInView:(UIView *)view
{
    //移至隐藏处
    CGRect nFrame = _panelView.frame;
    nFrame.origin.y = SCREEN_MAX_HEIGHT;
    _panelView.frame = nFrame;
    
    //添加在制定的view 上
    self.frame = view.bounds;
    [view addSubview:self];
    _isShowing = YES;
    
    [UIView animateWithDuration:kAnimateWithDuration animations:^ {
        [self addMaskView];
        //            _panelView.transform = CGAffineTransformIdentity;
        CGRect nFrame = self->_panelView.frame;
        nFrame.origin.y = SCREEN_MAX_HEIGHT - nFrame.size.height;
        self->_panelView.frame = nFrame;
        
    }];
    
}

- (void)dismiss:(BOOL)remove
{
    if (_isShowing) {
        [UIView animateWithDuration:kAnimateWithDuration animations:^ {
            //            _panelView.transform = CGAffineTransformMakeScale(1.0, 0.2);
            CGRect nFrame = self->_panelView.frame;
            nFrame.origin.y = SCREEN_MAX_HEIGHT;
            self->_panelView.frame = nFrame;
        } completion:^ (BOOL finished){
            if (remove) {
                [self removeFromSuperview];
            }
        }];
        _isShowing = NO;
    }
}

- (void)maskDismiss{
    [self dismiss:YES];
}

- (void)maskIssue{
    //子类实现
}
#pragma mark- 附加 属性 VIEW
-(void) addMaskView
{
    UIControl *baseView = [[UIControl alloc] initWithFrame:self.frame];
    baseView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.3];
    [baseView addTarget:self action:@selector(maskDismiss) forControlEvents:UIControlEventTouchUpInside];
    
    baseView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    [self addSubview:baseView];
    [self sendSubviewToBack:baseView];
    
    
}

- (void) panelAddTitleLabel
{
    //忽略标题
    //    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(25, 0, 270, TitleNeedHeight)];
    //    _titleLabel.backgroundColor = [UIColor clearColor];
    //    _titleLabel.font = [UIFont boldSystemFontOfSize:16];
    //    _titleLabel.textColor = RGB(102, 102, 102);
    //    _titleLabel.textAlignment = NSTextAlignmentCenter;
    //    _titleLabel.text = _o_menuTitle;
    //    [_panelView addSubview:_titleLabel];
    
}

- (void) panelAddCancelButton
{
    double screenWidth = [[UIScreen mainScreen] bounds].size.width;
    _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _cancelButton.frame = CGRectMake(25, CGRectGetMaxY(_scrollView.frame) , screenWidth - 25 * 2, 40);
    //    _cancelButton.backgroundColor = RGB(233, 231, 231);
    //    [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [_cancelButton setImage:[UIImage imageNamed:@"wxfx_fx_close.png"] forState:UIControlStateNormal];
    //    [_cancelButton setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
    //    [_cancelButton setBackgroundImage:[UIImage imageNamed:@"platform_cart_close_btn"] forState:UIControlStateNormal];
    [_cancelButton addTarget:self action:@selector(maskDismiss) forControlEvents:UIControlEventTouchUpInside];
    [_panelView addSubview:_cancelButton];
    
}
- (void) panelIssueButton
{
    //忽略温馨提示
    //    UIButton * issueButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //    issueButton.frame = CGRectMake(SCREEN_WIDTH - 50, 5 , 40, 40);
    //    [issueButton setImage:[UIImage imageNamed:@"icon_question_blog_share"] forState:UIControlStateNormal];
    //    [issueButton addTarget:self action:@selector(maskIssue) forControlEvents:UIControlEventTouchUpInside];
    //    [_panelView addSubview:issueButton];
    
}


-(void) dealloc
{
    //    NSLog(@"%s",__func__);
}

@end
