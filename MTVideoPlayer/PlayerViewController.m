//
//  PlayerViewController.m
//  MTVideoPlayer
//
//  Created by xiejc on 2021/4/20.
//

#import "PlayerViewController.h"

@interface PlayerViewController ()
<AVPlayerViewControllerDelegate>

//@property (nonatomic, strong) AVPlayer *avPlayer;
@property (nonatomic, assign) int currentIndex;

@end

@implementation PlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playFinish) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    
    [self playNext];
}


- (void)playNext {
    if (self.dataList.count == 0 || self.currentIndex >= self.dataList.count) {
        return;
    }
    
    NSURL *url = [self.dataList objectAtIndex:self.currentIndex];
    AVPlayer *player = [AVPlayer playerWithURL:url];
    self.player = player;
    [self.player play];
}


- (void)playFinish {
    self.currentIndex ++;
    NSLog(@"===video finish!!!");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self playNext];
    });

}

#pragma mark - AVPlayerViewControllerDelegate


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
