//
//  ViewController.m
//  AlbumBrowser
//
//  Created by Realank on 16/3/10.
//  Copyright © 2016年 iMooc. All rights reserved.
//

#import "ViewController.h"
#import <Photos/Photos.h>
#import "MyCollectionViewController.h"


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectedPhotoAsset:) name:@"PhotoSelectedNotification" object:nil];
    
    UITapGestureRecognizer* tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapPhoto)];
    [self.photoImageView addGestureRecognizer:tapGes];
}



- (void)tapPhoto {
    [self loadAssets];
}


- (void)loadAssets {
    
    // Check library permissions
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusNotDetermined) {
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if (status == PHAuthorizationStatusAuthorized) {
                [self performLoadAssets];
            }
        }];
    } else if (status == PHAuthorizationStatusAuthorized) {
        [self performLoadAssets];
    }
    
}

- (void)performLoadAssets {
    
    NSMutableArray* assetsArr = [NSMutableArray array];
    PHFetchOptions *options = [PHFetchOptions new];
    options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
    PHFetchResult *fetchResults = [PHAsset fetchAssetsWithOptions:options];
    [fetchResults enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [assetsArr addObject:obj];
    }];
    //    NSLog(@"%@",assetsArr);
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(100, 100);
    NSInteger space = (self.view.bounds.size.width - 4*100)/8;
    space = space > 5 ? space : 5;
    layout.minimumLineSpacing = 15;
    layout.minimumInteritemSpacing = space;
    layout.sectionInset = UIEdgeInsetsMake(10, space, 10, space);
    
    
    MyCollectionViewController* myVC = [[MyCollectionViewController alloc]initWithCollectionViewLayout:layout];
    myVC.phAssetsArray = [assetsArr copy];
    UINavigationController* nav = [[UINavigationController alloc]initWithRootViewController:myVC];
    [self presentViewController:nav animated:YES completion:nil];
    
}


- (void)selectedPhotoAsset:(NSNotification *)noti {
    PHAsset* asset = noti.object;
    
    if (asset) {
        __weak __typeof(self) weakSelf = self;
        [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:self.view.bounds.size contentMode:PHImageContentModeAspectFill options:NULL resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            if (result) {
                weakSelf.photoImageView.image = result;
            }
        }];
    }
    
}




@end
