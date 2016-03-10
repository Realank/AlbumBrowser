//
//  PhotoPreviewViewController.m
//  AlbumBrowser
//
//  Created by Realank on 16/3/10.
//  Copyright © 2016年 iMooc. All rights reserved.
//

#import "PhotoPreviewViewController.h"
#import <Photos/Photos.h>

@interface PhotoPreviewViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;

@end

@implementation PhotoPreviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self displayPhoto];
    UISwipeGestureRecognizer* swipeGesLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeToChangePhotos:)];
    swipeGesLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    UISwipeGestureRecognizer* swipeGesRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeToChangePhotos:)];
    swipeGesRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self.photoImageView addGestureRecognizer:swipeGesLeft];
    [self.photoImageView addGestureRecognizer:swipeGesRight];
    
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:@"选择" style:UIBarButtonItemStylePlain target:self action:@selector(selectPhoto)]];
}

- (void)swipeToChangePhotos:(UISwipeGestureRecognizer*)sender {
    if (sender.direction & UISwipeGestureRecognizerDirectionRight) {
        if (self.photoIndex > 0) {
            self.photoIndex--;
            [self displayPhoto];
        }
    }else if (sender.direction & UISwipeGestureRecognizerDirectionLeft) {
        if (self.photoIndex < self.phAssetsArray.count - 1) {
            self.photoIndex++;
            [self displayPhoto];
        }
    }
}

- (void)displayPhoto {
    
    if (self.phAssetsArray.count == 0) {
        return;
    }
    if (self.photoIndex < 0) {
        self.photoIndex = 0;
    }else if (self.photoIndex >= self.phAssetsArray.count) {
        self.photoIndex = self.phAssetsArray.count - 1;
    }
    
    PHAsset* asset = [self.phAssetsArray objectAtIndex:self.photoIndex];
    if (asset) {
         __weak __typeof(self) weakSelf = self;
        [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:self.view.bounds.size contentMode:PHImageContentModeAspectFill options:NULL resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            if (result) {
                weakSelf.photoImageView.image = result;
            }
        }];
    }
    
}

- (void)selectPhoto {
    if (self.phAssetsArray.count == 0) {
        return;
    }
    if (self.photoIndex < 0) {
        self.photoIndex = 0;
    }else if (self.photoIndex >= self.phAssetsArray.count) {
        self.photoIndex = self.phAssetsArray.count - 1;
    }
    
    PHAsset* asset = [self.phAssetsArray objectAtIndex:self.photoIndex];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PhotoSelectedNotification" object:asset];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
