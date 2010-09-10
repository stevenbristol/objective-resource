//
//  NSDate+XMLSerializableSupport.m
//  
//
//  Created by Ryan Daigle on 7/31/08.
//  Copyright 2008 yFactorial, LLC. All rights reserved.
//

#import "SerializationConfig.h"
#import "ORBinaryData.h"
#import "ORBinaryData+XMLSerializableSupport.h"
#import "NSObject+XMLSerializableSupport.h"
#import "NSData+Additions.h"

@implementation ORBinaryData (XMLSerializableSupport)

- (NSString *)toXMLValueWithAttachments: (NSMutableArray *) attachments {
	
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
	
}

- (NSString *)toXMLElementAs:(NSString *)rootName captureAttachments:(NSMutableArray *)attachments{
	return [self toXMLElementAs:rootName excludingInArray:[NSArray array] withTranslations:[NSDictionary dictionary] captureAttachments:attachments];
}

- (NSString *)toXMLElementAs:(NSString *)rootName excludingInArray:(NSArray *)exclusions
			withTranslations:(NSDictionary *)keyTranslations captureAttachments:(NSMutableArray *)attachments {
	[self setContentId:rootName];
	return [[self class] buildXmlElementAs:rootName withInnerXml:[self toXMLValueWithAttachments:attachments]];
}


@end
