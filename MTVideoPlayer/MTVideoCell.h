//
//  MTVideoCell.h
//  MTVideoPlayer
//
//  Created by xiejc on 2021/4/20.
//

#import <UIKit/UIKit.h>
#import "MTPhotoVideoItem.h"

NS_ASSUME_NONNULL_BEGIN

#define MTVideoCellIdentifier @"MTVideoCell"

@interface MTVideoCell : UICollectionViewCell

- (void)loadItem:(MTPhotoVideoItem *)videoItem;

@end

NS_ASSUME_NONNULL_END
