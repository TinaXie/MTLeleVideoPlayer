//
//  MTPhotoVideoItem.h
//  MTVideoPlayer
//
//  Created by xiejc on 2021/4/20.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MTPhotoVideoItem : NSObject

@property (nonatomic, strong) NSURL *url;
@property (nonatomic, strong) UIImage *coverImg;
@property (nonatomic, strong) NSString *dTime;

@end

NS_ASSUME_NONNULL_END
