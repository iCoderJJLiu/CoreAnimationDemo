//
//  CATextLayerVC.m
//  CoreAnimation Demo
//
//  Created by JJ.Liu's mbp on 2020/12/24.
//

#import "CATextLayerVC.h"

@interface CATextLayerVC ()

@end

@implementation CATextLayerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self setTextLabel];
}

- (void)setTextLabel{
    CATextLayer *textLayer = [CATextLayer layer];
    textLayer.frame = self.view.bounds;
    [self.view.layer addSublayer:textLayer];
    
    // 用于呈现接受者文本的颜色
    textLayer.foregroundColor = [UIColor blackColor].CGColor;
    // 确定单个文本如何在接受者范围内水平对其
    textLayer.alignmentMode = kCAAlignmentJustified;
    // 确定文本是否自动换行以适合接收者的范围
    textLayer.wrapped = YES;
    
    UIFont *font = [UIFont systemFontOfSize:15];
    
    CFStringRef fontName = (__bridge CFStringRef)font.fontName;
    CGFontRef fontRef = CGFontCreateWithFontName(fontName);
    // 呈现文字的字体
    textLayer.font = fontRef;
    // 呈现文字的字体大小
    textLayer.fontSize = font.pointSize;
    // 将font释放
    CGFontRelease(fontRef);
    
    NSString *text = @"Lorem ipsum dolor sit amet, consectetur adipiscing \ elit. Quisque massa arcu, eleifend vel varius in, facilisis pulvinar \ leo. Nunc quis nunc at mauris pharetra condimentum ut ac neque. Nunc elementum, libero ut porttitor dictum, diam odio congue lacus, vel \ fringilla sapien diam at purus. Etiam suscipit pretium nunc sit amet \ lobortis";
    textLayer.string = text;
    
    // 通过设置contentsScale的值来以Retina屏幕质量来显示文字
    textLayer.contentsScale = [UIScreen mainScreen].scale;
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
