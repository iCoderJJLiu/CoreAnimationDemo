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
    CAReplicatorLayer *replicator = [CAReplicatorLayer layer];
    replicator.frame = self.view.bounds;
    [self.view.layer addSublayer:replicator];
    
    replicator.instanceCount = 10;
    
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DTranslate(transform, 0, 20, 0);
    transform = CATransform3DRotate(transform, M_PI / 5.0, 0, 0, 1);
    transform = CATransform3DTranslate(transform, 0, -20, 0);
    replicator.instanceTransform = transform;
    
    replicator.instanceBlueOffset = -0.1;
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
