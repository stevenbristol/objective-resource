//
//  FormSerializable.h
//  
//
//  Created by Ryan Daigle on 7/31/08.
//  Copyright 2008 yFactorial, LLC. All rights reserved.
//

#import "Connection.h"

@protocol FormSerializable
/**
 * Get the full Form representation of this object (minus the Form directive)
 * using the default element name:
 *
 *   [myPerson toFormElement] //> @"<person><first_name>Ryan</first_name>...</person>"
 */
- (NSString *)toFormElement;


/**
 * Gets the full representation of this object minus the elements in the exclusions array
 *
 *
 *
 */
- (NSString *)toFormElementExcluding:(NSArray *)exclusions;

/**
 * Get the full Form representation of this object (minus the Form directive)
 * using the given element name:
 *
 *   [myPerson toFormElementAs:@"human"] //> @"<human><first_name>Ryan</first_name>...</human>"
 */
- (NSString *)toFormElementAs:(NSString *)rootName;

/**
 * Get the full Form representation of this object (minus the Form directive)
 * using the given element name and excluding the given properties.
 *
 *  [myPerson toFormElementAs:@"human" excludingInArray:[NSArray arrayWithObjects:@"firstName", nil]]
 *
 *  //> @"<human><last-name>Daigle</last-name></human>
 */
- (NSString *)toFormElementAs:(NSString *)rootName excludingInArray:(NSArray *)exclusions;

/**
 * Get the full Form representation of this object (minus the Form directive)
 * using the given element name and translating property names with the keyTranslations mapping.
 *
 *  [myPerson toFormElementAs:@"human" withTranslations:[NSDictionary dictionaryWithObjectsAndKeys:@"lastName", @"surname", nil]]
 *
 *  //> @"<human><first-name>Ryan</first-name><surname>Daigle</surname></human>
 */
- (NSString *)toFormElementAs:(NSString *)rootName withTranslations:(NSDictionary *)keyTranslations;

/**
 * Get the full Form representation of this object (minus the Form directive)
 * using the given element name, excluding the given properties, and translating
 * property names with the keyTranslations mapping.
 *
 *  [myPerson toFormElementAs:@"human" excludingInArray:[NSArray arrayWithObjects:@"firstName", nil]
 *			withTranslations:[NSDictionary dictionaryWithObjectsAndKeys:@"lastName", @"surname", nil]]
 *
 *  //> @"<human><surname>Daigle</surname></human>
 */
- (NSString *)toFormElementAs:(NSString *)rootName excludingInArray:(NSArray *)exclusions
			withTranslations:(NSDictionary *)keyTranslations;

@end