//
//  LoadingScreen.m
//  Barterfly
//
//  Created by Mun Fai Leong on 6/13/15.
//  Copyright (c) 2015 angelhack. All rights reserved.
//

#import "LoadingScreen.h"

@implementation LoadingScreen


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    [self createLoadingView];
}


-(instancetype)initWithFrame:(CGRect)frame forSuperView:(UIView *)view atTarget:(id)target
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        self.delegate = target;
        self.mySuperView = view;
    }
    
    return self;
}

-(void)createLoadingView
{
    UIView *contentView = [[UIView alloc]initWithFrame:CGRectMake(self.frame.size.width / 2 - 100, (self.frame.size.height / 2) - 100, 200, 150)];
    contentView.backgroundColor = [UIColor whiteColor];
    contentView.layer.cornerRadius = contentView.frame.size.height / 7;
    contentView.clipsToBounds = YES;
    
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(contentView.frame.size.width / 2 - 20, 30, 40, 40)];
    indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    [indicator startAnimating];
    
    UILabel *processLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, indicator.frame.size.height + indicator.frame.origin.y + 20, contentView.frame.size.width - 40, 30)];
    processLabel.textAlignment = NSTextAlignmentCenter;
    processLabel.numberOfLines = 1;
    processLabel.textColor = [AICommonUtils getAIColorWithRGB000:1];
    processLabel.font = [AICommonUtils getCustomTypeface:fontHelveticaNeue ofSize:16];
    processLabel.text = @"Processing";
    processLabel.attributedText = [AICommonUtils createStringWithSpacing:processLabel.text spacngValue:2.0 withUnderLine:NO];
    
    [contentView addSubview:processLabel];
    [contentView addSubview:indicator];
    
    [self addSubview:contentView];
}

@end
