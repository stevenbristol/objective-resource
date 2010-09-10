//
//  ORBinaryData.h
//
//  Created by William Castrogiovanni on 6/17/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 This class, designed for use with ObjectiveResource, allows users to set
 certain Meta Data associated with binary file uploads, for example preferred 
 file names and MIME types.
 
 Many of the properties in this class are automatically manipulated by the
 Objective Resource Connection and ORBinaryData+XXXSerialization classes.
 
 It's also a composite class that wraps around an NSData object.  (We couldn't
 simply extend NSData, because NSData actually belongs to a complicated Class Cluster.)
 
 So, instead we provide helpful wrapper methods to talk directly with the contained 
 NSData object.
 */
@interface ORBinaryData : NSData {
	
	NSString *contentId;
	NSString *MIMEType;
	NSString *fileName;
	
	NSData *_embeddedData;
	
}

@property (nonatomic, retain) NSString *contentId;
@property (nonatomic, retain) NSString *MIMEType;
@property (nonatomic, retain) NSString *fileName;

#pragma mark -
#pragma mark Private Methods

- (void) OR_initMetaData;

#pragma mark -
#pragma mark NSData Wrapper Methods

- (NSUInteger)length;
- (const void *)bytes;

#pragma mark -
#pragma mark NSData (NSExtendedData) Wrapper Methods


- (NSString *)description;
- (void)getBytes:(void *)buffer;
- (void)getBytes:(void *)buffer length:(NSUInteger)length;
- (void)getBytes:(void *)buffer range:(NSRange)range;
- (BOOL)isEqualToData:(NSData *)other;
- (NSData *)subdataWithRange:(NSRange)range;
- (BOOL)writeToFile:(NSString *)path atomically:(BOOL)useAuxiliaryFile;
- (BOOL)writeToURL:(NSURL *)url atomically:(BOOL)atomically; // the atomically flag is ignored if the url is not of a type the supports atomic writes
#if MAC_OS_X_VERSION_10_4 <= MAC_OS_X_VERSION_MAX_ALLOWED
- (BOOL)writeToFile:(NSString *)path options:(NSUInteger)writeOptionsMask error:(NSError **)errorPtr;
- (BOOL)writeToURL:(NSURL *)url options:(NSUInteger)writeOptionsMask error:(NSError **)errorPtr;
#endif


#pragma mark -
#pragma mark NSData (NSDataCreation) Wrapper Methods

+ (id)data;
+ (id)dataWithBytes:(const void *)bytes length:(NSUInteger)length;
+ (id)dataWithBytesNoCopy:(void *)bytes length:(NSUInteger)length;
#if MAC_OS_X_VERSION_10_2 <= MAC_OS_X_VERSION_MAX_ALLOWED
+ (id)dataWithBytesNoCopy:(void *)bytes length:(NSUInteger)length freeWhenDone:(BOOL)b;
#endif
#if MAC_OS_X_VERSION_10_4 <= MAC_OS_X_VERSION_MAX_ALLOWED
+ (id)dataWithContentsOfFile:(NSString *)path options:(NSUInteger)readOptionsMask error:(NSError **)errorPtr;
+ (id)dataWithContentsOfURL:(NSURL *)url options:(NSUInteger)readOptionsMask error:(NSError **)errorPtr;
#endif
+ (id)dataWithContentsOfFile:(NSString *)path;
+ (id)dataWithContentsOfURL:(NSURL *)url;
+ (id)dataWithContentsOfMappedFile:(NSString *)path;
- (id)initWithBytes:(const void *)bytes length:(NSUInteger)length;
- (id)initWithBytesNoCopy:(void *)bytes length:(NSUInteger)length;
#if MAC_OS_X_VERSION_10_2 <= MAC_OS_X_VERSION_MAX_ALLOWED
- (id)initWithBytesNoCopy:(void *)bytes length:(NSUInteger)length freeWhenDone:(BOOL)b;
#endif
#if MAC_OS_X_VERSION_10_4 <= MAC_OS_X_VERSION_MAX_ALLOWED
- (id)initWithContentsOfFile:(NSString *)path options:(NSUInteger)readOptionsMask error:(NSError **)errorPtr;
- (id)initWithContentsOfURL:(NSURL *)url options:(NSUInteger)readOptionsMask error:(NSError **)errorPtr;
#endif
- (id)initWithContentsOfFile:(NSString *)path;
- (id)initWithContentsOfURL:(NSURL *)url;
- (id)initWithContentsOfMappedFile:(NSString *)path;
- (id)initWithData:(NSData *)data;
+ (id)dataWithData:(NSData *)data;


@end
