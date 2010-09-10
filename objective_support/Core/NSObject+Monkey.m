//
//  NSObject+Monkey.m
//  rentingsmart
//
//  Created by Steven Bristol on 9/10/10.
//  Copyright 2010 Less Eveything. All rights reserved.
//

#import "NSObject+Monkey.h"
#import "NSString+Monkey.h"


@implementation NSObject (Monkey)

- (BOOL)blank:(SEL)selector{
	id val = [self performSelector:selector];
	if (val == nil) {
		return true;
	}
	if ([val isKindOfClass:[NSString class]]) {
		return [val blank];
	}
	if ([val isKindOfClass:[NSArray class]]) {
		return [val count] == 0;
	}
	return false;
}

@end
