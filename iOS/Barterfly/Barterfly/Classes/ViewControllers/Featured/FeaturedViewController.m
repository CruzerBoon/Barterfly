//
//  FeaturedViewController.m
//  Barterfly
//
//  Created by Mun Fai Leong on 6/13/15.
//  Copyright (c) 2015 angelhack. All rights reserved.
//

#import "FeaturedViewController.h"

@interface FeaturedViewController ()
{
    azureMobileService *mobileService;
}
@end

@implementation FeaturedViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initializeStartingVariable];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self getData];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self dismissLoadingScreen];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initializeStartingVariable
{
    self.popularSeeMoreButton.titleLabel.font = [AICommonUtils getCustomTypeface:fontHelveticaNeue ofSize:12];
    self.popularSeeMoreButton.titleLabel.attributedText = [AICommonUtils createStringWithSpacing:self.popularSeeMoreButton.titleLabel.text spacngValue:0 withUnderLine:NO];
    
    self.latestSeeMoreButton.titleLabel.font = [AICommonUtils getCustomTypeface:fontHelveticaNeue ofSize:12];
    self.latestSeeMoreButton.titleLabel.attributedText = [AICommonUtils createStringWithSpacing:self.latestSeeMoreButton.titleLabel.text spacngValue:0 withUnderLine:NO];
    
    self.latestTitleLabel.attributedText = [AICommonUtils createStringWithSpacing:self.latestTitleLabel.text spacngValue:0 withUnderLine:NO];
    self.popularTitleLabel.attributedText = [AICommonUtils createStringWithSpacing:self.popularTitleLabel.text spacngValue:0 withUnderLine:NO];
    self.latestTitleLabel.font = [AICommonUtils getCustomTypeface:fontHelveticaNeue ofSize:self.latestTitleLabel.font.pointSize];
    self.popularTitleLabel.font = [AICommonUtils getCustomTypeface:fontHelveticaNeue ofSize:self.popularTitleLabel.font.pointSize];
    
    self.featuredCollectionView.delegate = self;
    self.featuredCollectionView.dataSource = self;
    
    self.latestCollectionView.delegate = self;
    self.latestCollectionView.dataSource = self;
    
    self.mostPopularCollectionView.delegate = self;
    self.mostPopularCollectionView.dataSource = self;
    
    [self.featuredCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"featuredCollectionView"];
    
    //[self.featuredCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"featuredCollectionViewHeader"];
    
    
    [self.latestCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"latestCollectionView"];
    
    //[self.latestCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"latestCollectionViewHeader"];
    
    [self.mostPopularCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"mostPopularCollectionView"];
    
    //[self.mostPopularCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"mostPopularCollectionViewHeader"];
    
    [self initAzureClient];
}

-(void)initAzureClient
{
    mobileService = [[azureMobileService alloc]initAzureClient];
    mobileService.delegate = self;

}

-(void)getData
{
    [mobileService getFullListingItemForTableWithName:[AICommonUtils getAzureTableNameForTable:tableAllTradeItem]];
    
    [self createLoadingScreen];
}

-(void)getItemImage:(NSMutableArray *)array
{
    NSMutableDictionary *tempdic = [[NSMutableDictionary alloc]init];
    tempdic = [[array objectAtIndex:0] mutableCopy];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:[tempdic objectForKey:@"id"] forKey:@"id"];
    
    [mobileService getSingleItemUsingAPIForTableWithName:[AICommonUtils getAzureTableNameForTable:tableTradeItemImage] queryString:[NSString stringWithFormat:@"tradeItemId=%@", [tempdic objectForKey:@"id"]]];
    
    [self createLoadingScreen];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */



-(void)createLoadingScreen
{
    if (!screen)
    {
        screen = [[LoadingScreen alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) forSuperView:self.view atTarget:self];
        screen.backgroundColor = [AICommonUtils getAIColorWithRGB0_32_44:0.4];
        [self.view addSubview:screen];
    }
}

-(void)dismissLoadingScreen
{
    if (screen)
    {
        [UIView animateWithDuration:0.5 animations:^{
            screen.alpha = 0;
        }completion:^(BOOL finished){
            [screen removeFromSuperview];
            screen = nil;
        }];
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
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (collectionView == self.featuredCollectionView)
    {
        return CGSizeMake(250, 155);
    }
    else if (collectionView == self.latestCollectionView || collectionView == self.mostPopularCollectionView)
    {
        return CGSizeMake(100, 155);
    }
    
    return CGSizeMake(10, 10);
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell;
    
    if (collectionView == self.featuredCollectionView)
    {
        UIImageView *imageView;
        
        if (cell == nil)
        {
            cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"featuredCollectionView" forIndexPath:indexPath];
            
            imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, 230, 155)];
            imageView.image = [UIImage imageNamed:@"barterWide"];
            imageView.layer.cornerRadius = imageView.frame.size.height / 9;
            imageView.clipsToBounds = YES;
            
            [cell addSubview:imageView];
        }
        
        
    }
    else if (collectionView == self.latestCollectionView)
    {
        UILabel *titleLabel;
        UIImageView *imageView;
        
        if (cell == nil)
        {
            cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"latestCollectionView" forIndexPath:indexPath];
            
            
            titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 90, 80, 45)];
            titleLabel.tag = 1;
            titleLabel.textAlignment = NSTextAlignmentCenter;
            titleLabel.text = @"FirstName\nLastName";
            titleLabel.font = [AICommonUtils getCustomTypeface:fontHelveticaNeue ofSize:12];
            titleLabel.textColor = [AICommonUtils getAIColorWithRGB000:0.4];
            titleLabel.attributedText = [AICommonUtils createStringWithSpacing:titleLabel.text spacngValue:0 withUnderLine:NO];
            titleLabel.numberOfLines = 2;
            [cell addSubview:titleLabel];
            [titleLabel sizeToFit];
            titleLabel.frame = CGRectMake((100 - titleLabel.frame.size.width) / 2, titleLabel.frame.origin.y, titleLabel.frame.size.width, titleLabel.frame.size.height);
            
            imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, 80, 80)];
            imageView.image = [UIImage imageNamed:@"barterCyan"];
            imageView.layer.cornerRadius = imageView.frame.size.height / 7;
            imageView.clipsToBounds = YES;
            
            [cell addSubview:imageView];
        }
    }
    else if (collectionView == self.mostPopularCollectionView)
    {
        UILabel *titleLabel;
        UIImageView *imageView;
        
        if (cell == nil)
        {
            cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"mostPopularCollectionView" forIndexPath:indexPath];
            
            
            titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 90, 80, 45)];
            titleLabel.tag = 1;
            titleLabel.textAlignment = NSTextAlignmentCenter;
            titleLabel.text = @"FirstName\nLastName";
            titleLabel.font = [AICommonUtils getCustomTypeface:fontHelveticaNeue ofSize:12];
            titleLabel.textColor = [AICommonUtils getAIColorWithRGB000:0.4];
            titleLabel.attributedText = [AICommonUtils createStringWithSpacing:titleLabel.text spacngValue:0 withUnderLine:NO];
            titleLabel.numberOfLines = 2;
            [cell addSubview:titleLabel];
            [titleLabel sizeToFit];
            titleLabel.frame = CGRectMake((100 - titleLabel.frame.size.width) / 2, titleLabel.frame.origin.y, titleLabel.frame.size.width, titleLabel.frame.size.height);
            
            imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, 80, 80)];
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
    
    [AICommonUtils navigateToItemDetailsPageWithNavigationController:self.navigationController forDictionary:nil];
}




-(void)seeMore:(UIButton *)button
{
    @try {
        UIView *tempView = button.superview;
        UILabel *sectionIndex = (UILabel *)[tempView viewWithTag:11];
        
        NSLog(@"section: %@", sectionIndex.text);
    }
    @catch (NSException *exception) {
        NSLog(@"exception: %@", exception.description);
    }
    @finally {
        
    }
}


#pragma mark - Azure Mobile Service Delegate

-(void)azureMobileServiceDidFinishGetDataForList:(id)object
{
    NSMutableArray *tempArray = (NSMutableArray *)object;
    
    NSLog(@"result featured: %@", tempArray);
    
    [self dismissLoadingScreen];

}

-(void)azureMobileServiceDidFinishGetDataForSingleItem:(id)object
{
    NSDictionary *tempdic = (NSDictionary *)object;
    
    NSLog(@"result featuredSingleItem: %@", tempdic);
    
    [self dismissLoadingScreen];
}


-(void)azureMobileServiceDidFailWithError:(NSError *)error
{
    [self dismissLoadingScreen];
}


@end
