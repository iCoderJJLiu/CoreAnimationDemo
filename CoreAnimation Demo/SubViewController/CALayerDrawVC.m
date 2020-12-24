//
//  CALayerDrawVC.m
//  CoreAnimation Demo
//
//  Created by JJ.Liu's mbp on 2020/12/24.
//

#import "CALayerDrawVC.h"

@interface CALayerDrawVC ()<CALayerDelegate>

@property (nonatomic, strong) UIView *coneView;
@property (nonatomic, strong) UIView *shipView;
@property (nonatomic, strong) UIView *iglooView;
@property (nonatomic, strong) UIView *anchorView;

@end

@implementation CALayerDrawVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 创建一个CALayer
    CALayer *blueLayer = [CALayer layer];
    blueLayer.frame = CGRectMake(10, 10, 50, 50);
    blueLayer.backgroundColor = [UIColor blueColor].CGColor;
    [self.view.layer addSublayer:blueLayer];
    
    /*
     CALayer中有一个contents属性，类型为id类型
     如果给contents赋的值不是CGImage，那图层将会是空白
     */
    // 使用contents来创建图片
    CALayer *imageLayer = [CALayer layer];
    imageLayer.frame = CGRectMake(100, 10, 100, 100);
    UIImage *image = [UIImage imageNamed:@"277510879"];
    imageLayer.contents = (__bridge id)image.CGImage;
    // 其效果等同于UIView中的UIViewContentModeScaleAspectFit 图片自适应
    imageLayer.contentsGravity = kCAGravityResizeAspect;

    /*
     contentsScale属性定义了寄宿图的像素尺寸和视图大小的比例，默认情况为1.0
     iOS中用contentsScale来支持高分辨率屏幕机制
     1.0表示将会以每个点1个像素绘制图片，2.0将会以每个点2.0个像素绘制图片(retina 屏幕)
     当使用kCAGravityCenter值时，并不会拉伸图片，需要手动设置contentsScale
     */
//    imageLayer.contentsGravity = kCAGravityCenter;
//    imageLayer.contentsScale = [UIScreen mainScreen].scale;
    [self.view.layer addSublayer:imageLayer];

    // 使用contentsRect实现图片拼合
    [self imageSprites];
    
    /*
     自定义绘图方法
     当视图在屏幕上出现的时候，-drawRect方法就会被自动调用
     drawRect是一个UIView方法，事实上都是底层的CALayer安排了重绘工作
     */
    blueLayer.delegate = self;
    
    // 显示的调用display，CALayer不会自动重绘制其内容，会把重绘的决定权交给开发者
    [blueLayer display];
}

- (void)imageSprites{
    
    UIImage *image = [UIImage imageNamed:@"277510879"];
    
    _coneView = [[UIView alloc] initWithFrame:CGRectMake(0, 100, 150, 75)];
    _coneView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:_coneView];
    
    _shipView = [[UIView alloc] initWithFrame:CGRectMake(200, 100, 150, 75)];
    _shipView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:_shipView];
    
    _iglooView = [[UIView alloc] initWithFrame:CGRectMake(0, 180, 150, 75)];
    _iglooView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:_iglooView];
    
    _anchorView = [[UIView alloc] initWithFrame:CGRectMake(200, 180, 150, 75)];
    _anchorView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:_anchorView];
    
    [self addSrpiteImage:image WithContentRect:CGRectMake(0, 0, 0.5, 0.5) toLayer:self.iglooView.layer];
    [self addSrpiteImage:image WithContentRect:CGRectMake(0.5, 0, 0.5, 0.5) toLayer:self.coneView.layer];
    [self addSrpiteImage:image WithContentRect:CGRectMake(0, 0.5, 0.5, 0.5) toLayer:self.anchorView.layer];
    [self addSrpiteImage:image WithContentRect:CGRectMake(0.5, 0.5, 0.5, 0.5) toLayer:self.shipView.layer];
}

- (void)addSrpiteImage:(UIImage *)image WithContentRect:(CGRect)rect toLayer:(CALayer *)layer{
    layer.contents = (__bridge id)image.CGImage;
    layer.contentsGravity = kCAGravityResizeAspect;
    layer.contentsRect = rect;
}

/*
 当需要重绘时，CALayer会请求它的代理给他一个寄宿图来显示，通过调用
 (void)displayLayer:(CALayerCALayer *)layer;来做到
 
 如果代理不实现该方法，CALayer将会转换尝试调用下面方法
 */

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx{
    CGContextSetLineWidth(ctx, 5.0f);
    CGContextSetStrokeColorWithColor(ctx, [UIColor redColor].CGColor);
    CGContextStrokeEllipseInRect(ctx, layer.bounds);
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
