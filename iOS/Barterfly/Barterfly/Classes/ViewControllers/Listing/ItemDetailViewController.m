//
//  ItemDetailViewController.m
//  Barterfly
//
//  Created by Mun Fai Leong on 6/13/15.
//  Copyright (c) 2015 angelhack. All rights reserved.
//

#import "ItemDetailViewController.h"

//.net backend
#define APP_URL @"http://angelhack2015.azurewebsites.net/"

@interface ItemDetailViewController ()
{
    EmptyViewWithPullDownGesture *emptyView;
    UIWebView *web;
    
    NSMutableArray *photoArray;
}

@end

@implementation ItemDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initializeStartingVariable];
    
    NSLog(@"obj: %@", self.itemDictionary);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initializeStartingVariable
{
    photoArray = [[NSMutableArray alloc]init];
    
    self.summary_itemImageView.layer.cornerRadius = self.summary_itemImageView.frame.size.height / 7;
    self.summary_itemImageView.clipsToBounds = YES;
    
    self.summary_userImageView.layer.cornerRadius = self.summary_userImageView.frame.size.height / 2;
    self.summary_userImageView.clipsToBounds = YES;
    
    self.summary_itemDescription.font = [AICommonUtils getCustomTypeface:fontHelveticaNeue ofSize:16.0];
    self.summary_itemDescription.attributedText = [AICommonUtils createStringWithSpacing:self.summary_itemDescription.text spacngValue:0 withUnderLine:NO];
    self.summary_itemDescription.numberOfLines = 0;
    self.summary_itemDescription.layer.cornerRadius = self.summary_itemDescription.frame.size.height / 10;
    self.summary_itemDescription.clipsToBounds = YES;
    self.summary_itemDescription.backgroundColor = [AICommonUtils getAIColorWithRGB0_32_44:0.1];
    [self.summary_itemDescription sizeToFit];
    
    self.summary_creditView.layer.cornerRadius = self.summary_creditView.frame.size.height / 2;
    self.summary_creditView.clipsToBounds = YES;
    
    self.summary_creditValueLabel.font = [AICommonUtils getCustomTypeface:fontHelveticaNeue ofSize:30];
    self.summary_creditValueLabel.textColor = [AICommonUtils getAIColorWithRGB000:1];
    self.summary_creditValueLabel.adjustsFontSizeToFitWidth = YES;
    
    self.summary_creditTitleLabel.text = @"Credit\nPoint";
    self.summary_creditTitleLabel.font = [AICommonUtils getCustomTypeface:fontHelveticaNeue ofSize:12];
    self.summary_creditTitleLabel.textColor = [AICommonUtils getAIColorWithRGB000:0.5];
    self.summary_creditTitleLabel.attributedText = [AICommonUtils createStringWithSpacing:self.summary_creditTitleLabel.text spacngValue:2.0 withUnderLine:NO];
    
    for (id object in self.details_scrollContentView.subviews)
    {
        if ([object isKindOfClass:[UILabel class]])
        {
            UILabel *label = (UILabel *)object;
            label.font = [AICommonUtils getCustomTypeface:fontHelveticaNeue ofSize:16];
            label.attributedText = [AICommonUtils createStringWithSpacing:label.text spacngValue:0 withUnderLine:NO];
            label.textColor = [AICommonUtils getAIColorWithRGB000:0.4];
        }
        
        else if ([object isKindOfClass:[UITextField class]])
        {
            UITextField *label = (UITextField *)object;
            label.font = [AICommonUtils getCustomTypeface:fontHelveticaNeue ofSize:16];
            label.attributedText = [AICommonUtils createStringWithSpacing:label.text spacngValue:0 withUnderLine:NO];
            label.textColor = [AICommonUtils getAIColorWithRGB000:0.69];
            label.userInteractionEnabled = NO;
        }
    }
    
    self.details_scrollContentView.backgroundColor = [AICommonUtils getAIColorWithRGB0_32_44:0.1];
    self.details_scrollContentView.layer.cornerRadius = self.details_scrollContentView.frame.size.height / 7;
    self.details_scrollContentView.clipsToBounds = YES;
    
    self.details_itemImageView.layer.cornerRadius = self.details_itemImageView.frame.size.height / 7;
    self.details_itemImageView.clipsToBounds = YES;
    
    self.photo_morePhotoLabel.font = [AICommonUtils getCustomTypeface:fontHelveticaNeue ofSize:12];
    self.photo_morePhotoLabel.attributedText = [AICommonUtils createStringWithSpacing:self.photo_morePhotoLabel.text spacngValue:0 withUnderLine:NO];
    self.photo_morePhotoLabel.textColor = [AICommonUtils getAIColorWithRGB000:0.4];
    
    self.photo_displayImageView.layer.cornerRadius = self.photo_displayImageView.frame.size.height / 7;
    self.photo_displayImageView.clipsToBounds = YES;
    
    self.photo_collectionView.delegate = self;
    self.photo_collectionView.dataSource = self;
    
    [self.photo_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"photo_collectionView"];
    
    [self initAzureClient];
    
    [self setDataIntoDisplay];
}

-(void)initAzureClient
{
    mobileService = [[azureMobileService alloc]initAzureClient];
    mobileService.delegate = self;
    
    [self getItemImage];
}

-(void)getItemImage
{
    [mobileService getSingleItemUsingAPIForTableWithName:[AICommonUtils getAzureTableNameForTable:tableTradeItemImage] queryString:[NSString stringWithFormat:@"tradeItemId=%@", [self.itemDictionary objectForKey:@"id"]]];
    
    [self createLoadingScreen];
}

-(void)setDataIntoDisplay
{
    self.summary_userImageView.image = [AICommonUtils getImageFromUrl:[self.itemDictionary objectForKey:@"userProfileImg"]];
    
    self.summary_itemDescription.text = [NSString stringWithFormat:@"Item Name\n%@\n\nTrader\n%@\n\nCategory\n%@", [self.itemDictionary objectForKey:@"name"], [self.itemDictionary objectForKey:@"userName"], [AICommonUtils getCategoryNameForId:[[self.itemDictionary objectForKey:@"category"] integerValue]]];
    
    [self.summary_itemDescription sizeToFit];
    
    self.summary_creditValueLabel.text = [NSString stringWithFormat:@"%@", [self.itemDictionary objectForKey:@"creditpointFloor"]];
    
    NSString *tempDateString = [NSString stringWithFormat:@"%@", [self.itemDictionary objectForKey:@"postExpireDate"]];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy-mm-dd";
    
    NSDate *tempDate = [formatter dateFromString:tempDateString];
    
    self.details_itemNameField.text = [NSString stringWithFormat:@"%@", [self.itemDictionary objectForKey:@"name"]];
    self.details_itemBrandField.text = [NSString stringWithFormat:@"%@", [self.itemDictionary objectForKey:@"condition"]];
    self.details_itemExpiredDateFied.text = [NSString stringWithFormat:@"%@", tempDate];
    self.details_itemPurchasedDateField.text = [NSString stringWithFormat:@"$%.2f", [[self.itemDictionary objectForKey:@"purchasePrice"] doubleValue]];
    self.details_itemReasonField.text = [NSString stringWithFormat:@"%@", [self.itemDictionary objectForKey:@"exchangeMethod"]];

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

- (IBAction)showDetailMapping:(id)sender
{
    emptyView = [[EmptyViewWithPullDownGesture alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - self.tabBarController.tabBar.frame.size.height)];
    emptyView.delegate = self;
    
    web = [[UIWebView alloc]initWithFrame:CGRectMake(20, 20, emptyView.frame.size.width - 40, emptyView.frame.size.height - 40)];
    //web.layer.cornerRadius = web.frame.size.height / 12;
    //web.clipsToBounds = YES;
    web.delegate = self;
    [self initializeWebView];
    
    [emptyView addSubview:web];
    
    [self.view addSubview:emptyView];
}

-(void)initializeWebView
{
    NSString *webURL = [NSString stringWithFormat:@"%@#%@", APP_URL, [self.itemDictionary objectForKey:@"id"]];
    
    NSLog(@"%@", webURL);
    
    NSURL *url = [NSURL URLWithString:webURL];
    
    [web loadRequest:[NSURLRequest requestWithURL:url]];
}




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
            imageView.image = [AICommonUtils getImageFromUrl:[[photoArray objectAtIndex:indexPath.row] objectForKey:@"imgUrl"]];
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



#pragma mark - empty view delegate

-(void)didDismissEmptyView
{
    [UIView animateWithDuration:0.5 animations:^{
        emptyView.alpha = 0;
    }completion:^(BOOL finished){
        [emptyView removeFromSuperview];
        emptyView = nil;
    }];
}

#pragma mark - UIWebView Delegate

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [self createLoadingScreen];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self dismissLoadingScreen];
    
    [self initializeWebView];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self dismissLoadingScreen];
}



#pragma mark - Azure Mobile Service Delegate

-(void)azureMobileServiceDidFinishGetDataForList:(id)object
{
    
}

-(void)azureMobileServiceDidFinishGetDataForSingleItem:(id)object
{
    NSArray *tempdic = (NSArray *)object;
    
    NSLog(@"result: %@", tempdic);
    
    [self dismissLoadingScreen];
    
    self.summary_itemImageView.image = [AICommonUtils getImageFromUrl:[[tempdic objectAtIndex:0] objectForKey:@"imgUrl"]];
    self.details_itemImageView.image = self.photo_displayImageView.image = self.summary_itemImageView.image;
    
    [photoArray addObjectsFromArray:tempdic];
    
    [self.photo_collectionView reloadData];
}

-(void)azureMobileServiceDidFailWithError:(NSError *)error
{
    [self dismissLoadingScreen];
}

@end
