//
//  MTPhotoManager.h
//  MTVideoPlayer
//
//  Created by xiejc on 2021/4/20.
//

#import <Foundation/Foundation.h>
#import "MTPhotoVideoItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface MTPhotoManager : NSObject

+ (void)loadAllVideo:(NSMutableArray<MTPhotoVideoItem *> *)dataList;

@end

NS_ASSUME_NONNULL_END
