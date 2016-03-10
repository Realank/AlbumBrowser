//
//  MyCollectionViewController.h
//  dfdf
//
//  Created by Realank on 16/3/9.
//  Copyright © 2016年 iMooc. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PHAsset;

@protocol PhotoSelectDelegate <NSObject>

- (void)selectedPhtotAsset:(PHAsset*)asset;

@end

@interface MyCollectionViewController : UICollectionViewController

@property (nonatomic, copy) NSArray *phAssetsArray;
@property (nonatomic, weak) id<PhotoSelectDelegate> photoSelectDelegate;
@end
