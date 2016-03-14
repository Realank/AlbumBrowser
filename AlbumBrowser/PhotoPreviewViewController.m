//
//  PhotoPreviewViewController.m
//  AlbumBrowser
//
//  Created by Realank on 16/3/10.
//  Copyright © 2016年 iMooc. All rights reserved.
//

#import "PhotoPreviewViewController.h"
#import <Photos/Photos.h>

@interface PhotoPreviewViewController () <UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;

@end

@implementation PhotoPreviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self displayPhoto];
    UISwipeGestureRecognizer* swipeGesLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeToChangePhotos:)];
    swipeGesLeft.numberOfTouchesRequired = 1;
    swipeGesLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    
    
    UISwipeGestureRecognizer* swipeGesRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeToChangePhotos:)];
    swipeGesRight.numberOfTouchesRequired = 1;
    swipeGesRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self.photoImageView addGestureRecognizer:swipeGesLeft];
    [self.photoImageView addGestureRecognizer:swipeGesRight];
    
    UILongPressGestureRecognizer* longPressGes = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressPic)];
    [self.photoImageView addGestureRecognizer:longPressGes];

    
    UIPanGestureRecognizer* panGes = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGes)];
    panGes.minimumNumberOfTouches = 2;
    [self.photoImageView addGestureRecognizer:panGes];
    
    
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:@"选择" style:UIBarButtonItemStylePlain target:self action:@selector(selectPhoto)]];
}

- (void)panGes {
    NSLog(@"pan");
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

- (void) longPressPic {
    
    NSString* message = [NSString stringWithFormat:@"%.1f x %.1f",self.photoImageView.image.size.width, self.photoImageView.image.size.height];
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"图片大小" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* action = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
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
