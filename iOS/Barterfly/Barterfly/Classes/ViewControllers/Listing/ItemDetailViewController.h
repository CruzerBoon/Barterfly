//
//  ItemDetailViewController.h
//  Barterfly
//
//  Created by Mun Fai Leong on 6/13/15.
//  Copyright (c) 2015 angelhack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AICommonUtils.h"
#import "azureMobileService.h"

@interface ItemDetailViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate, GBEmptyViewDelegate, UIWebViewDelegate, AzureMobileServiceDelegate>
{
    LoadingScreen *screen;
    azureMobileService *mobileService;
}

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;

/* Summary view */

@property (weak, nonatomic) IBOutlet UIView *summaryContentView;
@property (retain, nonatomic) IBOutlet UIImageView *summary_itemImageView;
@property (retain, nonatomic) IBOutlet UIImageView *summary_userImageView;
@property (retain, nonatomic) IBOutlet UILabel *summary_itemDescription;

@property (retain, nonatomic) IBOutlet UIView *summary_creditView;

@property (retain, nonatomic) IBOutlet UILabel *summary_creditValueLabel;

@property (retain, nonatomic) IBOutlet UILabel *summary_creditTitleLabel;

/* DETAILS VIEW */

@property (weak, nonatomic) IBOutlet UIView *detailsContentView;

@property (weak, nonatomic) IBOutlet UIImageView *details_itemImageView;

@property (weak, nonatomic) IBOutlet UIScrollView *details_scrollView;
@property (weak, nonatomic) IBOutlet UIView *details_scrollContentView;

@property (weak, nonatomic) IBOutlet UITextField *details_itemNameField;
@property (weak, nonatomic) IBOutlet UITextField *details_itemExpiredDateFied;
@property (weak, nonatomic) IBOutlet UITextField *details_itemBrandField;
@property (weak, nonatomic) IBOutlet UITextField *details_itemPurchasedDateField;
@property (weak, nonatomic) IBOutlet UITextField *details_itemReasonField;


/* PHOTO VIEW */

@property (weak, nonatomic) IBOutlet UIView *photoContentView;
@property (weak, nonatomic) IBOutlet UIImageView *photo_displayImageView;
@property (weak, nonatomic) IBOutlet UILabel *photo_morePhotoLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *photo_collectionView;


@property (nonatomic) NSMutableDictionary *itemDictionary;


- (IBAction)segmentedControlSelectedView:(id)sender;
- (IBAction)showDetailMapping:(id)sender;

@end
