//
//  FormSerializableSupport.m
//  
//
//  Created by Ryan Daigle on 7/31/08.
//  Copyright 2008 yFactorial, LLC. All rights reserved.
//

#import "NSObject+FormSerializableSupport.h"
#import "NSObject+ObjectiveResource.h"
#import "NSDictionary+FormSerializableSupport.h"
#import "CoreSupport.h"

@implementation NSObject (FormSerializableSupport)

# pragma mark Form utility methods



/**
 * Get the appropriate form type, if any, for the given value.
 * I.e. "integer" or "decimal" etc... for use in element attributes:
 *
 *   <element-name type="integer">1</element-name>
 */
+ (NSString *)formTypeFor:(NSObject *)value {
	
	// Can't do this with NSDictionary w/ Class keys.  Explore more elegant solutions.
	// TODO: Account for NSValue native types here?
	if ([value isKindOfClass:[NSDate class]]) {
		return @"datetime";
	} else if ([value isKindOfClass:[NSDecimalNumber class]]) {
		return @"decimal";
	} else if ([value isKindOfClass:[NSNumber class]]) {
		if (0 == strcmp("f",[(NSNumber *)value objCType]) ||
			0 == strcmp("d",[(NSNumber *)value objCType])) 
		{
			return @"decimal";
		}
		else {
			return @"integer";
		}
	} else if ([value isKindOfClass:[NSArray class]]) {
		return @"array";
	} else {
		return nil;
	}
}

+ (NSString *)buildFormElementAs:(NSString *)rootName withInnerForm:(NSString *)value andType:(NSString *)formType{
	NSString *fixedName = [rootName underscore];
	
	
	return [Connection buildParameter:fixedName value:value];
//	if (formType != nil) {
//		return [NSString stringWithFormat:@"<%@ type=\"%@\">%@</%@>", dashedName, formType, value, dashedName];
//	} else {
//		return [NSString stringWithFormat:@"<%@>%@</%@>", dashedName, value, dashedName];
//	}	
}

+ (NSString *)buildFormElementAs:(NSString *)rootName withInnerForm:(NSString *)value {
	return [[self class] buildFormElementAs:rootName withInnerForm:value andType:nil];
}

+ (NSString *)buildFormElementAs:(NSString *)rootName withValue:(NSObject *)value {
	return [[self class] buildFormElementAs:rootName withInnerForm:[value toFormValue] andType:[self formTypeFor:value]];
}

+ (NSString *)formElementName {
	NSString *className = NSStringFromClass(self);
	return [[className stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:[[className substringToIndex:1] lowercaseString]] underscore];
}

# pragma mark FormSerializable implementation methods

- (NSString *)toFormElement {
	return [self toFormElementAs:[[self class] formElementName] excludingInArray:[NSArray array] withTranslations:[NSDictionary dictionary]];
}

- (NSString *)toFormElementExcluding:(NSArray *)exclusions {
	return [self toFormElementAs:[[self class] formElementName] excludingInArray:exclusions withTranslations:[NSDictionary dictionary]];  
}

- (NSString *)toFormElementAs:(NSString *)rootName {
	return [self toFormElementAs:rootName excludingInArray:[NSArray array] withTranslations:[NSDictionary dictionary]];
}

- (NSString *)toFormElementAs:(NSString *)rootName excludingInArray:(NSArray *)exclusions {
	return [self toFormElementAs:rootName excludingInArray:exclusions withTranslations:[NSDictionary dictionary]];
}

- (NSString *)toFormElementAs:(NSString *)rootName withTranslations:(NSDictionary *)keyTranslations {
	return [self toFormElementAs:rootName excludingInArray:[NSArray array] withTranslations:keyTranslations];
}

/**
 * Override in complex objects to account for nested properties
 **/
- (NSString *)toFormElementAs:(NSString *)rootName excludingInArray:(NSArray *)exclusions
			withTranslations:(NSDictionary *)keyTranslations {
	if (!exclusions || [exclusions count] == 0) {
		exclusions = [self getDefaultExclusions];
	}
	return [[self properties] toFormElementAs:rootName excludingInArray:exclusions withTranslations:keyTranslations andType:[[self class] formTypeFor:self]];
}

# pragma mark Form Serialization convenience methods
	
/**
 * Override in objects that need special formatting before being printed to Form
 **/
- (NSString *)toFormValue {
	return [NSString stringWithFormat:@"%@", self];
}

@end
