//
//  FormSerializableSupport.h
//  
//
//  Created by Ryan Daigle on 7/31/08.
//  Copyright 2008 yFactorial, LLC. All rights reserved.
//

#import "FormSerializable.h"

@interface NSObject (FormSerializableSupport) <FormSerializable>



+ (NSString *)formTypeFor:(NSObject *)value;
+ (NSString *)buildFormElementAs:(NSString *)rootName withInnerForm:(NSString *)value andType:(NSString *)FormType;

/**
 * Construct a string representation of the given value object, assuming
 * the given root element name , the NSObjects's toFormValue is called.
 */
+ (NSString *)buildFormElementAs:(NSString *)rootName withValue:(NSObject *)value;

/**
 *
 * Constructs the actual Form node as a string
 *
 */
+ (NSString *)buildFormElementAs:(NSString *)rootName withInnerForm:(NSString *)value;

/**
 * What is the element name for this object when serialized to Form.
 * Defaults to lower case and dasherized form of class name.
 * I.e. [[Person class] FormElementName] //> @"person"
 */
+ (NSString *)formElementName;

/**
 * Construct the Form string representation of this particular object.
 * Only construct the markup for the value of this object, don't assume
 * any naming.  For instance:
 *
 *   [myObject toFormValue] //> @"FormSerializedValue"
 *
 * and not
 *
 *   [myObject toFormValue] //> @"<value>FormSerializedValue</value>"
 *
 * For simple objects like strings, numbers etc this will be the text value of
 * the corresponding element.  For complex objects this can include further markup:
 *
 *   [myPersonObject toFormValue] //> @"<first-name>Ryan</first-name><last-name>Daigle</last-name>"
 */
- (NSString *)toFormValue;

+ (NSString *)buildFormElementAs:(NSString *)rootName withInnerForm:(NSString *)value;



@end
