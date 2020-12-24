//
//  LayerGeometryVC.m
//  CoreAnimation Demo
//
//  Created by JJ.Liu's mbp on 2020/12/24.
//

#import "LayerGeometryVC.h"

@interface LayerGeometryVC ()
@property (nonatomic, strong) UIView *greenView;
@property (nonatomic, strong) UIView *redView;

@property (nonatomic, strong) UIView *layerView;
@property (nonatomic, strong) CALayer *blueLayer;
@end

@implementation LayerGeometryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _greenView = [[UIView alloc] initWithFrame:CGRectMake(0, 100, 150, 75)];
    _greenView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:_greenView];

    _redView = [[UIView alloc] initWithFrame:CGRectMake(20, 140, 150, 75)];
    _redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_redView];
    
    // 可以更改图层Z坐标轴大小，调整图层上下顺序。
    // 注意：只会调整显示顺序，不会做到真正的层级调整
    self.greenView.layer.zPosition = 1.0f;
    
    [self hitTestMethod];
}

// 命中测试
- (void)hitTestMethod{
    self.layerView = [[UIView alloc] initWithFrame:CGRectMake(0, 400, UIScreen.mainScreen.bounds.size.width, 200)];
    self.layerView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:self.layerView];
    
    self.blueLayer = [CALayer layer];
    self.blueLayer.frame = CGRectMake(50.0f, 50.0f, 100.0f, 100.0f);
    self.blueLayer.backgroundColor = [UIColor blueColor].CGColor;
    [self.layerView.layer addSublayer:self.blueLayer];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint point = [[touches anyObject] locationInView:self.view];
    point = [self.layerView.layer convertPoint:point fromLayer:self.view.layer];
    
    if ([self.layerView.layer containsPoint:point]) {
        point = [self.blueLayer convertPoint:point fromLayer:self.layerView.layer];
        if ([self.blueLayer containsPoint:point]) {
            NSLog(@"INSIDE BLUE LAYER");
        } else {
            NSLog(@"INSIDE ORANGE LAYER");
        }
    }
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
