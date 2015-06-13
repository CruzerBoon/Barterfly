//
//  ProfileViewController.m
//  Barterfly
//
//  Created by Mun Fai Leong on 6/13/15.
//  Copyright (c) 2015 angelhack. All rights reserved.
//

#import "ProfileViewController.h"

@interface ProfileViewController ()
{
    MSUser *currentUser;
}
@end

@implementation ProfileViewController

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

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    
}

-(void)initializeStartingVariable
{
    [self setDesign];
    
    [self initAzureClient];
}

-(void)setDesign
{
    self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.height / 2;
    self.profileImageView.clipsToBounds = YES;
    
    self.profileUserName.font = [AICommonUtils getCustomTypeface:fontHelveticaNeue ofSize:16.0];
    self.profileUserName.attributedText = [AICommonUtils createStringWithSpacing:self.profileUserName.text spacngValue:2.0 withUnderLine:NO];
    
    self.creditBalance.font = [AICommonUtils getCustomTypeface:fontHelveticaNeueThin ofSize:self.creditBalance.font.pointSize];
    self.creditBalanceTitle.font = [AICommonUtils getCustomTypeface:fontHelveticaNeue ofSize:self.creditBalanceTitle.font.pointSize];
    self.creditBalanceTitle.attributedText = [AICommonUtils createStringWithSpacing:self.creditBalanceTitle.text spacngValue:4.0 withUnderLine:NO];
    
    self.buyCreditButton.titleLabel.font = [AICommonUtils getCustomTypeface:fontHelveticaNeue ofSize:12.0];
    self.buyCreditButton.titleLabel.attributedText = [AICommonUtils createStringWithSpacing:self.buyCreditButton.titleLabel.text spacngValue:4.0 withUnderLine:NO];
    
    self.logoutButton.titleLabel.font = [AICommonUtils getCustomTypeface:fontHelveticaNeue ofSize:12.0];
    self.logoutButton.titleLabel.attributedText = [AICommonUtils createStringWithSpacing:self.logoutButton.titleLabel.text spacngValue:4.0 withUnderLine:NO];
}

-(void)initAzureClient
{
    mobileService = [[azureMobileService alloc]initAzureClient];
    mobileService.delegate = self;
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)BuyCredit:(id)sender
{
}

- (IBAction)Logout:(id)sender
{
    azureAuthentication *authentication = [[azureAuthentication alloc]init];
    
    azureMobileService *azure = [[azureMobileService alloc]initAzureClient];
    azure.delegate = self;
    azure.client.currentUser  = [authentication loadAuthenticationInfoWithUserForClient];
    
    [azure logoutAzureClient];

    
    [azureAuthentication deletePassword];
    
    UIViewController *rootVC = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:@"LoginViewController"];
    [self presentViewController:rootVC animated:YES completion:nil];
    
}

#pragma mark - Azure Mobile Service Delegate

-(void)azureMobileServiceDidFinishGetData:(id)object
{
    NSDictionary *dictionary = (NSDictionary *)object;
    
    NSLog(@"read: %@", dictionary);
}

@end
