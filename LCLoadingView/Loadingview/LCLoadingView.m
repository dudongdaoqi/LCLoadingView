//
//  LCLoadingView.m
// 
//
//  Created by lc on 12-8-13.
//  Copyright (c) 2012年 LC. All rights reserved.
//

#import "LCLoadingView.h"

#define AnimationTime  0.2

#define kDotSize                (CGSizeMake(0.45 * self.frame.size.width, 0.45 * self.frame.size.height))

#define LeftTopPosition         (CGPointMake(0, 0))
#define LeftTBottomPosition     (CGPointMake(0, 0.55 * self.frame.size.height))
#define RightBottomPosition     (CGPointMake(0.55 * self.frame.size.width, 0.55 * self.frame.size.height))
#define RightTopPosition        (CGPointMake(0.55 * self.frame.size.width, 0))

#define kDotColor               [UIColor colorWithRed:254/255.0 green:206/255.0 blue:221/255.0 alpha:1.0]

@interface LCLoadingView()

@property (retain, nonatomic) UIView *coverView;
@property (retain, nonatomic) UIView *dotView0,*dotView1,*dotView2;
@property (retain, nonatomic) NSArray *dotViews;
@property (assign, nonatomic) NSInteger dotIndex;
@property (retain, nonatomic) NSTimer *timer;
@end

@implementation LCLoadingView

@synthesize coverView = _coverView;
@synthesize dotView0 = _dotView0;
@synthesize dotView1 = _dotView1;
@synthesize dotView2 = _dotView2;
@synthesize dotViews = _dotViews;
@synthesize dotIndex = _dotIndex;
@synthesize timer = _timer;


- (void)dealloc
{
    [_coverView release];
    [_dotView0 release];
    [_dotView1 release];
    [_dotView2 release];
    [_dotViews release];
    [_timer release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.hidden = YES;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self initView];
}

- (void)initView
{
    self.clipsToBounds = YES;
    self.userInteractionEnabled = NO;
    
    _dotView0 = [[UIView alloc]initWithFrame:(CGRect){RightBottomPosition, kDotSize}];
    _dotView0.backgroundColor = kDotColor;
    [self addSubview:_dotView0];
    
    _dotView1 = [[UIView alloc]initWithFrame:(CGRect){LeftTBottomPosition, kDotSize}];
    _dotView1.backgroundColor = kDotColor;
    [self addSubview:_dotView1];
    
    _dotView2 = [[UIView alloc]initWithFrame:(CGRect){LeftTopPosition, kDotSize}];
    _dotView2.backgroundColor = kDotColor;
    [self addSubview:_dotView2];

    _dotViews = @[_dotView0, _dotView1, _dotView2];
    [_dotViews retain];
    _dotIndex = 0;
}

-(void)showView:(BOOL)show
{
    if (show)
    {
        self.hidden = NO;
        if (!_timer)
        {
            _timer = [NSTimer timerWithTimeInterval:AnimationTime target:self selector:@selector(beginAnimation) userInfo:nil repeats:YES];
            [[NSRunLoop mainRunLoop]addTimer:_timer forMode:NSRunLoopCommonModes];
        }
    }
    else
    {
        [_timer invalidate];
        _timer = nil;
        self.hidden = YES;
    }
    
}

-(void)beginAnimation
{
    [UIView animateWithDuration:AnimationTime delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        if (_dotViews.count > _dotIndex)
        {
            UIView *dotView = [_dotViews objectAtIndex:_dotIndex];
            [self moveDotViewToNextPosition:dotView];
            
            _dotIndex ++;
            _dotIndex = _dotIndex > 2 ? 0 : _dotIndex;
        }

        
    } completion:nil];
}

-(void)moveDotViewToNextPosition:(UIView*)dotView
{
    if (CGPointEqualToPoint(dotView.frame.origin, LeftTopPosition))
    {
        dotView.frame = (CGRect){LeftTBottomPosition, dotView.frame.size};
    }
    else if (CGPointEqualToPoint(dotView.frame.origin, LeftTBottomPosition))
    {
        dotView.frame = (CGRect){RightBottomPosition, dotView.frame.size};
    }
    else if (CGPointEqualToPoint(dotView.frame.origin, RightBottomPosition))
    {
        dotView.frame = (CGRect){RightTopPosition, dotView.frame.size};
    }
    else if (CGPointEqualToPoint(dotView.frame.origin, RightTopPosition))
    {
        dotView.frame = (CGRect){LeftTopPosition, dotView.frame.size};
    }
}

@end
