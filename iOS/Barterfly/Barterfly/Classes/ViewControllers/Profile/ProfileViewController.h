//
//  ProfileViewController.h
//  Barterfly
//
//  Created by Mun Fai Leong on 6/13/15.
//  Copyright (c) 2015 angelhack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "azureMobileService.h"
#import "AICommonUtils.h"

@interface ProfileViewController : UIViewController <AzureMobileServiceDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;

@property (weak, nonatomic) IBOutlet UILabel *profileUserName;


@property (weak, nonatomic) IBOutlet UILabel *creditBalance;
@property (weak, nonatomic) IBOutlet UILabel *creditBalanceTitle;

@property (weak, nonatomic) IBOutlet UIButton *buyCreditButton;

@property (weak, nonatomic) IBOutlet UIButton *logoutButton;


- (IBAction)BuyCredit:(id)sender;
- (IBAction)Logout:(id)sender;

@end
