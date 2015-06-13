//
//  EmptyViewWithPullDownGesture.m
//  
//
//  Created by Administrator on 5/14/15.
//  Copyright (c) 2015 angelhack. All rights reserved.
//

#import "EmptyViewWithPullDownGesture.h"

@implementation EmptyViewWithPullDownGesture

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        UIView *backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height, self.frame.size.width, self.frame.size.height)];
        backgroundView.backgroundColor = [UIColor colorWithRed:4.0/255.0 green:32.0/255.0 blue:45.0/255.0 alpha:0.8];
        
        [self addSubview:backgroundView];
        
        [UIView animateWithDuration:0.25 animations:^{
            backgroundView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        }];
        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePan:)];
        pan.maximumNumberOfTouches = 1;
        pan.delegate = self;
        [self addGestureRecognizer:pan];
    }
    
    
    return self;
}

-(void)handlePan:(UIPanGestureRecognizer *)recognizer
{
    CGPoint velocity = [recognizer velocityInView:recognizer.view];
    CGPoint translation = [recognizer translationInView:recognizer.view];
    
    // Down direction
    if (velocity.y > 0)
    {
        CGRect frame = recognizer.view.frame;
        
        if (frame.origin.y < 0)
            recognizer.view.frame = CGRectMake(frame.origin.x, 0, frame.size.width, frame.size.height);
        
        if (recognizer.state == UIGestureRecognizerStateEnded)
        {
            [UIView animateWithDuration:0.25 animations:^
             {
                 recognizer.view.frame = CGRectMake(frame.origin.x, recognizer.view.superview.frame.size.height, frame.size.width, frame.size.height);
                 
             } completion:^(BOOL finished) {
                 [self dismissView];
                 
             }];
        }
        else
        {
            recognizer.view.center = CGPointMake(recognizer.view.center.x, recognizer.view.center.y + translation.y);
            [recognizer setTranslation:CGPointMake(0, 0) inView:recognizer.view];
        }
    }
    // Up direction
    else
    {
        CGRect frame = recognizer.view.frame;
        
        if (recognizer.state == UIGestureRecognizerStateEnded)
        {
            [UIView animateWithDuration:0.25 animations:^
             {
                 recognizer.view.frame = CGRectMake(frame.origin.x, 0, frame.size.width, frame.size.height);
             }];
        }
        else
        {
            recognizer.view.center = CGPointMake(recognizer.view.center.x, recognizer.view.center.y + translation.y);
            [recognizer setTranslation:CGPointMake(0, 0) inView:recognizer.view];
        }
        
    }
}


-(void)dismissView
{
    if ([self.delegate respondsToSelector:@selector(didDismissEmptyView:)])
    {
        [UIView animateWithDuration:0.5 animations:^{
            
            //self.frame = CGRectMake(self.frame.origin.x, self.frame.size.height, self.frame.size.width, self.frame.size.height);
            self.alpha = 0;
        }completion:^(BOOL finished){
            self.hidden = YES;
            
            [self.delegate didDismissEmptyView:self];
        }];
        
        
    }
}


-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    CGPoint location = [gestureRecognizer locationInView:self];
    
    if (location.y < 70)
        return YES;
    
    
    
    return NO;
}


@end
