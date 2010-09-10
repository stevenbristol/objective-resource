//
//  NSArray+FormSerializableSupport.m
//  
//
//  Created by vickeryj on 9/29/08.
//  Copyright 2008 Joshua Vickery. All rights reserved.
//

#import "NSArray+FormSerializableSupport.h"
#import "NSObject+FormSerializableSupport.h"


@implementation NSArray (FormSerializableSupport)

- (NSString *)toFormValue {
	NSMutableString *result = [NSMutableString string];
	
	for (id element in self) {
		[result appendString:[element toFormElement]];
	}
	
	return result;
}

- (NSString *)toFormElementAs:(NSString *)rootName excludingInArray:(NSArray *)exclusions
						withTranslations:(NSDictionary *)keyTranslations {
	NSMutableString *elementValue = [NSMutableString string];
//	for (int i=0; i++; i<[self count]){
	int i = 0;
	for (id element in self) {
		id element = [self objectAtIndex:i];
		[elementValue appendString:[element toFormElementAs:[NSString stringWithFormat:@"%@[%d]", rootName, i] excludingInArray:exclusions withTranslations:keyTranslations]];
		i++;
	}
	if ([elementValue length] == 0) {//all the elements were attachments
		return @"";
	}
	return [[self class] buildFormElementAs:rootName withInnerForm:elementValue andType:@"array"];
}


@end
