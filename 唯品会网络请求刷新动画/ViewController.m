//
//  ViewController.m
//  唯品会网络请求刷新动画
//
//  Created by 刘强 on 15/11/26.
//  Copyright © 2015年 Honzon. All rights reserved.
//

#define MAIN_COLOR  ([UIColor colorWithRed:219/255.0 green:0 blue:88/255.0 alpha:1.0])
#define COLOR  ([UIColor colorWithRed:230/255.0 green:180/255.0 blue:214/255.0 alpha:1.0])
#define KSCRENSIZE  ([UIScreen mainScreen].bounds.size)
#define KSCREN_WIDTH    ([UIScreen mainScreen].bounds.size.width)
#define KSCREN_HEIGHT    ([UIScreen mainScreen].bounds.size.height)


#import "ViewController.h"

@interface ViewController ()
{
    UIView * _view1;
    UIView * _view2;
    UIView * _view3;
    CAShapeLayer *_shaperLayer;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
    UIButton * repeatButton  = [UIButton buttonWithType:UIButtonTypeCustom];
    repeatButton.frame = CGRectMake((KSCREN_WIDTH-60)/2,KSCREN_HEIGHT - 100 , 60, 20);
    [repeatButton setTitle:@"repeat" forState:UIControlStateNormal];
    [repeatButton setTitleColor:MAIN_COLOR forState:UIControlStateNormal];
    [repeatButton addTarget:self action:@selector(honzonViewAnimationRepeat) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:repeatButton];
    
    [self setUpView];
    [self setUpView2];
    [self setUpView3];
    [self beginAnimation];
    
}

- (void)setUpView{
    
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake((KSCREN_WIDTH - 40)/2, KSCREN_HEIGHT - 200, 40, 40)];
    //    view.backgroundColor = MAIN_COLOR;
    view.layer.cornerRadius = 20.0;
    view.layer.borderWidth = 1.0f;
    view.layer.borderColor = MAIN_COLOR.CGColor;
    view.transform = CGAffineTransformMakeScale(0.1, 0.1);
    _view1 = view;
    [self.view addSubview:view];
}
- (void)setUpView2{
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(1.0, 1.0, 38.0, 38.0)];
    view.backgroundColor = COLOR;
    view.layer.cornerRadius = 19.0;
    view.transform = CGAffineTransformMakeScale(0.1, 0.1);
    _view2 = view;
    [_view1 addSubview:view];
    
}
- (void)setUpView3{
    
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(1.0, 1.0, 38.0, 38.0)];
    view.backgroundColor = [UIColor whiteColor];
    view.layer.cornerRadius = 19.0;
    view.transform = CGAffineTransformMakeScale(0.0, 0.0);
    CAShapeLayer * shapeLayer1 = [CAShapeLayer layer];
    shapeLayer1.path = [self drawBezierPath].CGPath;
    shapeLayer1.fillColor = [UIColor clearColor].CGColor;
    shapeLayer1.strokeColor = [UIColor grayColor].CGColor;
    shapeLayer1.strokeStart = 0.0;
    shapeLayer1.strokeEnd = 1.0;
    
    _shaperLayer = [CAShapeLayer layer];
    _shaperLayer.path = [self drawBezierPath].CGPath;
    _shaperLayer.fillColor = [UIColor whiteColor].CGColor;
    _shaperLayer.strokeColor = MAIN_COLOR.CGColor;
    _shaperLayer.strokeStart = 0.0;
    _shaperLayer.strokeEnd = 0.0;
    
    _view3 = view;
    [view.layer addSublayer:shapeLayer1];
    [view.layer addSublayer:_shaperLayer];
    [_view1 addSubview:view];
}
- (UIBezierPath *)drawBezierPath
{
    UIBezierPath * path = [UIBezierPath bezierPath];
    path.lineWidth = 1.0;
    
    [path moveToPoint:CGPointMake(7, 13)];
    [path addLineToPoint:CGPointMake(11, 23)];
    [path addLineToPoint:CGPointMake(15, 13)];
    
    [path moveToPoint:CGPointMake(19, 11)];
    [path addArcWithCenter:CGPointMake(19, 11) radius:0.4 startAngle:M_PI endAngle:M_PI*3 clockwise:YES];
    [path moveToPoint:CGPointMake(19, 13)];
    [path addLineToPoint:CGPointMake(19, 24)];
    
    [path moveToPoint:CGPointMake(24, 28)];
    [path addLineToPoint:CGPointMake(24, 13)];
    [path moveToPoint:CGPointMake(25, 16)];
    [path addArcWithCenter:CGPointMake(29, 18) radius:5.0 startAngle:M_PI endAngle:M_PI*3 clockwise:YES];
    
    //    [path closePath];
    return path;
    
    
}
- (void)honzonViewAnimationRepeat
{
    _shaperLayer.strokeEnd = 0.0;
    _view2.transform = CGAffineTransformMakeScale(0.1, 0.1);
    _view3.transform = CGAffineTransformMakeScale(0.0, 0.0);
    [self beginAnimation];
}
- (void)beginAnimation
{
    [self view1BeginAnimation];
}

- (void)view1BeginAnimation
{
    _view1.transform = CGAffineTransformMakeScale(0.1, 0.1);
    [UIView animateWithDuration:2.0 animations:^{
        _view1.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
        [self view2BeginAnimation];
    }];
}

- (void)view2BeginAnimation
{
    
    [UIView animateWithDuration:2.0 animations:^{
        _view2.transform = CGAffineTransformMakeScale(1.0, 1.0);
        _view3.transform = CGAffineTransformMakeScale(0.1, 0.1);
    } completion:^(BOOL finished) {
        [self view3BeginAnimation];
    }];
}

- (void)view3BeginAnimation
{
    [UIView animateWithDuration:2.0 animations:^{
        _view3.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
        [self animateToProgress:1.0];
    }];
    
}

- (void)animateToProgress:(float)progress {
    [self stopAnimation];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.duration = 2.0;
    animation.fromValue = @(0.0);
    animation.toValue = @(progress);
    animation.delegate = self;
    [_shaperLayer addAnimation:animation forKey:@"kShapeViewAnimation"];
    
}

- (void)stopAnimation {
    [_shaperLayer removeAnimationForKey:@"kShapeViewAnimation"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    //    [self updateProgress:1.0];//最后的vip字样是否保持颜色
}


- (void)updateProgress:(float)progress {
    [CATransaction begin];
    [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
    _shaperLayer.strokeEnd = progress;
    [CATransaction commit];
}



@end
