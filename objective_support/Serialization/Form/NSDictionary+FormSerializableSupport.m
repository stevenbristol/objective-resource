//
//  NSDictionary+FormSerializableSupport.m
//  
//
//  Created by Ryan Daigle on 7/31/08.
//  Copyright 2008 yFactorial, LLC. All rights reserved.
//

#import "NSObject+FormSerializableSupport.h"
#import "NSDictionary+KeyTranslation.h"
#import "NSString+Monkey.h"

@implementation NSDictionary (FormSerializableSupport)


- (NSString *)toFormElementAs:(NSString *)rootName excludingInArray:(NSArray *)exclusions
						withTranslations:(NSDictionary *)keyTranslations andType:(NSString *)formType {

	NSMutableString* elementValue = [NSMutableString string];
	id value;
	NSString *propertyRootName;
	for (NSString *key in self) {
		// Create Form if key not in exclusion list
		if(![exclusions containsObject:key]) {
//			NSLog(@"key to serialize: %@", key);
//			if ([key eq:@"images"]) {
//				int i = 0;
//			}
			value = [self valueForKey:key];
			NSString *nested = @"";
			if ([value isKindOfClass:[NSArray class]]) {
				nested = @"_attributes";
			}
			propertyRootName = [NSString stringWithFormat:@"%@[%@%@]", rootName, [[self class] translationForKey:key withTranslations:keyTranslations], nested];
			[elementValue appendString:[value toFormElementAs:propertyRootName]];
		}
	}
	return elementValue;
	//return [[self class] buildFormElementAs:rootName withInnerForm:elementValue andType:formType];
}
	
- (NSString *)toFormElementAs:(NSString *)rootName excludingInArray:(NSArray *)exclusions
			withTranslations:(NSDictionary *)keyTranslations {
	return [self toFormElementAs:rootName excludingInArray:exclusions withTranslations:keyTranslations andType:nil];
}

@end
