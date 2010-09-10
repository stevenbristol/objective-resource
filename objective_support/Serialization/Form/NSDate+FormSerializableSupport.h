//
//  NSDate+FormSerializableSupport.h
//  
//
//  Created by Ryan Daigle on 7/31/08.
//  Copyright 2008 yFactorial, LLC. All rights reserved.
//



@interface NSDate (FormSerializableSupport)
- (NSString *)toFormValue;
+ (NSDate *)fromFormDateTimeString:(NSString *)formString;
+ (NSDate *)fromFormDateString:(NSString *)formString;
@end
