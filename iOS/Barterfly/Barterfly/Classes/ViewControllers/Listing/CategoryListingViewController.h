//
//  CategoryListingViewController.h
//  Barterfly
//
//  Created by Mun Fai Leong on 6/13/15.
//  Copyright (c) 2015 angelhack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "azureMobileService.h"
#import "AICommonUtils.h"

@interface CategoryListingViewController : UIViewController <UISearchBarDelegate, UICollectionViewDelegate, UICollectionViewDataSource, AzureMobileServiceDelegate>
{
    azureMobileService *mobileService;
    LoadingScreen *screen;
    
    NSMutableArray *listinArray;
}

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end
