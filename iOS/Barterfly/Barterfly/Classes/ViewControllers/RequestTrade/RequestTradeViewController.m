//
//  RequestTradeViewController.m
//  Barterfly
//
//  Created by Mun Fai Leong on 6/13/15.
//  Copyright (c) 2015 angelhack. All rights reserved.
//

#import "RequestTradeViewController.h"

@interface RequestTradeViewController ()
{
    NSMutableArray *photoArray;
}
@end

@implementation RequestTradeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initializeStartingVariable];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self initializeStartingVariable];
    
    [self.collectionView reloadData];
}

-(void)initializeStartingVariable
{
    photoArray = [[NSMutableArray alloc]init];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"optionCollectionView"];
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
    if ([photoArray count] < 10)
        return [photoArray count] + 1;
    else
        return [photoArray count];
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
    
    if (collectionView == self.collectionView)
    {
        CGFloat size = (collectionView.frame.size.width - 25)/5;
        return CGSizeMake(150, 150);
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
            
            if (indexPath.row == 0 && [photoArray count] < 10)
            {
                cell.layer.borderWidth = 0.5;
                cell.layer.borderColor = [UIColor lightGrayColor].CGColor;
            }
            else
            {
                cell.layer.borderWidth = 0;
                cell.layer.borderColor = [UIColor clearColor].CGColor;
            }
            
            titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 150, 150)];
            titleLabel.tag = 11;
            titleLabel.textAlignment = NSTextAlignmentCenter;
            titleLabel.font = [UIFont systemFontOfSize:12];
            titleLabel.numberOfLines = 2;
            
            imageView = [[UIImageView alloc]initWithFrame:titleLabel.frame];
            //imageView.image = [UIImage imageNamed:@"barterCyan"];
            imageView.layer.cornerRadius = imageView.frame.size.height / 7;
            imageView.clipsToBounds = YES;
            imageView.tag = 2;
            
            [cell addSubview:titleLabel];
            [cell addSubview:imageView];
        }
        
        
        titleLabel = (UILabel *)[cell viewWithTag:11];
        imageView = (UIImageView *)[cell viewWithTag:2];
        
        
        if (indexPath.row == 0 && [photoArray count] < 10)
        {
            imageView.hidden = YES;
            titleLabel.hidden = NO;
            titleLabel.text = @"ADD\nPHOTO";
        }
        else
        {
            NSInteger number = indexPath.row;
            
            if ([photoArray count] < 10)
                number = indexPath.row - 1;
            
            imageView.image = (UIImage *)[photoArray objectAtIndex:number];
            imageView.hidden = NO;
            titleLabel.hidden = YES;
            titleLabel.text = @"xxx";
        }
    }
    
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == self.collectionView)
    {
        if (indexPath.row == 0 && [photoArray count] < 10)
        {
            [photoArray addObject:[UIImage imageNamed:@"barterCyan"]];
            
            [self.collectionView reloadData];
        }
    }
    
    
    
}

@end
