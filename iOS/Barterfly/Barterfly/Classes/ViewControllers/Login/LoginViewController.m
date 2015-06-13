//
//  LoginViewController.m
//  Barterfly
//
//  Created by Mun Fai Leong on 6/13/15.
//  Copyright (c) 2015 angelhack. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

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
    self.LoginButton.titleLabel.font = [AICommonUtils getCustomTypeface:fontCourier ofSize:16.0];
    
    self.LoginButton.titleLabel.attributedText = [AICommonUtils createStringWithSpacing:self.LoginButton.titleLabel.text spacngValue:4.0 withUnderLine:NO];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)Login:(id)sender
{
    //    [self redirectToDashboard];
    //    return;
    
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:@"Login using" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Facebook"/*, @"Microsoft Account", @"Google", @"Twitter"*/, nil];
    
    [sheet showInView:self.view];
}

-(void)redirectToDashboard
{
    UIViewController *rootVC = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:@"dashboardTabbarController"];
    [self presentViewController:rootVC animated:YES completion:nil];
}

-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    mobileService = [[azureMobileService alloc]initAzureClient];
    mobileService.delegate = self;
    
    AuthenticationType tempType = authenticationTypeFacebook;
    
    
    if (buttonIndex == 0)
    {
        tempType = authenticationTypeFacebook;
    }
    else if (buttonIndex == 1)
    {
        tempType = authenticationTypeMicrosoftAccount;
    }
    else if (buttonIndex == 2)
    {
        tempType = authenticationTypeGoogle;
    }
    else if (buttonIndex == 3)
    {
        tempType = authenticationTypeTwitter;
    }
    
    if (buttonIndex== 0)
        [mobileService authenticateLoginForUser:mobileService.client atTarget:self forAuthenticationType:tempType];
}

-(void)azureMobileServiceDidSuccessAuthenticating
{
    [self redirectToDashboard];
}
@end
