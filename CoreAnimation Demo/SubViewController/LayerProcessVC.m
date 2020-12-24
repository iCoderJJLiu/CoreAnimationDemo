//
//  LayerProcessVC.m
//  CoreAnimation Demo
//
//  Created by JJ.Liu's mbp on 2020/12/24.
//

#import "LayerProcessVC.h"

@interface LayerProcessVC ()

@property (nonatomic, strong) UIView *greenView;
@property (nonatomic, strong) UIView *redView;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation LayerProcessVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.greenView = [[UIView alloc] initWithFrame:CGRectMake(30, 30, 100, 100)];
    self.greenView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:self.greenView];

    self.redView = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 100, 100)];
    self.redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.redView];
    
    /*
     设置cornerRadius大于0时，只为layer的background和border设置圆角，而不会对layer的contents设置圆角
     除非同时设置了layer.masksToBounds为YES
     */
    self.greenView.layer.cornerRadius = 20.0f;
//    self.redView.layer.cornerRadius = 20.0f;
//    self.redView.layer.masksToBounds = YES;

    [self drawViewBorderWidth];
    [self setShadow];
    [self rebuildImage];
    
    [self changeButtonAlpha];
}

// 图层边框
// borderWidth是以点为单位的定义边框粗细的浮点数，默认为0，borderColor定义了边框的颜色，默认为黑色。
- (void)drawViewBorderWidth{
    self.greenView.layer.borderWidth = 5.0f;
//    self.redView.layer.borderWidth = 5.0f;
//    // borderColor是CGColorRef类型
//    self.redView.layer.borderColor = [UIColor grayColor].CGColor;
}

// 阴影
- (void)setShadow{
    self.redView.layer.shadowOpacity = 1.0f;
    self.redView.layer.shadowOffset = CGSizeMake(1.0f, 5.0f);
    self.redView.layer.shadowRadius = 5.0f;
}

// 图层蒙版
- (void)rebuildImage{
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 200, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.width / 2)];
    self.imageView.image = [UIImage imageNamed:@"截屏2020-12-17 下午2.28.26"];
    [self.view addSubview:self.imageView];
    
    CALayer *maskLayer = [CALayer layer];
    maskLayer.frame = self.imageView.bounds;
    UIImage *maskImage = [UIImage imageNamed:@"2020美团壁纸MacOsAir"];
    maskLayer.contents = (__bridge id)maskImage.CGImage;
    self.imageView.layer.mask = maskLayer;
    
    // 使用affine Transform对图层做45度顺时针旋转。
//    CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI_4);
//    self.imageView.layer.affineTransform = transform;
    
    // 混合变换
    CGAffineTransform tran = CGAffineTransformIdentity;
    tran = CGAffineTransformScale(tran, 0.5, 0.5);
    tran = CGAffineTransformRotate(tran, M_PI / 180.0 * 30.0);
    tran = CGAffineTransformTranslate(tran, 200, 0);
    self.imageView.layer.affineTransform = tran;
}

- (void)changeButtonAlpha{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(0, 500, 200, 100);
    button.layer.cornerRadius = 10;
    [button setTitle:@"这是一个按钮" forState:UIControlStateNormal];
    button.titleLabel.backgroundColor = [UIColor orangeColor];
    button.backgroundColor = [UIColor orangeColor];
    
    // 直接改变button的alpha值，会引起按钮颜色和本身label的分离，因此label区域颜色比按钮边框区域更深
    button.alpha = 0.5;
    
    // 可以设置CALayer的shouldRastertize属性来达到透明效果
    // 如果其被设置成YES，在应用透明度之前，图层及其子图层都会被整合成一个整体的图片，这样就没有透明度混合的问题了
    button.layer.shouldRasterize = YES;
    // 手动设置rasterizationScale去匹配屏幕，以防止出现Retina屏幕像素化
    button.layer.rasterizationScale = [UIScreen mainScreen].scale;
    [self.view addSubview:button];
    
    
    // 3D 变换
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -1.0 / 500.0;
    transform = CATransform3DRotate(transform, M_PI_4, 0, 1, 0);
    button.layer.transform = transform;
    
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
