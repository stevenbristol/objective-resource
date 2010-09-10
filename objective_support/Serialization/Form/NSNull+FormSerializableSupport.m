//
//  NSNull+FormSerializableSupport.m
//  
//
//  Created by Ryan Daigle on 7/31/08.
//  Copyright 2008 yFactorial, LLC. All rights reserved.
//

#import "NSNull+FormSerializableSupport.h"

@implementation NSNull (FormSerializableSupport)

- (NSString *)toFormValue {
	return @"";
}

@end
