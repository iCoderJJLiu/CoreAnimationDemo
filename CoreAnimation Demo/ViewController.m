//
//  ViewController.m
//  CoreAnimation Demo
//
//  Created by JJ.Liu's mbp on 2020/12/24.
//

#import "ViewController.h"
#import "CALayerDrawVC.h"
#import "LayerGeometryVC.h"
#import "LayerProcessVC.h"
#import "CAShapeLayerVC.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *homeTableView;
@property (nonatomic, strong) NSMutableArray *cellTextArray;
@property (nonatomic, strong) NSMutableArray *vcNameArray;
@property (nonatomic, strong) UIViewController *pushedVC;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    // cell信息源
    _cellTextArray = [[NSMutableArray alloc] initWithObjects:@"CALayer相关",@"图层几何相关",@"圆角，边框，阴影，蒙板，组透明等",@"CAShapeLayer",@"CATextLayer",@"CATransformLayer",@"CAGradientLayer",@"CAReplicatorLayer",@"CAEmitterLayer",@"AVPlayerLayer", nil];
    // VC 类名
    _vcNameArray = [[NSMutableArray alloc] initWithObjects:@"CALayerDrawVC",@"LayerGeometryVC",@"LayerProcessVC",@"CAShapeLayerVC",@"CATextLayerVC",@"CATransformLayerVC",@"CAGradientLayer_VC",@"CAReplicatorLayerVC",@"CAEmitterLayerVC",@"AVPlayerLayerVC", nil];
    
    // 创建主界面
    _homeTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _homeTableView.delegate = self;
    _homeTableView.dataSource = self;
    [self.view addSubview:_homeTableView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.cellTextArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellId = @"reuseCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.textLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0.8 alpha:0.7];
    if (_cellTextArray.count > indexPath.row) {
        cell.textLabel.text = [_cellTextArray objectAtIndex:indexPath.row];
    }
    return cell;
}

// 点击跳转VC
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    _pushedVC = [[NSClassFromString(_vcNameArray[indexPath.row]) alloc] init];
    [self presentViewController:_pushedVC animated:YES completion:nil];
//    [self.navigationController pushViewController:_pushedVC animated:YES];
}

@end
