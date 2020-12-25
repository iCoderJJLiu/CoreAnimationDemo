//
//  DrawImageVC.m
//  CoreAnimation Demo
//
//  Created by JJ.Liu's mbp on 2020/12/25.
//

#import "DrawImageVC.h"

@interface DrawImageVC ()

@property(nonatomic, strong) UIBezierPath *path;

@end

@implementation DrawImageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    self.path = [[UIBezierPath alloc] init];
    self.path.lineJoinStyle = kCGLineJoinRound;
    self.path.lineCapStyle = kCGLineCapRound;
    
    self.path.lineWidth = 5;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint point = [[touches anyObject] locationInView:self.view];
    [self.path moveToPoint:point];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint point = [[touches anyObject] locationInView:self.view];
    [self.path addLineToPoint:point];
    [self.view setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect{
    [[UIColor clearColor] setFill];
    [[UIColor redColor] setStroke];
    [self.path stroke];
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
