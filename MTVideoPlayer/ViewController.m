//
//  ViewController.m
//  MTVideoPlayer
//
//  Created by xiejc on 2021/4/20.
//

#import "ViewController.h"
#import <Photos/Photos.h>
#import <AssetsLibrary/AssetsLibrary.h>

#import "PlayerViewController.h"
#import "MTVideoCell.h"

#import "MTPhotoManager.h"


@interface ViewController ()
<UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak) IBOutlet UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray<MTPhotoVideoItem *> *dataList;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataList = [NSMutableArray array];
    
    UINib *cellNib = [UINib nibWithNibName:NSStringFromClass([MTVideoCell class]) bundle:[NSBundle mainBundle]];
    [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:MTVideoCellIdentifier];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.collectionView reloadData];
    });
    
    [MTPhotoManager loadAllVideo:self.dataList];
}

- (IBAction)refreshCollectionView:(id)sender {
    [self.collectionView reloadData];
}


- (IBAction)showVideo:(id)sender {
    [self showPlayView:0];
}

- (void)showPlayView:(NSInteger)currentIndex {
    if (self.dataList.count == 0) {
        return;
    }
    NSLog(@"====showPlayView at:[%ld]", (long)currentIndex);
    PlayerViewController *playVC = [[PlayerViewController alloc] init];
    playVC.dataList = self.dataList;
    playVC.currentIndex = currentIndex;
    [self presentViewController:playVC animated:YES completion:nil];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataList.count;

}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MTVideoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:MTVideoCellIdentifier forIndexPath:indexPath];
    MTPhotoVideoItem *item = [self.dataList objectAtIndex:indexPath.row];
    [cell loadItem:item];
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self showPlayView:indexPath.row];
}


@end

