//
//  UIColor+Unit.m
//  zjproject
//
//  Created by rockontrol on 15/3/28.
//  Copyright (c) 2015年 rockontrol. All rights reserved.
//

#import "UIColor+Unit.h"

#define kUIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((CGFloat)((rgbValue & 0xff0000) >> 16))/255.0f \
green:((CGFloat)((rgbValue & 0x00ff00) >> 8))/255.0f \
blue:((CGFloat)((rgbValue & 0x0000ff) >> 0))/255.0f alpha:1.0f]


@implementation UIColor (Unit)

+ (UIColor*)colorWithNumber:(uint32_t)colorCode
{
    return kUIColorFromRGB(colorCode);
}

@end
