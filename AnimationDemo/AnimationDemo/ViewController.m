//
//  ViewController.m
//  AnimationDemo
//
//  Created by JOE on 2017/9/13.
//  Copyright © 2017年 Hongyear Information Technology (Shanghai) Co.,Ltd. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController ()

@property (nonatomic,strong) UILabel *viewTest;
@property (nonatomic,strong) UIImageView *imgView;

@property (nonatomic,strong) UIView *star;
@property (nonatomic,strong) UIView *star1;
@property (nonatomic,strong) UIView *star2;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor blackColor];
    _viewTest = [[UILabel alloc] initWithFrame:CGRectMake(50, 20, 4, 4)];
    _viewTest.layer.cornerRadius = 2;
    _viewTest.layer.masksToBounds = YES;
    _viewTest.backgroundColor = [UIColor whiteColor];
    _viewTest.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_viewTest];
    [self movement_Animation:10 withView:_viewTest fromValuetoValue:CGPointMake(300, 480)];
    
    
    _star = [[UIView alloc] initWithFrame:CGRectMake(60, 150, 4, 4)];
    _star.backgroundColor = [UIColor whiteColor];
    _star.layer.cornerRadius = 2;
    _star.layer.masksToBounds = YES;
    [self.view addSubview:_star];
    //[self movement_Animation:6 withView:_star toValue: CGPointMake(300, 600)];
    [self opacityForever_Animation:2 withView:_star];
    
    _star1 = [[UIView alloc] initWithFrame:CGRectMake(70, 200, 4, 4)];
    _star1.backgroundColor = [UIColor whiteColor];
    _star1.layer.cornerRadius = 2;
    _star1.layer.masksToBounds = YES;
    [self.view addSubview:_star1];
    //[self movement_Animation:6 withView:_star1 toValue: CGPointMake(260, 500)];
    [self opacityForever_Animation:2 withView:_star1];
    
    _star2 = [[UIView alloc] initWithFrame:CGRectMake(90, 160, 4, 4)];
    _star2.backgroundColor = [UIColor whiteColor];
    _star2.layer.cornerRadius = 2;
    _star2.layer.masksToBounds = YES;
    [self.view addSubview:_star2];
    //[self movement_Animation:6 withView:_star1 toValue: CGPointMake(260, 500)];
    [self opacityForever_Animation:2 withView:_star2];
    
    
    _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(260, 100, 10, 10)];
    _imgView.backgroundColor = [UIColor whiteColor];
    _imgView.layer.cornerRadius = 5;
    _imgView.layer.masksToBounds = YES;
    [self.view addSubview:_imgView];
    [self ImageSpringWith:_imgView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/// 上下浮动的动画
- (void)ImageSpringWith:(UIView *)view  {
    [UIView animateWithDuration:0.5 animations:^{
        view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y + 10, 10, 10);
    }];
    
    [UIView animateWithDuration:0.5 delay:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y - 10, 10, 10);
    } completion:^(BOOL finished) {
        [self ImageSpringWith:view];
    }];
}

/// 永久闪烁的动画
- (void)opacityForever_Animation:(float)time withView:(UIView *)view {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.fromValue = [NSNumber numberWithFloat:1.0];
    animation.toValue = [NSNumber numberWithFloat:0.0];
    animation.autoreverses = YES;
    animation.duration = time;
    animation.repeatCount = FLT_MAX;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    
    [view.layer addAnimation:animation forKey:@"opacityForever"];
}

/// 移动动画
- (void)movement_Animation:(float)time withView:(UIView *)view fromValuetoValue:(CGPoint)point {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.duration = time;
    animation.repeatCount = FLT_MAX;
    animation.fromValue = [NSValue valueWithCGPoint:view.layer.position];
    animation.toValue = [NSValue valueWithCGPoint:point];
    
    [view.layer addAnimation:animation forKey:@"move-layer"];
}

/// 在视图中画一条线
-(void)drawACurvedLine
{
    UIGraphicsBeginImageContext(CGSizeMake(320, 460));
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, 3);
    CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
    //设置起点
    CGContextMoveToPoint(context, 10, 10);
    
    CGContextAddQuadCurveToPoint(context, 10, 450, 310, 450);
    //CGContextAddQuadCurveToPoint(context, 310, 10, 10, 10);
    
    //划线
    CGContextDrawPath(context, kCGPathStroke);
    
    //得到一个image 从目前的矢量上下文
    UIImage *curve = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView *curveView = [[UIImageView alloc]initWithImage:curve];
    curveView.frame = CGRectMake(1, 1, 320, 460);
    [curveView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:curveView];
}

@end
