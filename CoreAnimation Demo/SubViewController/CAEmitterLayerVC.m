//
//  CAEmitterLayerVC.m
//  CoreAnimation Demo
//
//  Created by JJ.Liu's mbp on 2020/12/24.
//

#import "CAEmitterLayerVC.h"

@interface CAEmitterLayerVC ()

@end

@implementation CAEmitterLayerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    // CAEmitterLayer 为发射，设置动画和渲染粒子系统的层
    CAEmitterLayer *emitter = [CAEmitterLayer layer];
    emitter.frame = self.view.bounds;
    [self.view.layer addSublayer:emitter];

    //定义如何将粒子像元渲染到图层中
    /*
     kCAEmitterLayerAdditive：使用源加法合成渲染粒子
     kCAEmitterLayerBackToFront：粒子从后到前渲染，按z位置排序
     kCAEmitterLayerOldestLast：年轻的粒子会被渲染在最上层
     kCAEmitterLayerOldestFirst：声明久的粒子会被渲染在最上层
     kCAEmitterLayerUnordered：粒子无序出现
     */
    emitter.renderMode = kCAEmitterLayerAdditive;
    
    // 粒子发射器中心的位置
    emitter.emitterPosition = CGPointMake(emitter.frame.size.width / 2.0, emitter.frame.size.height / 2.0);

    // CAEmitterCell：粒子发射单元
    CAEmitterCell *cell = [[CAEmitterCell alloc] init];
    // 提供图层内容对象
    cell.contents = (__bridge id)[UIImage imageNamed:@"粒子"].CGImage;
    // 每秒创建的发射对象的数量
    cell.birthRate = 150;
    // 发射器单元时长，单位s
    cell.lifetime = 5.0;
    cell.color = [UIColor colorWithRed:1 green:0.5 blue:0.1 alpha:1.0].CGColor;
    // Alpha分量在电池寿命中变化的速度（以秒为单位
    cell.alphaSpeed = -0.4;
    // 粒子初始化速度
    cell.velocity = 50;
    // 粒子速度可变化的量
    cell.velocityRange = 50;
    // 以弧度为单位的角度，定义了围绕发射角度的圆锥
    cell.emissionRange = M_PI * 2.0;

    //指定粒子发射器单元
    emitter.emitterCells = @[cell];
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
