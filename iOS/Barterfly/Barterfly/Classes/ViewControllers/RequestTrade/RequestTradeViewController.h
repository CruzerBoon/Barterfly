//
//  RequestTradeViewController.h
//  Barterfly
//
//  Created by Mun Fai Leong on 6/13/15.
//  Copyright (c) 2015 angelhack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AICommonUtils.h"

@interface RequestTradeViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>



@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end
