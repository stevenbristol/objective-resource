//
//  ORBinaryData+FormSerializableSupport.h
//  
//
//  Created by William Castrogiovanni on 06/14/09.
//  Based on code created by Ryan Daigle.
//
#import "ORBinaryData.h"
@interface ORBinaryData (FormSerializableSupport)
- (NSString *)toFormElementAs:(NSString *)rootName;
- (NSString *)toFormElementAs:(NSString *)rootName excludingInArray:(NSArray *)exclusions withTranslations:(NSDictionary *)keyTranslations;

@end