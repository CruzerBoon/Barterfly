//
//  AIEnumCollection.h
//  
//
//  Created by Mun Fai Leong on 3/8/15.
//  Copyright (c) 2015 angelhack. All rights reserved.
//


typedef enum
{
    tableTradeItem,  //0
    tableTradeItemImage, //1
    tableTradeItemComment,
    tableTradeItemLike,
    tableTradeItemWishList,
    tableRequestItem,
    tableRequestItemImage,
    tableRequestItemLike,
    tableRequestItemComment,
    tableAllRequestItem,
    tableAllTradeItem
} azureTableName;

typedef enum {
    fontZapfino,
    fontCourier,
    fontAvenirNextItalic,
    fontAvenirNextUltraLight,
    fontAvenirNextUltraLightItalic,
    fontAvenirBook,
    fontAvenirLight,
    fontTrebuchetMS,
    fontTrebuchetMSBoldItalic,
    fontTrebuchetMSBold,
    fontTrebuchetMSItalic,
    fontHelveticaNeue,
    fontHelveticaNeueItalic,
    fontHelveticaNeueLight,
    fontHelveticaNeueThin
}AIFontFamily;

typedef enum {
    BorderBottom,
    BorderTop,
    BorderLeft,
    BorderRight
} BorderSide;