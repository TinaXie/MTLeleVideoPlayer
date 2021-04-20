//
//  MTPhotoManager.m
//  MTVideoPlayer
//
//  Created by xiejc on 2021/4/20.
//

#import "MTPhotoManager.h"

#import <Photos/Photos.h>
#import <AssetsLibrary/AssetsLibrary.h>

#define VideoImgSize 200

@implementation MTPhotoManager


+ (void)loadAllVideo:(NSMutableArray *)dataList {
    //系统
    PHFetchResult *smartAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    
    for (PHAssetCollection *collection in smartAlbums) {
        //遍历获取相册
        if ([collection estimatedAssetCount] == 0) {
            return;
        }
        //只取最近的里面
        if (![collection.localizedTitle isEqualToString:@"Recents"]) {
            continue;
        }
        //获取当前相册里所有的PHAsset，也就是图片或者视频
        PHFetchResult *fetchResult = [PHAsset fetchAssetsInAssetCollection:collection options:nil];
        for (NSInteger j = 0; j < fetchResult.count; j++) {
            //从相册中取出照片
            PHAsset *asset = fetchResult[j];
            if (asset.mediaType == PHAssetMediaTypeImage) {
                //得到一个图片类型资源
            }else if (asset.mediaType == PHAssetMediaTypeVideo) {
                //得到一个视频类型资源
                MTPhotoVideoItem *item = [[MTPhotoVideoItem alloc] init];
                [self getVideoPathFromPHAsset:asset Complete:^(NSURL *videoURL, NSString *dTime) {
                    item.url = videoURL;
                    item.dTime = dTime;
                    [dataList insertObject:item atIndex:0];
                }];
                
                [self getVideoImageFromPHAsset:asset Complete:^(UIImage *image) {
                    item.coverImg = image;
                }];
                
            } else if (asset.mediaType == PHAssetMediaTypeAudio) {
                //音频，PHAsset的mediaType属性有三个枚举值，笔者对PHAssetMediaTypeAudio暂时没有进行处理
            }
        }
        
    }
}


//获取视频本地地址及时长
+ (void)getVideoPathFromPHAsset:(PHAsset *)phAsset Complete:(void (^)(NSURL *videoURL,NSString *dTime))result {
    PHVideoRequestOptions *options = [[PHVideoRequestOptions alloc] init];
    options.version = PHImageRequestOptionsVersionCurrent;
    options.deliveryMode = PHVideoRequestOptionsDeliveryModeAutomatic;
    options.networkAccessAllowed = YES;
    
    [[PHImageManager defaultManager] requestAVAssetForVideo:phAsset options:options resultHandler:^(AVAsset * _Nullable asset, AVAudioMix * _Nullable audioMix, NSDictionary * _Nullable info) {
        
        CMTime   time = [asset duration];
        int seconds = ceil(time.value/time.timescale);
        //format of minute
        NSString *str_minute = [NSString stringWithFormat:@"%d",seconds/60];
        //format of second
        NSString *str_second = [NSString stringWithFormat:@"%.2d",seconds%60];
        //format of time
        NSString *format_time = [NSString stringWithFormat:@"%@:%@",str_minute,str_second];
        
        //video路径获取
        if (asset && [asset isKindOfClass:[AVURLAsset class]]) {
            AVURLAsset *urlAsset = (AVURLAsset *)asset;
            NSURL *videoURL = urlAsset.URL;
            result(videoURL, format_time);
        }
    }];
}

//获取视频图片
+ (void)getVideoImageFromPHAsset:(PHAsset *)asset Complete:(void (^)(UIImage *image))resultBack{
    PHImageRequestOptions *option = [[PHImageRequestOptions alloc] init];
    option.resizeMode = PHImageRequestOptionsResizeModeFast;
    
    [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:CGSizeMake(VideoImgSize, VideoImgSize) contentMode:PHImageContentModeDefault options:option resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        UIImage *iamge = result;
        resultBack(iamge);
    }];
}

@end

