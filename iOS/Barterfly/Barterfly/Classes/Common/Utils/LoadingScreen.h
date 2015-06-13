//
//  LoadingScreen.h
//  Barterfly
//
//  Created by Mun Fai Leong on 6/13/15.
//  Copyright (c) 2015 angelhack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AICommonUtils.h"

@protocol LoadingScreenDelete;

@interface LoadingScreen : UIView

@property (nonatomic, assign) id <LoadingScreenDelete> delegate;

@property (nonatomic) UIView *mySuperView;

-(instancetype)initWithFrame:(CGRect)frame forSuperView:(UIView *)view atTarget:(id)target;

@end


@protocol LoadingScreenDelete <NSObject>

@optional

@end