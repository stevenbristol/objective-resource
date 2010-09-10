//
//  NSString+FormSerializableSupport.m
//  active_resource
//
//  Created by James Burka on 1/6/09.
//  Copyright 2009 Burkaprojects. All rights reserved.
//

#import "NSString+FormSerializableSupport.h"
#import "NSObject+FormSerializableSupport.h"
#import "NSString+GSub.h"


@implementation NSString(FormSerializableSupport)


- (NSString *)toFormValue {
	return self;
}

- (NSString *)toFormElementAs:(NSString *)rootName excludingInArray:(NSArray *)exclusions withTranslations:(NSDictionary *)keyTranslations {
	return [[self class] buildFormElementAs:rootName withInnerForm:[self toFormValue]];
}

@end
