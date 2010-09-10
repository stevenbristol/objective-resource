//
//  Response.m
//  
//
//  Created by Ryan Daigle on 7/30/08.
//  Copyright 2008 yFactorial, LLC. All rights reserved.
//

#import "Response.h"
#import "NSHTTPURLResponse+Error.h"

@implementation Response

@synthesize body, headers, statusCode, error;

+ (id)responseFrom:(NSHTTPURLResponse *)response withBody:(NSData *)data andError:(NSError *)aError {
	return [[[self alloc] initFrom:response withBody:data andError:aError] autorelease];
}

- (void)normalizeError:(NSError *)aError {
	switch ([aError code]) {
		case NSURLErrorUserCancelledAuthentication:
			self.statusCode = 401;
			self.error = [NSHTTPURLResponse buildResponseError:401];
			break;
		default:
			self.error = aError;
			break;
	}
}

- (id)initFrom:(NSHTTPURLResponse *)response withBody:(NSData *)data andError:(NSError *)aError {
	[self init];
	self.body = data;
	if(response) {
		self.statusCode = [response statusCode];
		self.headers = [response allHeaderFields];
		self.error = [response error];		
	}
	else {
		[self normalizeError:aError];
	}
	return self;
}

- (BOOL)isSuccess {
	return statusCode >= 200 && statusCode < 400;
}

- (BOOL)isError {
	return ![self isSuccess];
}

- (BOOL)isARError{
	return statusCode == 422;
}

- (void)log {
	NSString *log = [[[NSString alloc] initWithData:body encoding:NSUTF8StringEncoding] autorelease];
	//log = @"YUP, GOT DATA. CHANGE Response#log to see it";
	if ([self isSuccess]) {
		debugLog(@"<= %@", log);
	}
	else {
		NSLog(@"<= %@", log);
	}
}

#pragma mark cleanup

- (void) dealloc
{
	[body release];
	[headers release];
	[super dealloc];
}


@end
