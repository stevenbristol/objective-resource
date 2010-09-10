//
//  Connection.m
//  
//
//  Created by Ryan Daigle on 7/30/08.
//  Copyright 2008 yFactorial, LLC. All rights reserved.
//

#import "Connection.h"
#import "Response.h"
#import "NSData+Additions.h"
#import "NSMutableURLRequest+ResponseType.h"
#import "ConnectionDelegate.h"
#import "ORBinaryData.h"
#import "NSObject+ObjectiveResource.h"

//#define debugLog(...) NSLog(__VA_ARGS__)
#ifndef debugLog(...)
	#define debugLog(...)
#endif

@implementation Connection

static float timeoutInterval = 35.0;

static NSMutableArray *activeDelegates;
static NSMutableArray *_attachments;
NSString *const bodyBoundary = @"1317260451787483034285635977";


+ (NSMutableArray *)activeDelegates {
	if (nil == activeDelegates) {
		activeDelegates = [NSMutableArray array];
		[activeDelegates retain];
	}
	return activeDelegates;
}

+ (NSMutableArray*)attachments{
	if (!_attachments) {
		_attachments = [[NSMutableArray alloc] initWithCapacity:1];
		[_attachments retain];
	}
	return _attachments;
}

+ (void)setTimeout:(float)timeOut {
	timeoutInterval = timeOut;
}
+ (float)timeout {
	return timeoutInterval;
}

+ (void)logRequest:(NSURLRequest *)request to:(NSString *)url {
	debugLog(@"%@ -> %@", [request HTTPMethod], url);
	if([request HTTPBody]) {
		debugLog(@"%@", [[[NSString alloc] initWithData:[request HTTPBody] encoding:NSUTF8StringEncoding] autorelease]);
	}
}

//lots of servers fail to implement http basic authentication correctly, so we pass the credentials even if they are not asked for
//TODO make this configurable?
+ (void)fixUrl:(NSMutableURLRequest*)request user:(NSString*)user password:(NSString*)password{
	
	NSURL *url = [request URL];
	if(user && password) {
		NSString *authString = [[[NSString stringWithFormat:@"%@:%@",user, password] dataUsingEncoding:NSUTF8StringEncoding] base64Encoding];
		[request addValue:[NSString stringWithFormat:@"Basic %@", authString] forHTTPHeaderField:@"Authorization"]; 
		NSString *escapedUser = (NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, 
																					(CFStringRef)user, NULL, (CFStringRef)@"@.:", kCFStringEncodingUTF8);
		NSString *escapedPassword = (NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, 
																						(CFStringRef)password, NULL, (CFStringRef)@"@.:", kCFStringEncodingUTF8);
		NSMutableString *urlString = [NSMutableString stringWithFormat:@"%@://%@:%@@%@",[url scheme],escapedUser,escapedPassword,[url host],nil];
		if([url port]) {
			[urlString appendFormat:@":%@",[url port],nil];
		}
		[urlString appendString:[url path]];
		if([url query]){
			[urlString appendFormat:@"?%@",[url query],nil];
		}
		[request setURL:[NSURL URLWithString:urlString]];
		[escapedUser release];
		[escapedPassword release];
	}
	
}

+ (BOOL)hasAttachments{
	return [_attachments count] > 0;
}


+ (NSString*)fixIdFieldName:(NSString*)name{
	return [name stringByReplacingOccurrencesOfString:@"Id" withString:@"_id"];
}


 
 
 
 

+ (void)buildBinaryParameter:(NSString*)name value:(ORBinaryData*)value{
	NSLog(@"buildBinaryParameter:name => %@", name);
	NSMutableData *data = [NSMutableData data];
	[data appendData:[[NSString stringWithFormat:@"--%@\r\nContent-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\nContent-Type: %@\r\n\r\n", bodyBoundary, name, value.fileName, value.MIMEType] dataUsingEncoding:NSUTF8StringEncoding]];
	[data appendData:value];
	NSLog(@"data retain count: %d", [data retainCount]);
	[[self attachments] addObject:data];
	[data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
	NSLog(@"data retain count: %d", [data retainCount]);
 }

 
 
 
+ (NSString*)buildParameter:(NSString*)name value:(NSString*)value{
	return [NSString stringWithFormat:@"--%@\r\nContent-Disposition: form-data; name=\"%@\"\r\n\r\n%@\r\n", bodyBoundary, [self fixIdFieldName:name], value];
}

 
 
 
+ (void)buildRequestBody:(NSMutableURLRequest*)request method:(NSString*)method forARObject:(NSObject*)arObj{
	if ([method eq:@"GET"]){
		return;
	}
    
	NSMutableString *bodyString = [NSMutableString stringWithCapacity:256];
	[request setHTTPMethod:@"POST"];
    
	if ([method eq:@"DELETE"] || [method eq:@"PUT"]) {
		[bodyString appendString:[Connection buildParameter:@"_method" value:[method lowercaseString]]];	
	}
	
	NSMutableData *bodyData = [NSMutableData data];
    if ([method eq:@"PUT"] || [method eq:@"POST"]){
        
        [request setValue:[NSString stringWithFormat:@"multipart/form-data; boundary=%@", bodyBoundary] forHTTPHeaderField:@"Content-Type"];
        [bodyString appendString:[arObj convertToRemoteExpectedType]];
		[bodyData appendData:[bodyString dataUsingEncoding:NSUTF8StringEncoding]];
        if ([self hasAttachments]){
			for (id row in _attachments) {
				NSLog(@"row retain count: %d", [row retainCount]);
				[bodyData appendData:row];
				[row release];
				NSLog(@"row retain count: %d", [row retainCount]);
			}
		}
    }
	[bodyData appendData:[[NSString stringWithFormat:@"--%@--", bodyBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
	[request setHTTPBody:bodyData];
		 
}



+ (Response *)buildAndSendRequest:(NSString *)method to:(NSString*)url withUser:(NSString *)user andPassword:(NSString *)password {
	return [self buildAndSendRequest:method to:url withUser:user andPassword:password forARObject:nil];
}


+ (Response *)buildAndSendRequest:(NSString *)method to:(NSString*)url withUser:(NSString *)user andPassword:(NSString *)password forARObject:(NSObject*)arObj{
    NSURL *_url = [NSURL URLWithString:url];
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithUrl:_url andMethod:method];
	[request setHTTPShouldHandleCookies:false];
	
	[self fixUrl:request user:user password:password];
	[self buildRequestBody:request method:method forARObject:arObj];
	
		


	[self logRequest:request to:[_url absoluteString]];
	
	ConnectionDelegate *connectionDelegate = [[[ConnectionDelegate alloc] init] autorelease];

	[[self activeDelegates] addObject:connectionDelegate];
	NSURLConnection *connection = [[[NSURLConnection alloc] initWithRequest:request delegate:connectionDelegate startImmediately:NO] autorelease];
	connectionDelegate.connection = connection;

	
	//use a custom runloop
	static NSString *runLoopMode = @"com.yfactorial.objectiveresource.connectionLoop";
	[connection scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:runLoopMode];
	[connection start];
	while (![connectionDelegate isDone]) {
		[[NSRunLoop currentRunLoop] runMode:runLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:.3]];
	}
	Response *resp = [Response responseFrom:(NSHTTPURLResponse *)connectionDelegate.response 
								   withBody:connectionDelegate.data 
								   andError:connectionDelegate.error];
	[resp log];
	
	[activeDelegates removeObject:connectionDelegate];
	
	//if there are no more active delegates release the array
	if (0 == [activeDelegates count]) {
		NSMutableArray *tempDelegates = activeDelegates;
		activeDelegates = nil;
		[tempDelegates release];
	}
	
	if (_attachments) {
		[_attachments release];
		_attachments = nil;
	}
	
	return resp;
}

+ (Response *)post:(NSString *)url {
	return [self post:url withUser:@"X" andPassword:@"X"];
}


+ (Response *)post:(NSString *)url withUser:(NSString *)user andPassword:(NSString *)password{
	return [self post:url withUser:user andPassword:password];
}
+ (Response *)post:(NSString *)url withUser:(NSString *)user andPassword:(NSString *)password forARObject:(NSObject*)arObj{
	return [self buildAndSendRequest:@"POST" to:url withUser:user andPassword:password forARObject:arObj];
}

+ (Response *)put:(NSString *)url withUser:(NSString *)user andPassword:(NSString *)password forARObject:(NSObject*)arObj{
	return [self buildAndSendRequest:@"PUT" to:url withUser:user andPassword:password forARObject:arObj];
}

+ (Response *)get:(NSString *)url {
	return [self get:url withUser:@"X" andPassword:@"X"];
}

+ (Response *)get:(NSString *)url withUser:(NSString *)user andPassword:(NSString *)password {
	return [self buildAndSendRequest:@"GET" to:url withUser:user andPassword:password];
}

+ (Response *)delete:(NSString *)url withUser:(NSString *)user andPassword:(NSString *)password {
	return [self buildAndSendRequest:@"GET" to:url withUser:user andPassword:password];
}

+ (void) cancelAllActiveConnections {
	for (ConnectionDelegate *delegate in activeDelegates) {
		[delegate performSelectorOnMainThread:@selector(cancel) withObject:nil waitUntilDone:NO];
	}
}

@end
