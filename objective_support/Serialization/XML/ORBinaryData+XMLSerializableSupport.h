//
//  ORBinaryData+XMLSerializableSupport.h
//  
//
//  Created by William Castrogiovanni on 06/14/09.
//  Based on code created by Ryan Daigle.
//
#import "ORBinaryData.h"
@interface ORBinaryData (XMLSerializableSupport)

/**
 This method assumes that the data will be uploaded as part of a multipart/related
 attachment.  It appends the data to the passed-in array of attachments and returns
 a string content identifier (cid) to be nested in the returned XML element.
 */
- (NSString *)toXMLValueWithAttachments: (NSMutableArray *) attachments;

- (NSString *)toXMLElementAs:(NSString *)rootName captureAttachments:(NSMutableArray *)attachments;

- (NSString *)toXMLElementAs:(NSString *)rootName excludingInArray:(NSArray *)exclusions
			withTranslations:(NSDictionary *)keyTranslations captureAttachments:(NSMutableArray *)attachments;

@end