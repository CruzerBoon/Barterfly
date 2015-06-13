//
//  LoginViewController.h
//  Barterfly
//
//  Created by Mun Fai Leong on 6/13/15.
//  Copyright (c) 2015 angelhack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "azureMobileService.h"
#import "AICommonUtils.h"

@interface LoginViewController : UIViewController <UIActionSheetDelegate, AzureMobileServiceDelegate>
{
    azureMobileService *mobileService;
}

@property (weak, nonatomic) IBOutlet UIButton *LoginButton;


@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


- (IBAction)Login:(id)sender;

@end

