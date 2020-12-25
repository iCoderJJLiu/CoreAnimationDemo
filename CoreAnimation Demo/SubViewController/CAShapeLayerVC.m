//
//  CAShapeLayerVC.m
//  CoreAnimation Demo
//
//  Created by JJ.Liu's mbp on 2020/12/24.
//

#import "CAShapeLayerVC.h"

/*
 CAShapeLayer是一个通过矢量图形而不是bitmap来绘制的图层子类
 使用CAShapeLayer有以下一些优点：
 1. 渲染快速。
 2. 高效使用内存。
 3. 不会被图层边界剪裁掉。
 4. 不会出现像素化。
 */

@interface CAShapeLayerVC ()

@end

@implementation CAShapeLayerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    UIBezierPath *path = [[UIBezierPath alloc] init];
    
    // 将UIBezierPath对象的currentPoint移动到指定的点
    [path moveToPoint:CGPointMake(175, 100)];
    
    // 在当前子路径中追加一条圆弧
    [path addArcWithCenter:CGPointMake(150, 100) radius:25 startAngle:0 endAngle:2 * M_PI clockwise:YES];
    
    [path moveToPoint:CGPointMake(150, 125)];
    
    // 在当前子路径中追加一条直线
    [path addLineToPoint:CGPointMake(150, 175)];
    [path addLineToPoint:CGPointMake(125, 225)];
    [path moveToPoint:CGPointMake(150, 175)];
    [path addLineToPoint:CGPointMake(175, 225)];
    [path moveToPoint:CGPointMake(100, 150)];
    [path addLineToPoint:CGPointMake(200, 150)];
    
    // 在子路径中追加一条三次贝塞尔曲线
    // path addCurveToPoint:<#(CGPoint)#> controlPoint1:<#(CGPoint)#> controlPoint2:<#(CGPoint)#>
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    // 用户描绘形状路径的颜色，可动画
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    
    // 用于填充形状路径的颜色，可动画
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    
    // 指定形状路径的线宽
    shapeLayer.lineWidth = 5;
    
    // 指定形状路径的线连接样式
    shapeLayer.lineJoin = kCALineJoinRound;
    
    // 指定形状路径的线帽样式
    shapeLayer.lineCap = kCALineCapRound;
    
    shapeLayer.path = path.CGPath;
    [self.view.layer addSublayer:shapeLayer];
    
    
    
    
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
