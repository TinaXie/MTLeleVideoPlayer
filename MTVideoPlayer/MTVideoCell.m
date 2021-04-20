//
//  MTVideoCell.m
//  MTVideoPlayer
//
//  Created by xiejc on 2021/4/20.
//

#import "MTVideoCell.h"

@interface MTVideoCell ()

@property (weak, nonatomic) IBOutlet UIImageView *coverImg;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation MTVideoCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)loadItem:(MTPhotoVideoItem *)videoItem {
    self.coverImg.image = videoItem.coverImg;
    self.timeLabel.text = videoItem.dTime;
}



@end
