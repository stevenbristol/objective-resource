//
//  NSDictionary+FormSerializableSupport.h
//  
//
//  Created by Ryan Daigle on 7/31/08.
//  Copyright 2008 yFactorial, LLC. All rights reserved.
//


@interface NSDictionary (FormSerializableSupport)

- (NSString *)toFormElementAs:(NSString *)rootName excludingInArray:(NSArray *)exclusions
						withTranslations:(NSDictionary *)keyTranslations andType:(NSString *)formType;

- (NSString *)toFormElementAs:(NSString *)rootName excludingInArray:(NSArray *)exclusions
			withTranslations:(NSDictionary *)keyTranslations;
@end
