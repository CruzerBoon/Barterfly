//
//  ItemDetailViewController.m
//  Barterfly
//
//  Created by Mun Fai Leong on 6/13/15.
//  Copyright (c) 2015 angelhack. All rights reserved.
//

#import "ItemDetailViewController.h"

@interface ItemDetailViewController ()

@end

@implementation ItemDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initializeStartingVariable];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initializeStartingVariable
{
    self.summary_itemImageView.layer.cornerRadius = self.summary_itemImageView.frame.size.height / 7;
    self.summary_itemImageView.clipsToBounds = YES;
    
    self.summary_userImageView.layer.cornerRadius = self.summary_userImageView.frame.size.height / 2;
    self.summary_userImageView.clipsToBounds = YES;
    
    self.summary_itemDescription.font = [AICommonUtils getCustomTypeface:fontCourier ofSize:12.0];
    self.summary_itemDescription.attributedText = [AICommonUtils createStringWithSpacing:self.summary_itemDescription.text spacngValue:2.0 withUnderLine:NO];
    [self.summary_itemDescription sizeToFit];
    
    for (id object in self.details_scrollContentView.subviews)
    {
        if ([object isKindOfClass:[UILabel class]])
        {
            UILabel *label = (UILabel *)object;
            label.font = [AICommonUtils getCustomTypeface:fontCourier ofSize:12];
            label.attributedText = [AICommonUtils createStringWithSpacing:label.text spacngValue:2.0 withUnderLine:NO];
            label.textColor = [AICommonUtils getAIColorWithRGB000:0.4];
        }
        
        else if ([object isKindOfClass:[UITextField class]])
        {
            UITextField *label = (UITextField *)object;
            label.font = [AICommonUtils getCustomTypeface:fontCourier ofSize:12];
            label.attributedText = [AICommonUtils createStringWithSpacing:label.text spacngValue:2.0 withUnderLine:NO];
            label.textColor = [AICommonUtils getAIColorWithRGB000:0.69];
            label.userInteractionEnabled = NO;
        }
    }
    
    self.details_itemImageView.layer.cornerRadius = self.details_itemImageView.frame.size.height / 7;
    self.details_itemImageView.clipsToBounds = YES;
    
    self.photo_morePhotoLabel.font = [AICommonUtils getCustomTypeface:fontCourier ofSize:12];
    self.photo_morePhotoLabel.attributedText = [AICommonUtils createStringWithSpacing:self.photo_morePhotoLabel.text spacngValue:4.0 withUnderLine:NO];
    self.photo_morePhotoLabel.textColor = [AICommonUtils getAIColorWithRGB000:0.4];
    
    self.photo_displayImageView.layer.cornerRadius = self.photo_displayImageView.frame.size.height / 7;
    self.photo_displayImageView.clipsToBounds = YES;
    
    self.photo_collectionView.delegate = self;
    self.photo_collectionView.dataSource = self;
    
    [self.photo_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"photo_collectionView"];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)segmentedControlSelectedView:(id)sender
{
    UISegmentedControl *segment = (UISegmentedControl *)sender;
    
    if (segment.selectedSegmentIndex == 0)
    {
        self.summaryContentView.hidden = NO;
        self.detailsContentView.hidden = YES;
        self.photoContentView.hidden = YES;
    }
    else if (segment.selectedSegmentIndex == 1)
    {
        self.summaryContentView.hidden = YES;
        self.detailsContentView.hidden = NO;
        self.photoContentView.hidden = YES;
    }
    else if (segment.selectedSegmentIndex == 2)
    {
        self.summaryContentView.hidden = YES;
        self.detailsContentView.hidden = YES;
        self.photoContentView.hidden = NO;
    }
}


/********** UICollectionView **********/

#pragma mark - UICollectionView Delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 5;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 5;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == self.photo_collectionView)
    {
        return CGSizeMake(100, 100);
    }
    
    return CGSizeMake(10, 10);
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell;
    
    if (collectionView == self.photo_collectionView)
    {
        UIImageView *imageView;
        
        if (cell == nil)
        {
            cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"photo_collectionView" forIndexPath:indexPath];
            
            imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
            imageView.image = [UIImage imageNamed:@"barterCyan"];
            imageView.layer.cornerRadius = imageView.frame.size.height / 7;
            imageView.clipsToBounds = YES;
            
            [cell addSubview:imageView];
        }
    }
    
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
}



@end
