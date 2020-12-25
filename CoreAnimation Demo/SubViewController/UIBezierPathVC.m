//
//  UIBezierPathVC.m
//  CoreAnimation Demo
//
//  Created by JJ.Liu's mbp on 2020/12/25.
//

#import "UIBezierPathVC.h"

@interface UIBezierPathVC ()

@property(nonatomic, strong)CALayer *imageLayer;
@property(nonatomic, strong)UIBezierPath *bezierPath;

@end

@implementation UIBezierPathVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    _bezierPath = [[UIBezierPath alloc] init];
    // 将UIBezierPath对象的currentPoint移动到指定的点
    [_bezierPath moveToPoint:CGPointMake(0, 150)];
    
    // 在子路径中追加一条三次贝塞尔曲线
    [_bezierPath addCurveToPoint:CGPointMake(300, 150) controlPoint1:CGPointMake(75, 0) controlPoint2:CGPointMake(225, 300)];
    
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    // CAShapeLayer 绘制路径
    pathLayer.path = _bezierPath.CGPath;
    // 用于填充形状路径的颜色
    pathLayer.fillColor = [UIColor clearColor].CGColor;
    // 用户描绘形状路径的颜色
    pathLayer.strokeColor = [UIColor redColor].CGColor;
    // 指定形状路径的线宽
    pathLayer.lineWidth = 3.0f;
    [self.view.layer addSublayer:pathLayer];

    self.imageLayer = [CALayer layer];
    self.imageLayer.frame = CGRectMake(0, 0, 64, 64);
    self.imageLayer.position = CGPointMake(0, 150);
    self.imageLayer.contents = (__bridge id)[UIImage imageNamed: @"277510879"].CGImage;
    [self.view.layer addSublayer:self.imageLayer];

    [self createCAMediaTiming];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    // 绘制关键帧动画
//    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
//    animation.keyPath = @"position";
//    animation.duration = 4.0;
//    animation.path = _bezierPath.CGPath;
//    // 苹果添加了一个rotatioinMode属性，图层会根据曲线的切线自动旋转，运动轨迹更为真实
//    animation.rotationMode = kCAAnimationRotateAuto;
//    [self.imageLayer addAnimation:animation forKey:nil];
    
    
    // 虚拟属性
    /*
     CABasicAnimation 算是CAKeyframeAnimation的特殊化，
     CABasicAnimation 只能从一个数值（fromValue）变换成另一个数值（toValue)
     */
    CABasicAnimation *an = [CABasicAnimation animation];
    // 想要对物体做旋转动画，就需要作用于transform属性，因为CALayer没有显示提供角度或者方向之类的属性
    an.keyPath = @"transform";
    an.duration = 2.0;
    // 图片旋转180˚
    an.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI, 0, 0, 1)];
    [self.imageLayer addAnimation:an forKey:nil];
    
}

//// 虚拟属性
//- (void)fakeProprety{
//    CALayer *demoLayer = [CALayer layer];
//    demoLayer.frame = CGRectMake(0, 0, 128, 128);
//    demoLayer.position = CGPointMake(150, 150);
//    demoLayer.contents = (__bridge id)[UIImage imageNamed:@"277510879"].CGImage;
//
//}

- (void)createCAMediaTiming{
//    CAMediaTimingFunction *function = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    //CAMediaTimingFunction：将动画的步调定义为时间曲线
    CAMediaTimingFunction *function = [CAMediaTimingFunction functionWithControlPoints:1 :0 :0.75 :1];
    CGPoint controlPoint1, controlPoint2;
    // 返回指定索引的控制点
    [function getControlPointAtIndex:1 values:(float *)&controlPoint1];
    [function getControlPointAtIndex:2 values:(float *)&controlPoint2];
    
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path moveToPoint:CGPointZero];
    
    // 在子路径中追加一条三次贝塞尔曲线
    [path addCurveToPoint:CGPointMake(1, 1)
            controlPoint1:controlPoint1 controlPoint2:controlPoint2];
    // 使用指定的仿射变换矩阵变换路径中的所有点
    [path applyTransform:CGAffineTransformMakeScale(200, 200)];
    //create shape layer
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    
    // 用于描画形状路径的颜色
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    
    // 用于填充形状路径的颜色
    shapeLayer.fillColor = [UIColor greenColor].CGColor;
    shapeLayer.lineWidth = 4.0f;
    shapeLayer.path = path.CGPath;
    [self.view.layer addSublayer:shapeLayer];
    //geometryFlipped属性对subView的布局产生影响。设置成YES，则subView.top 相对于view.bottom了
    //也就形成了按水平中心线做了翻转
    self.view.layer.geometryFlipped = NO;
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
