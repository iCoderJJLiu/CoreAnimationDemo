//
//  AVPlayerLayerVC.m
//  CoreAnimation Demo
//
//  Created by JJ.Liu's mbp on 2020/12/24.
//

#import "AVPlayerLayerVC.h"
#import <AVFoundation/AVFoundation.h>
@interface AVPlayerLayerVC ()<CAAnimationDelegate>

@end

@implementation AVPlayerLayerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSURL *URL = [[NSBundle mainBundle] URLForResource:@"Ship" withExtension:@"mp4"];

    AVPlayer *player = [AVPlayer playerWithURL:URL];
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];

    playerLayer.frame = self.view.bounds;
    [self.view.layer addSublayer:playerLayer];

    [player play];
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
