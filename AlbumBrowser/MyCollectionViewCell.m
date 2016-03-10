//
//  MyCollectionViewCell.m
//  dfdf
//
//  Created by Realank on 16/3/9.
//  Copyright © 2016年 iMooc. All rights reserved.
//

#import "MyCollectionViewCell.h"
#import <Photos/Photos.h>

@interface MyCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;

@end


@implementation MyCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setAsset:(PHAsset *)asset {
    _asset = asset;
    
    [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:CGSizeMake(300, 300) contentMode:PHImageContentModeAspectFill options:NULL resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        if (result) {
            self.photoImageView.image = result;
        }
        
    }];
}

@end
