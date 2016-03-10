//
//  MyCollectionViewController.m
//  dfdf
//
//  Created by Realank on 16/3/9.
//  Copyright © 2016年 iMooc. All rights reserved.
//

#import "MyCollectionViewController.h"

#import "MyCollectionViewCell.h"

@interface MyCollectionViewController ()

@end

@implementation MyCollectionViewController

static NSString * const reuseIdentifier = @"MyCollectionViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes

    [self.collectionView registerNib:[UINib nibWithNibName:reuseIdentifier bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];

    self.collectionView.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    
    self.title = @"选择图片";
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(dismissSelf)]];
}

- (void)dismissSelf {
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.phAssetsArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.asset = [self.phAssetsArray objectAtIndex:indexPath.row];
    
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    PHAsset* asset = [self.phAssetsArray objectAtIndex:indexPath.row];
    if (asset && self.photoSelectDelegate ) {
        [self.photoSelectDelegate selectedPhtotAsset:asset];
    }
    [self dismissSelf];
}




@end
