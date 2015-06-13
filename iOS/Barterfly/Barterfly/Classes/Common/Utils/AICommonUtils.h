//
//  AICommonUtils.h
//  BalloonPopper
//
//  Created by Mun Fai Leong on 3/8/15.
//  Copyright (c) 2015 myAppIndustry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AIEnumCollection.h"

#import "GBConnectionManager.h"

@interface AICommonUtils : NSObject


/// CREATE CUSTOM STRING WITH LETTING SPACING ///

+(NSMutableAttributedString *)createStringWithSpacing:(NSString *)string spacngValue:(float)spacing withUnderLine:(BOOL)isUnderLine;

+(NSMutableAttributedString *)addUnderLineToMutableAttributedString:(NSMutableAttributedString *)attributeString;


/// SETTING OF UIFONT FROM UIFONT FAMILY ///

+ (UIFont *)getCustomTypeface:(AIFontFamily)typeface ofSize:(CGFloat)size;
+(void)getAllFontFamilyWithNames;


/// CREATE ONE SIDED BORDER VIEW ///

+(CALayer *)createOneSidedBorderForUIView:(UIView *)myView Side:(BorderSide)Side;

+(float)getBorderWidthAccordingToDisplay;


/// GET UICOLOR ///

+(UIColor *)getAIColorWithRGB228:(CGFloat)alpha;
+(UIColor *)getAIColorWithRGB192;
+(UIColor *)getAIColorWithRGB000:(CGFloat)alpha;


+(void)navigateToItemDetailsPageWithNavigationController:(UINavigationController *)navigationController;
@end
