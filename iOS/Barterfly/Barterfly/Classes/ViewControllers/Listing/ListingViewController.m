//
//  ListingViewController.m
//  Barterfly
//
//  Created by Mun Fai Leong on 6/13/15.
//  Copyright (c) 2015 angelhack. All rights reserved.
//

#import "ListingViewController.h"

@interface ListingViewController ()
{
    NSMutableArray *optionsArray;
}
@end

@implementation ListingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initializeStartingVariable];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)initializeStartingVariable
{
    self.searchBar.delegate = self;
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"optionCollectionView"];
    
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"optionHeaderView"];
    
    optionsArray = [[NSMutableArray alloc]init];
    NSArray *tempArray = @[@"Notification", @"Charge", @"Sale", @"Reward", @"Offer", @"Identity\nVerification", @"Transfer"];
    [optionsArray addObjectsFromArray:tempArray];
}

/********** UICollectionView **********/

#pragma mark - UICollectionView Delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 5;
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
    
    if (collectionView == self.collectionView)
    {
        return CGSizeMake((collectionView.frame.size.width - 25)/5, (collectionView.frame.size.width - 25)/(5));
    }
    
    return CGSizeMake(10, 10);
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell;
    
    if (collectionView == self.collectionView)
    {
        UILabel *titleLabel;
        UIImageView *imageView;
        
        if (cell == nil)
        {
            cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"optionCollectionView" forIndexPath:indexPath];
            
            
            titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height)];
            titleLabel.tag = 1;
            titleLabel.textAlignment = NSTextAlignmentCenter;
            titleLabel.font = [UIFont systemFontOfSize:22];
            titleLabel.numberOfLines = 2;
            titleLabel.text = @"xxx";
            //[cell addSubview:titleLabel];
            
            
            imageView = [[UIImageView alloc]initWithFrame:titleLabel.frame];
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
    
    if (collectionView == self.collectionView)
    {
        if (indexPath.row == 0)
        {
            
        }
    }
    
    cell = [collectionView cellForItemAtIndexPath:indexPath];
    
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == self.collectionView)
    {
        if (kind == UICollectionElementKindSectionHeader)
        {
            UICollectionReusableView *reuseView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"optionHeaderView" forIndexPath:indexPath];
            
            if (reuseView == nil)
            {
                reuseView = [[UICollectionReusableView alloc]initWithFrame:CGRectMake(0, 0, collectionView.frame.size.width, 50)];
            }
            UILabel *headerTitle = (UILabel *)[reuseView viewWithTag:1];
            UIButton *seeMoreButton = (UIButton *)[reuseView viewWithTag:2];
            UILabel *sectionIndex = (UILabel *)[reuseView viewWithTag:11];
            
            if (!headerTitle)
            {
                headerTitle = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, collectionView.frame.size.width / 2, 50)];
                headerTitle.tag = 1;
                headerTitle.textAlignment = NSTextAlignmentLeft;
                headerTitle.textColor = [UIColor blackColor];
                headerTitle.font = [UIFont systemFontOfSize:12];
                
                [reuseView addSubview:headerTitle];
            }
            
            if (!sectionIndex)
            {
                sectionIndex = [[UILabel alloc]init];
                sectionIndex.tag = 11;
                sectionIndex.hidden = YES;
                
                
                [reuseView addSubview:sectionIndex];
            }
            
            if (!seeMoreButton)
            {
                seeMoreButton = [[UIButton alloc]initWithFrame:CGRectMake(collectionView.frame.size.width - 100, 0, 80, 50)];
                [seeMoreButton setTitle:@"SEE MORE" forState:UIControlStateNormal];
                [seeMoreButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                [seeMoreButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
                seeMoreButton.titleLabel.font = [UIFont systemFontOfSize:12];
                [seeMoreButton addTarget:self action:@selector(seeMore:) forControlEvents:UIControlEventTouchUpInside];
                
                [reuseView addSubview:seeMoreButton];
            }
            
            sectionIndex.text = [NSString stringWithFormat:@"%li", (long)indexPath.section];
            headerTitle.text = [NSString stringWithFormat:@"Section: %li", (long)indexPath.section];
            
            //reuseView.backgroundColor = [UIColor cyanColor];
            return reuseView;
        }
        else
            return nil;
        
    }
    else
        return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (collectionView == self.collectionView) {
        return CGSizeMake(collectionView.frame.size.width, 50);
    }
    
    return CGSizeZero;
}

-(void)seeMore:(UIButton *)button
{
    @try {
        UIView *tempView = button.superview;
        UILabel *sectionIndex = (UILabel *)[tempView viewWithTag:11];
        
        NSLog(@"section: %@", sectionIndex.text);
        
        [self performSegueWithIdentifier:@"nextToCategoryList" sender:self];
    }
    @catch (NSException *exception) {
        NSLog(@"exception: %@", exception.description);
    }
    @finally {
        
    }
}



-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    self.searchBar.showsCancelButton = YES;
}

-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    self.searchBar.showsCancelButton = NO;
    
    [self.searchBar resignFirstResponder];
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self.searchBar resignFirstResponder];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    
}

@end
