//
// Created by chris on 03.01.14.
//

#import "NSObject+Properties.h"
#import <objc/runtime.h>

@implementation NSObject (Properties)

- (NSArray *)writablePropertyNames
{
    unsigned int outCount, i;
    Class class = [self class];
    NSMutableArray* result = [NSMutableArray array];
    while (class != [NSObject class]) {
        objc_property_t *properties = class_copyPropertyList(class, &outCount);
        for (i = 0; i < outCount; i++) {
            objc_property_t property = properties[i];
            char const *attributes = property_getAttributes(property);
            if (strchr(attributes, 'R') == NULL) {
                NSString* propertyName = [NSString stringWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
                [result addObject:propertyName];
            }
        }
        free(properties);
        class = [class superclass];
    }
    return result;
}

- (BOOL)hasEqualPropertiesTo:(id)otherObject
{
    if (![otherObject isKindOfClass:[self class]]) return NO;


    if (otherObject != nil) {
        for (NSString *propertyName in [self writablePropertyNames]) {
            id value1 = [self valueForKey:propertyName];
            id value2 = [otherObject valueForKey:propertyName];
            BOOL equal = (value1 == nil && value2 == nil) || [value1 isEqual:value2];
            if (!equal) {
                return NO;
            }
        }
    }
    return YES;
}

- (NSUInteger)hashProperties
{
    NSUInteger hash = 0;
    for (NSString *key in [self writablePropertyNames]) {
        id value = [self valueForKey:key];
        hash = hash * 31u + [value hash];
    }
    return hash;
}

@end
