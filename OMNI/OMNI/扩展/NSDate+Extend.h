//
//  NSDate+Extend.h
//  OMNI
//
//  Created by changxicao on 16/7/12.
//  Copyright © 2016年 changxicao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extend)

+ (NSDate *)convertDateFromString:(NSString*)string format:(NSString *)format;

+ (NSString *)stringFromDate:(NSDate *)date format:(NSString *)format;

@end
