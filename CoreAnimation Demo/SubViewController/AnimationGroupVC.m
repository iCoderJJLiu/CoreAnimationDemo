//
//  AnimationGroupVC.m
//  CoreAnimation Demo
//
//  Created by JJ.Liu's mbp on 2020/12/25.
//

#import "AnimationGroupVC.h"

@interface AnimationGroupVC ()

@property(nonatomic, strong)CAAnimationGroup *groupAnimation;
@property(nonatomic, strong)CALayer *colorLayer;
@property(nonatomic, strong)UIImageView *imageView;
@property(nonatomic, copy)NSArray *imageArray;
@property(nonatomic, strong)CALayer *doorLayer;

@end

@implementation AnimationGroupVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    /*
     CABasicAnimation 和 CAKeyframeAnimation仅仅作用于单独的属性
     CAAnimationGroup 可以把动画组合在一起
     CAAnimationGroup 是另一个继承于CAAnimation的子类，它添加了一个animations数组的属性，用来组合别的动画
     */
    [self integrationAnimation];
    
    
    UIButton *changeImage = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [changeImage setTitle:@"改变图片" forState:UIControlStateNormal];
    changeImage.frame = CGRectMake(0, 400, 100, 50);
    [self.view addSubview:changeImage];
    [changeImage addTarget:self action:@selector(changeImageMethod) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *customeChange = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [customeChange setTitle:@"自定义图片改变" forState:UIControlStateNormal];
    customeChange.frame = CGRectMake(200, 400, 300, 50);
    [self.view addSubview:customeChange];
    [customeChange addTarget:self action:@selector(costumeChangeImage) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.imageArray = @[[UIImage imageNamed:@"2020美团壁纸MacOsAir"],
                        [UIImage imageNamed:@"276962363"],
                        [UIImage imageNamed:@"277510879"],
                        [UIImage imageNamed:@"截屏2020-12-17 下午2.28.26"]
    ];
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(30, 300, 200, 100)];
    [self.view addSubview:self.imageView];

}

- (void)integrationAnimation{
    //创建贝塞尔曲线
    UIBezierPath *bezierPath = [[UIBezierPath alloc] init];
    [bezierPath moveToPoint:CGPointMake(0, 150)];
    [bezierPath addCurveToPoint:CGPointMake(300, 150) controlPoint1:CGPointMake(75, 0) controlPoint2:CGPointMake(225, 300)];
    
    //使用CAShapeLayer绘制曲线
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.path = bezierPath.CGPath;
    // 用于填充形状路径的颜色
    pathLayer.fillColor = [UIColor clearColor].CGColor;
    // 用于描画形状路径的颜色
    pathLayer.strokeColor = [UIColor redColor].CGColor;
    pathLayer.lineWidth = 3.0f;
    [self.view.layer addSublayer:pathLayer];
    
    //创建color图层
    self.colorLayer = [CALayer layer];
    self.colorLayer.frame = CGRectMake(0, 0, 64, 64);
    self.colorLayer.position = CGPointMake(0, 150);
    self.colorLayer.backgroundColor = [UIColor greenColor].CGColor;
    [self.view.layer addSublayer:self.colorLayer];
    
    //创建关键帧动画
    CAKeyframeAnimation *animation1 = [CAKeyframeAnimation animation];
    animation1.keyPath = @"position";
    animation1.path = bezierPath.CGPath;
    animation1.rotationMode = kCAAnimationRotateAuto;
    
    //创建CABasicAnimation动画
    CABasicAnimation *animation2 = [CABasicAnimation animation];
    animation2.keyPath = @"backgroundColor";
    animation2.toValue = (__bridge id)[UIColor redColor].CGColor;
    
    //创建组动画
    self.groupAnimation = [CAAnimationGroup animation];
    self.groupAnimation.animations = @[animation1, animation2];
    self.groupAnimation.duration = 4.0;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //将组动画添加到colorLayer图层
    [self.colorLayer addAnimation:self.groupAnimation forKey:nil];
    
    // 通过以下方法，可以终止一个指定的动画，把它从图层移除掉
    // - (void)removeAnimationForKey:(NSString *)key;
    // 或者移除所有动画
    // - (void)removeAllAnimations;
    [self doorRepeat];
    
}

- (void)changeImageMethod{
    CATransition *transition = [CATransition animation];
    
    /*
     type 属性是一个NSString类型，可以被设置成如下类型：
     kCATransitionFade
     kCATransitionMoveIn
     kCATransitionPush
     kCATransitionReveal
     */
    transition.type = kCATransitionFromRight;
    
    [self.imageView.layer addAnimation:transition forKey:nil];
    
    UIImage *currentImage = self.imageView.image;
    NSUInteger index = [self.imageArray indexOfObject:currentImage];
    index = (index + 1) % [self.imageArray count];
    self.imageView.image = self.imageArray[index];
}

- (void)costumeChangeImage{
    
    /*
     UIViewAnimationOptionCurveEaseInOut
     UIViewAnimationOptionCurveEaseIn
     UIViewAnimationOptionCurveEaseOut
     UIViewAnimationOptionCurveLinear
     以上效果同 PropretyAnimationVC.m 中效果类似
     */
    [UIView transitionWithView:self.imageView duration:1.0 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
            UIImage *currentImage = self.imageView.image;
            NSUInteger index = [self.imageArray indexOfObject:currentImage];
            index = (index + 1) % [self.imageArray count];
            self.imageView.image = self.imageArray[index];
    } completion:NULL];
}

//
- (void)doorRepeat{
    _doorLayer = [CALayer layer];
    _doorLayer.frame = CGRectMake(50, 400, 50, 100);
    _doorLayer.position = CGPointMake(150 - 64, 150);
    // 锚点
    _doorLayer.anchorPoint = CGPointMake(0, 0.5);
    _doorLayer.contents = (__bridge id)[UIImage imageNamed: @"门"].CGImage;
    [self.view.layer addSublayer:_doorLayer];
    //apply perspective transform
    CATransform3D perspective = CATransform3DIdentity;
    // 3D变换矩阵向量值
    perspective.m34 = -1.0 / 500.0;
    self.view.layer.sublayerTransform = perspective;
//
//    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] init];
//    [pan addTarget:self action:@selector(pan:)];
//    [self.view addGestureRecognizer:pan];
//    _doorLayer.speed = 0.0;
    
    
    //apply swinging animation
    CABasicAnimation *animation = [CABasicAnimation animation];
    // 沿着Y轴旋转
    animation.keyPath = @"transform.rotation.y";
    // from to
    animation.toValue = @(-M_PI);
    animation.duration = 2.0;
    // 无限循环
    animation.repeatDuration = INFINITY;
    animation.autoreverses = YES;
    [_doorLayer addAnimation:animation forKey:nil];
}

//- (void)pan:(UIPanGestureRecognizer *)pan{
//    CGFloat x = [pan translationInView:self.view].x;
//    x /= 200.0f;
//    CFTimeInterval timeOffset = _doorLayer.timeOffset;
//    timeOffset = MIN(0.999, MAX(0.0, timeOffset - x));
//    _doorLayer.timeOffset = timeOffset;
//    [pan setTranslation:CGPointZero inView:self.view];
//}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
