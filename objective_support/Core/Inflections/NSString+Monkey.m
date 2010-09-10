//
//  NSString+Monkey.m
//  rentingsmart
//
//  Created by Steven Bristol on 8/4/10.
//  Copyright 2010 Less Eveything. All rights reserved.
//

#import "NSString+Monkey.h"



@implementation NSString (Monkey)

- (BOOL)empty{
	return [self blank];
}
- (BOOL)blank{
	return [self eq:@""];
}

- (BOOL)eq:(NSString*)stringToCompareTo{
	if (!stringToCompareTo) {
		return false;
	}
	return [self isEqualToString:stringToCompareTo];
}
@end
