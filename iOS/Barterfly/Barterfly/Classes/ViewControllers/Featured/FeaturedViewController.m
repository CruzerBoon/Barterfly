//
//  FeaturedViewController.m
//  Barterfly
//
//  Created by Mun Fai Leong on 6/13/15.
//  Copyright (c) 2015 angelhack. All rights reserved.
//

#import "FeaturedViewController.h"

@interface FeaturedViewController ()

@end

@implementation FeaturedViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initializeStartingVariable];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initializeStartingVariable
{
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
    
    
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


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
            
            imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 230, 135)];
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
            
            
            titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 100, 80, 45)];
            titleLabel.tag = 1;
            titleLabel.textAlignment = NSTextAlignmentCenter;
            titleLabel.font = [UIFont systemFontOfSize:12];
            titleLabel.numberOfLines = 2;
            titleLabel.text = @"FirstName\nLastName";
            [cell addSubview:titleLabel];
            [titleLabel sizeToFit];
            titleLabel.frame = CGRectMake((100 - titleLabel.frame.size.width) / 2, titleLabel.frame.origin.y, titleLabel.frame.size.width, titleLabel.frame.size.height);
            
            imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 80, 80)];
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
            
            
            titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 100, 80, 45)];
            titleLabel.tag = 1;
            titleLabel.textAlignment = NSTextAlignmentCenter;
            titleLabel.font = [UIFont systemFontOfSize:12];
            titleLabel.numberOfLines = 2;
            titleLabel.text = @"FirstName\nLastName";
            [cell addSubview:titleLabel];
            [titleLabel sizeToFit];
            titleLabel.frame = CGRectMake((100 - titleLabel.frame.size.width) / 2, titleLabel.frame.origin.y, titleLabel.frame.size.width, titleLabel.frame.size.height);
            
            imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 80, 80)];
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
    UICollectionViewCell *cell;
    
    
    
    cell = [collectionView cellForItemAtIndexPath:indexPath];
    
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

@end
