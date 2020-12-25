//
//  PropretyAnimationVC.m
//  CoreAnimation Demo
//
//  Created by JJ.Liu's mbp on 2020/12/25.
//

#import "PropretyAnimationVC.h"

@interface PropretyAnimationVC ()<CAAnimationDelegate>

@property(nonatomic, strong) CALayer *colorLayer;
@property(nonatomic, strong) UIButton *changeButton;
@property(nonatomic, strong) UIButton *changeButton2;
@end

@implementation PropretyAnimationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.colorLayer = [CALayer layer];
    self.colorLayer.frame = CGRectMake(50.0f, 50.0f, 100.0f, 100.0f);
    self.colorLayer.backgroundColor = [UIColor blueColor].CGColor;
    [self.view.layer addSublayer:self.colorLayer];
    
    self.changeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.changeButton.frame = CGRectMake(0, 100, 100, 50);
    [self.changeButton setTitle:@"改变颜色" forState:UIControlStateNormal];
    [self.view addSubview:self.changeButton];
    
    [self.changeButton addTarget:self action:@selector(changeColor) forControlEvents:UIControlEventTouchUpInside];
    
    self.changeButton2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.changeButton2.frame = CGRectMake(300, 100, 200, 50);
    [self.changeButton2 setTitle:@"关键帧动画改变颜色" forState:UIControlStateNormal];
    [self.view addSubview:self.changeButton2];
    
    [self.changeButton2 addTarget:self action:@selector(keyFrame) forControlEvents:UIControlEventTouchUpInside];

}

- (void)changeColor
{
//    //create a new random color
//    CGFloat red = arc4random() / (CGFloat)INT_MAX;
//    CGFloat green = arc4random() / (CGFloat)INT_MAX;
//    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
//    UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
//
//    //create a basic animation
//    CABasicAnimation *animation = [CABasicAnimation animation];
//    animation.keyPath = @"backgroundColor";
//    animation.toValue = (__bridge id)color.CGColor;
//    animation.delegate = self;
//
//    //apply animation to layer
//    [self.colorLayer addAnimation:animation forKey:nil];
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    // 设置动画属性
    animation.keyPath = @"backgroundColor";
    // 动画执行时间
    animation.duration = 2.0;
    // 一个对象数组，指定要用于动画的关键帧值
    animation.values = @[
                        (__bridge id)[UIColor blueColor].CGColor,
                        (__bridge id)[UIColor redColor].CGColor,
                        (__bridge id)[UIColor greenColor].CGColor,
                        (__bridge id)[UIColor blueColor].CGColor];
    
    // CAMediaTimingFunction 表示函数的一个片段，该片段将动画的节奏定义为时间曲线。
    CAMediaTimingFunction *fn = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    // timingFunctions：可选的对象数组，用于定义每个关键帧段的步调
    animation.timingFunctions = @[fn, fn, fn];
    [self.colorLayer addAnimation:animation forKey:nil];
    
}

- (void)keyFrame{
    // 关键帧动画
    CAKeyframeAnimation *animati = [CAKeyframeAnimation animation];
    animati.keyPath = @"backgroundColor";
    animati.duration = 2.0;
    animati.values = @[(__bridge id)[UIColor blueColor].CGColor,
                       (__bridge id)[UIColor redColor].CGColor,
                       (__bridge id)[UIColor greenColor].CGColor,
                       (__bridge id)[UIColor blueColor].CGColor];
    [self.colorLayer addAnimation:animati forKey:nil];
}

- (void)animationDidStop:(CABasicAnimation *)anim finished:(BOOL)flag{
    [CATransaction begin];
    // 关闭隐式动画
    [CATransaction setDisableActions:YES];
    /*
     kCAMediaTimingFunctionLinear 创建了一个线性的计时函数
     kCAMediaTimingFunctionEaseIn 创建了一个慢慢加速然后突然停止的方法
     kCAMediaTimingFunctionEaseOut 全速开始，慢慢减速停止
     kCAMediaTimingFunctionEaseInEaseOut 慢慢加速，再慢慢减速
     kCAMediaTimingFunctionDefault 和kCAMediaTimingFunctionEaseInEaseOut类似，但是加速和减速的过程都稍微有些缓慢
     */
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    self.colorLayer.backgroundColor = (__bridge CGColorRef)anim.toValue;
    [CATransaction commit];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
