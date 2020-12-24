//
//  CAGradientLayer VC.m
//  CoreAnimation Demo
//
//  Created by JJ.Liu's mbp on 2020/12/24.
//

#import "CAGradientLayer VC.h"

@interface CAGradientLayer_VC ()

@end

@implementation CAGradientLayer_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setCAGradientLayer];
}

// CAGradientLayer是用来生成两种或更多颜色平滑渐变的
// 基础渐变
- (void)setCAGradientLayer{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.view.bounds;
    [self.view.layer addSublayer:gradientLayer];
    gradientLayer.colors = @[(__bridge id)[UIColor redColor].CGColor, (__bridge id)[UIColor blueColor].CGColor];
    
//    // 多重渐变
//    gradientLayer.locations = @[@0.0, @0.5, @1.0];
    /*
     AGradientLayer也有startPoint和endPoint属性，他们决定了渐变的方向。
     这两个参数是以单位坐标系进行的定义，所以左上角坐标是{0, 0}，右下角坐标是{1, 1}
     */
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 1);
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
