//
//  NSNumber+FormSerializableSupport.m
//  objective_support
//
//  Created by James Burka on 2/17/09.
//  Copyright 2009 Burkaprojects. All rights reserved.
//

#import "NSObject+FormSerializableSupport.h"
#import "NSNumber+FormSerializableSupport.h"


@implementation NSNumber(FormSerializableSupport)

- (NSString *)toFormValue {
	return [self stringValue];
}

- (NSString *)toFormElementAs:(NSString *)rootName excludingInArray:(NSArray *)exclusions
						withTranslations:(NSDictionary *)keyTranslations {
	return [[self class] buildFormElementAs:rootName withInnerForm:[self toFormValue] andType:[[self class] formTypeFor:self]];
}


@end
