//
//  FeaturedViewController.h
//  Barterfly
//
//  Created by Mun Fai Leong on 6/13/15.
//  Copyright (c) 2015 angelhack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AICommonUtils.h"
#import "azureMobileService.h"

@interface FeaturedViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate, AzureMobileServiceDelegate>
{
    LoadingScreen *screen;
}

@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollVIew;


@property (weak, nonatomic) IBOutlet UICollectionView *featuredCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *latestCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *mostPopularCollectionView;

@property (weak, nonatomic) IBOutlet UIButton *latestSeeMoreButton;

@property (weak, nonatomic) IBOutlet UIButton *popularSeeMoreButton;

@property (weak, nonatomic) IBOutlet UILabel *latestTitleLabel;

@property (weak, nonatomic) IBOutlet UILabel *popularTitleLabel;


@end