//
//  EmptyViewWithPullDownGesture.h
//  GloBeamForBusinesses
//
//  Created by Administrator on 5/14/15.
//  Copyright (c) 2015 GloBeam. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol GBEmptyViewDelegate;

@interface EmptyViewWithPullDownGesture : UIView <UIGestureRecognizerDelegate>

@property (nonatomic, assign) IBOutlet id <GBEmptyViewDelegate> delegate;

@end

@protocol GBEmptyViewDelegate <NSObject>

@optional

-(void)didDismissEmptyView:(UIView *)view;

@end
