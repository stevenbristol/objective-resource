//
//  NSDate+FormSerializableSupport.m
//  
//
//  Created by Ryan Daigle on 7/31/08.
//  Copyright 2008 yFactorial, LLC. All rights reserved.
//

#import "NSDate+FormSerializableSupport.h"
#import "NSObject+FormSerializableSupport.h"
#import "ObjectiveResourceDateFormatter.h"

@implementation NSDate (FormSerializableSupport)

//FIXME we should have one formatter for the entire app

- (NSString *)toFormValue {
	return [ ObjectiveResourceDateFormatter formatDate:self]; 
}

- (NSString *)toFormElementAs:(NSString *)rootName excludingInArray:(NSArray *)exclusions withTranslations:(NSDictionary *)keyTranslations {
	return [[self class] buildFormElementAs:rootName withInnerForm:[self toFormValue] andType:[[self class] formTypeFor:self]];
}

+ (NSDate *)fromFormDateTimeString:(NSString *)formString {
	return [ ObjectiveResourceDateFormatter parseDateTime:formString];
}

+ (NSDate *)fromFormDateString:(NSString *)formString {
	return [ ObjectiveResourceDateFormatter parseDate:formString];
}


@end
