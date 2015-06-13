//
//  FeaturedViewController.h
//  Barterfly
//
//  Created by Mun Fai Leong on 6/13/15.
//  Copyright (c) 2015 angelhack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeaturedViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>


@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollVIew;


@property (weak, nonatomic) IBOutlet UICollectionView *featuredCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *latestCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *mostPopularCollectionView;


@end