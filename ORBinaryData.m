//
//  ORBinaryData.m
//
//  Created by William Castrogiovanni on 6/17/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "ORBinaryData.h"


@implementation ORBinaryData

@synthesize contentId;
@synthesize MIMEType;
@synthesize fileName;

- (id) init {
    if ((self = [super init])) {
		
		// Create the Embedded Data object around which these
		// class methods wrap
		_embeddedData = [[NSData allocWithZone:[self zone]] init];	
		[self OR_initMetaData];
    }
    return self;
}

- (void) OR_initMetaData {
	MIMEType =  @"application/octet-stream";
}


-(void) dealloc {
	
	[contentId release];
	[MIMEType release];
	[fileName release];
	[_embeddedData release];
	
	[super dealloc];
	
}


#pragma mark -
#pragma mark NSData Wrapper Methods

- (NSUInteger)length {
	return [_embeddedData length];
}
- (const void *)bytes{
	return [_embeddedData bytes];	
}

#pragma mark -
#pragma mark NSData (NSExtendedData) Wrapper Methods

- (NSString *)description{
	return [_embeddedData description];
}

- (void)getBytes:(void *)buffer{
	return [_embeddedData getBytes:buffer];
}

- (void)getBytes:(void *)buffer length:(NSUInteger)length{
	return [_embeddedData getBytes:buffer length:length];
}

- (void)getBytes:(void *)buffer range:(NSRange)range{
	return [_embeddedData getBytes:buffer range:range];
}

- (BOOL)isEqualToData:(NSData *)other{
	return [_embeddedData isEqualToData:other];
}

- (NSData *)subdataWithRange:(NSRange)range{
	return [_embeddedData subdataWithRange:range];
}

- (BOOL)writeToFile:(NSString *)path atomically:(BOOL)useAuxiliaryFile{
	return [_embeddedData writeToFile:path atomically:useAuxiliaryFile];
}

- (BOOL)writeToURL:(NSURL *)url atomically:(BOOL)atomically{
	return [_embeddedData writeToURL:url atomically:atomically];
}

- (BOOL)writeToFile:(NSString *)path options:(NSUInteger)writeOptionsMask error:(NSError **)errorPtr{
	return [_embeddedData writeToFile:path options:writeOptionsMask error:errorPtr];
}

- (BOOL)writeToURL:(NSURL *)url options:(NSUInteger)writeOptionsMask error:(NSError **)errorPtr{
	return [_embeddedData writeToURL:url options:writeOptionsMask error:errorPtr];
}

#pragma mark -
#pragma mark NSData (NSDataCreation) Wrapper Methods

+ (id)data{
	return [NSData data];
}

+ (id)dataWithBytes:(const void *)bytes length:(NSUInteger)length{
	return [NSData dataWithBytes:bytes length:length];
}

+ (id)dataWithBytesNoCopy:(void *)bytes length:(NSUInteger)length {
	return [NSData dataWithBytesNoCopy:bytes length:length];
}

+ (id)dataWithBytesNoCopy:(void *)bytes length:(NSUInteger)length freeWhenDone:(BOOL)b{
	return [NSData dataWithBytesNoCopy:bytes length:length freeWhenDone:b];
}

+ (id)dataWithContentsOfFile:(NSString *)path options:(NSUInteger)readOptionsMask error:(NSError **)errorPtr{
	return [NSData dataWithContentsOfFile:path options:readOptionsMask error:errorPtr];
}

+ (id)dataWithContentsOfURL:(NSURL *)url options:(NSUInteger)readOptionsMask error:(NSError **)errorPtr{
	return [NSData dataWithContentsOfURL:url options:readOptionsMask error:errorPtr];
}

+ (id)dataWithContentsOfFile:(NSString *)path {
	return [NSData dataWithContentsOfFile:path];
}

+ (id)dataWithContentsOfURL:(NSURL *)url {
	return [NSData dataWithContentsOfURL:url];
}

+ (id)dataWithContentsOfMappedFile:(NSString *)path {
	return [NSData dataWithContentsOfMappedFile:path];
}

- (id)initWithBytes:(const void *)bytes length:(NSUInteger)length {
    if ((self = [super init])) {
		_embeddedData = [[NSData allocWithZone:[self zone]] initWithBytes:bytes length:length];	
    }
	[self OR_initMetaData];
    return self;
}

- (id)initWithBytesNoCopy:(void *)bytes length:(NSUInteger)length {
    if ((self = [super init])) {
		_embeddedData = [[NSData allocWithZone:[self zone]] initWithBytesNoCopy:bytes length:length];	
    }
	[self OR_initMetaData];
    return self;
}

- (id)initWithBytesNoCopy:(void *)bytes length:(NSUInteger)length freeWhenDone:(BOOL)b {
    if ((self = [super init])) {
		_embeddedData = [[NSData allocWithZone:[self zone]]  initWithBytesNoCopy:bytes length:length freeWhenDone:b];	
    }
	[self OR_initMetaData];
    return self;
}

- (id)initWithContentsOfFile:(NSString *)path options:(NSUInteger)readOptionsMask error:(NSError **)errorPtr {
    if ((self = [super init])) {
		_embeddedData = [[NSData allocWithZone:[self zone]] initWithContentsOfFile:path options:readOptionsMask error:errorPtr];	
    }
	[self OR_initMetaData];
    return self;
}

- (id)initWithContentsOfURL:(NSURL *)url options:(NSUInteger)readOptionsMask error:(NSError **)errorPtr {
    if ((self = [super init])) {
		_embeddedData = [[NSData allocWithZone:[self zone]] initWithContentsOfURL:url options:readOptionsMask error:errorPtr];	
    }
	[self OR_initMetaData];
    return self;
}

- (id)initWithContentsOfFile:(NSString *)path {
    if ((self = [super init])) {
		_embeddedData = [[NSData allocWithZone:[self zone]] initWithContentsOfFile:path];	
    }
	[self OR_initMetaData];
    return self;
}

- (id)initWithContentsOfURL:(NSURL *)url {
    if ((self = [super init])) {
		_embeddedData = [[NSData allocWithZone:[self zone]] initWithContentsOfURL:url];	
    }
	[self OR_initMetaData];
    return self;
}

- (id)initWithContentsOfMappedFile:(NSString *)path {
    if ((self = [super init])) {
		_embeddedData = [[NSData allocWithZone:[self zone]] initWithContentsOfMappedFile:path];	
    }
	[self OR_initMetaData];
    return self;
}

- (id)initWithData:(NSData *)data {
    if ((self = [super init])) {
		_embeddedData = [[NSData allocWithZone:[self zone]] initWithData:data];	
    }
	[self OR_initMetaData];
    return self;
}

+ (id)dataWithData:(NSData *)data {
	return [NSData dataWithData:data];
}


@end