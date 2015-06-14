//
//  AICommonUtils.m
//  
//
//  Created by Mun Fai Leong on 3/8/15.
//  Copyright (c) 2015 angelhack. All rights reserved.
//

#import "AICommonUtils.h"
#import "ItemDetailViewController.h"

@implementation AICommonUtils

+ (UIFont *)getCustomTypeface:(AIFontFamily)typeface ofSize:(CGFloat)size
{
    return [UIFont fontWithName:[self getTypefaceName:typeface] size:size];
}

+ (NSString *)getTypefaceName:(AIFontFamily)typeface
{
    NSString *fontName = @"Courier";
    
    switch (typeface) {
        case fontAvenirBook:
            fontName = @"Avenir-Book";
            break;
            
        case fontAvenirLight:
            fontName = @"Avenir-Light";
            break;
            
        case fontAvenirNextItalic:
            fontName = @"AvenirNext-Italic";
            break;
            
        case fontAvenirNextUltraLight:
            fontName = @"AvenirNext-UltraLight";
            break;
            
        case fontAvenirNextUltraLightItalic:
            fontName = @"AvenirNext-UltraLightItalic";
            break;
            
        case fontCourier:
            fontName = @"Courier";
            break;
            
        case fontZapfino:
            fontName = @"Zapfino";
            break;
            
        case fontTrebuchetMS:
            fontName = @"TrebuchetMS";
            break;
            
        case fontTrebuchetMSBold:
            fontName = @"TrebuchetMS-Bold";
            break;
            
        case fontTrebuchetMSBoldItalic:
            fontName = @"Trebuchet-BoldItalic";
            break;
            
        case fontTrebuchetMSItalic:
            fontName = @"TrebuchetMS-Italic";
            break;
            
        case fontHelveticaNeue:
            fontName = @"HelveticaNeue";
            break;
            
        case fontHelveticaNeueItalic:
            fontName = @"HelveticaNeue-Italic";
            break;
            
        case fontHelveticaNeueLight:
            fontName = @"HelveticaNeue-Light";
            break;
            
        case fontHelveticaNeueThin:
            fontName = @"HelveticaNeue-Thin";
            break;
            
        default:
            break;
    }
    
    return fontName;
}



+(NSMutableAttributedString *)createStringWithSpacing:(NSString *)string spacngValue:(float)spacing withUnderLine:(BOOL)isUnderLine
{
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:string];
    
    [attributeString addAttribute:NSKernAttributeName value:@(spacing) range:NSMakeRange(0, string.length)];
    
    if (isUnderLine)
        attributeString = [self addUnderLineToMutableAttributedString:attributeString];
    
    return attributeString;
}

+(void)getAllFontFamilyWithNames
{
    NSArray *fontFamilies = [UIFont familyNames];
    
    for (int i = 0; i < [fontFamilies count]; i++)
    {
        NSString *fontFamily = [fontFamilies objectAtIndex:i];
        NSArray *fontNames = [UIFont fontNamesForFamilyName:[fontFamilies objectAtIndex:i]];
        NSLog (@"%@: %@", fontFamily, fontNames);
    }
}

+(NSMutableAttributedString *)addUnderLineToMutableAttributedString:(NSMutableAttributedString *)attributeString
{
    [attributeString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInt:NSUnderlineStyleSingle] range:NSMakeRange(0, attributeString.length)];
    
    return attributeString;
}



+(CALayer *)createOneSidedBorderForUIView:(UIView *)myView Side:(BorderSide)Side
{
    CGRect myFrame = myView.frame;
    CGFloat x, y, width, height;
    
    switch (Side)
    {
        case BorderLeft:
        {
            x = 0;
            y = 0;
            height = myView.frame.size.height;
            width = [self getBorderWidthAccordingToDisplay];
        }
            break;
            
        case BorderTop:
        {
            x = 0;
            y = 0;
            height = [self getBorderWidthAccordingToDisplay];
            width = myView.frame.size.width;
        }
            break;
            
        case BorderRight:
        {
            x = myView.frame.size.width - [self getBorderWidthAccordingToDisplay];
            y = 0;
            height = myView.frame.size.height;
            width = [self getBorderWidthAccordingToDisplay];
        }
            break;
            
        case BorderBottom:
        {
            x = 0;
            y = myView.frame.size.height - [self getBorderWidthAccordingToDisplay];
            height = [self getBorderWidthAccordingToDisplay];
            width = myView.frame.size.width;
        }
            break;
    }
    
    myFrame.origin.x = x;
    myFrame.origin.y = y;
    myFrame.size.height = height;
    myFrame.size.width = width;
    
    CALayer *newLayer = [CALayer layer];
    newLayer.frame = myFrame;
    newLayer.backgroundColor = [UIColor colorWithRed:228.0/255/0 green:228.0/255/0 blue:228.0/255.0 alpha:1.0].CGColor;
    
    return newLayer;
}

+(float)getBorderWidthAccordingToDisplay
{
    float width = 0;
    
    if ([UIScreen mainScreen].scale >= 2)
        width = 1.0;
    else
        width = 2.0;
    
    return width;
}



+(UIColor *)getAIColorWithRGB228:(CGFloat)alpha
{
    return [UIColor colorWithRed:228.0/255.0 green:228.0/255.0 blue:228.0/255.0 alpha:alpha];
}

+(UIColor *)getAIColorWithRGB192
{
    return [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0];
}

+(UIColor *)getAIColorWithRGB000:(CGFloat)alpha
{
    return [UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:alpha];
}

+(UIColor *)getAIColorWithRGB0_32_44:(CGFloat)alpha
{
    return [UIColor colorWithRed:0.0/255.0 green:32.0/255.0 blue:44.0/255.0 alpha:alpha];
}

+(void)navigateToItemDetailsPageWithNavigationController:(UINavigationController *)navigationController forDictionary:(NSMutableDictionary *)dictionary
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ItemDetailViewController *wrongpin = (ItemDetailViewController *)[storyboard instantiateViewControllerWithIdentifier:@"ItemDetailViewController"];
    wrongpin.itemDictionary = dictionary;
    
    [navigationController pushViewController:wrongpin animated:YES];
}



+(NSString *)getAzureTableNameForTable:(azureTableName)tableName
{
    NSString *table;
    
    switch (tableName)
    {
        case tableRequestItem:
            table = @"RequestItem";
            break;
            
        case tableRequestItemComment:
            table = @"RequestItemComment";
            break;
            
        case tableRequestItemImage:
            table = @"RequestItemImage";
            break;
            
        case tableRequestItemLike:
            table = @"RequestItemLike";
            break;
            
        case tableTradeItem:
            table = @"TradeItem";
            break;
            
        case tableTradeItemComment:
            table = @"TradeItemComment";
            break;
            
        case tableTradeItemImage:
            table = @"TradeItemImage";
            break;
            
        case tableTradeItemLike:
            table = @"TradeItemLike";
            break;
            
        case tableTradeItemWishList:
            table = @"TradeItemWishList";
            break;
            
        case tableAllRequestItem:
            table = @"AllRequestItem";
            break;
            
        case tableAllTradeItem:
            table = @"AllTradeItem";
            break;
    }
    
    return table;
}

+(NSString *)getCategoryNameForId:(NSInteger)categoryId
{
    NSString *name;
    
    switch (categoryId)
    {
        case 1:
            name = @"BOOKS - FICTION";
            break;
    }
    
    return name;
}

+(UIImage *)getImageFromUrl:(NSString *)urlString
{
    NSURL *url = [NSURL URLWithString:urlString];
    NSData *data = [NSData dataWithContentsOfURL:url];
    return [[UIImage alloc]initWithData:data];
}
@end
