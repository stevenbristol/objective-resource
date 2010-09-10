//
//  Connection.h
//  
//
//  Created by Ryan Daigle on 7/30/08.
//  Copyright 2008 yFactorial, LLC. All rights reserved.
//

#import "ORBinaryData.h"


@class Response;

@interface Connection : NSObject
+ (void) setTimeout:(float)timeout;
+ (float) timeout;
+ (Response *)post:(NSString *)url;
+ (Response *)post:(NSString *)url withUser:(NSString *)user andPassword:(NSString *)password;
+ (Response *)post:(NSString *)url withUser:(NSString *)user andPassword:(NSString *)password forARObject:(NSObject*)arObj;
+ (Response *)get:(NSString *)url withUser:(NSString *)user andPassword:(NSString *)password;
+ (Response *)get:(NSString *)url;
+ (Response *)put:(NSString *)url withUser:(NSString *)user andPassword:(NSString *)password forARObject:(NSObject*)arObj;
+ (Response *)delete:(NSString *)url withUser:(NSString *)user andPassword:(NSString *)password;

+ (void) cancelAllActiveConnections;

+ (Response *)buildAndSendRequest:(NSString *)method to:(NSString*)url withUser:(NSString *)user andPassword:(NSString *)password;
+ (Response *)buildAndSendRequest:(NSString *)method to:(NSString*)url withUser:(NSString *)user andPassword:(NSString *)password forARObject:(NSObject*)arObj;


+ (void)fixUrl:(NSMutableURLRequest*)request user:(NSString*)user password:(NSString*)password;
+ (BOOL)hasAttachments;
+ (NSString*)fixIdFieldName:(NSString*)name;
+ (void)buildBinaryParameter:(NSString*)name value:(ORBinaryData*)value;
+ (NSString*)buildParameter:(NSString*)name value:(NSString*)value;
+ (void)buildRequestBody:(NSMutableURLRequest*)request method:(NSString*)method forARObject:(NSObject*)arObj;

@end
