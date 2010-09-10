//
//  NSDate+FormSerializableSupport.m
//  
//
//  Created by Ryan Daigle on 7/31/08.
//  Copyright 2008 yFactorial, LLC. All rights reserved.
//

#import "ORBinaryData.h"
#import "ORBinaryData+FormSerializableSupport.h"
#import "NSObject+FormSerializableSupport.h"
#import "NSData+Additions.h"
#import "Connection.h"

@implementation ORBinaryData (FormSerializableSupport)

//- (NSString *)toFormValueWith{
//	
//	// If the item is flagged as attachable, save it to attachments array
//	// If it isn't attachable, Base64 encode it into a string.
//	// NOTE: This conditional references the global NSObject+SerializableSupport parameters
//	if ([SerializationConfig getShouldCaptureBinaryAttachments]) {	
//		[attachments addObject: self];
//		return [NSString stringWithFormat:@"cid:%@", [self contentId]];
//	}
//	else {
//		return [self base64Encoding];
//	}	
//}

- (NSString *)toFormElementAs:(NSString *)rootName{
	return [self toFormElementAs:rootName excludingInArray:[NSArray array] withTranslations:[NSDictionary dictionary]];
}

- (NSString *)toFormElementAs:(NSString *)rootName excludingInArray:(NSArray *)exclusions withTranslations:(NSDictionary *)keyTranslations{
	[Connection buildBinaryParameter:rootName value:self];
	return @"";
}


@end
