//
//  CAReplicatorLayerVC.m
//  CoreAnimation Demo
//
//  Created by JJ.Liu's mbp on 2020/12/24.
//

#import "CAReplicatorLayerVC.h"

@interface CAReplicatorLayerVC ()

@end

@implementation CAReplicatorLayerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self setCAReplicatorLayer];
}

- (void)setCAReplicatorLayer{
    // CAReplicatorLayer 创建具有指定数量的子图层副本的图层，并具有不同的几何，时间和颜色转换
    CAReplicatorLayer *replicator = [CAReplicatorLayer layer];
    replicator.frame = self.view.bounds;
    [self.view.layer addSublayer:replicator];
    
    // 要创建的副本数，包括源图层
    replicator.instanceCount = 10;
    
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DTranslate(transform, 0, 20, 0);
    transform = CATransform3DRotate(transform, M_PI / 5.0, 0, 0, 1);
    transform = CATransform3DTranslate(transform, 0, -20, 0);
    replicator.instanceTransform = transform;
    
    // 定义为每个复制实例添加到颜色的蓝色分量的偏移量
    replicator.instanceBlueOffset = -0.1;
    // 定义为每个复制实例添加到颜色的绿色分量的偏移量
    replicator.instanceGreenOffset = -0.1;
    
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(100.0f, 100.0f, 100.0f, 100.0f);
    layer.backgroundColor = [UIColor whiteColor].CGColor;
    [replicator addSublayer:layer];
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
