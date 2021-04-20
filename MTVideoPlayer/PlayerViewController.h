//
//  PlayerViewController.h
//  MTVideoPlayer
//
//  Created by xiejc on 2021/4/20.
//

#import <UIKit/UIKit.h>
#import <AVKit/AVKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PlayerViewController : AVPlayerViewController

@property (nonatomic, strong) NSMutableArray *dataList;

@end

NS_ASSUME_NONNULL_END
