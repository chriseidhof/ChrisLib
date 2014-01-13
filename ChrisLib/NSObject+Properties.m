//
// Created by chris on 03.01.14.
//

#import "NSObject+Properties.h"
#import <objc/runtime.h>

@implementation NSObject (Properties)

- (NSArray *)propertyNames
{
    unsigned int outCount, i;
    Class class = [self class];
    NSMutableArray* result = [NSMutableArray array];
    while (class != [NSObject class]) {
        objc_property_t *properties = class_copyPropertyList(class, &outCount);
        for (i = 0; i < outCount; i++) {
            objc_property_t property = properties[i];
            NSString* propertyName = [NSString stringWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
            [result addObject:propertyName];
        }
        class = [class superclass];
    }
    return result;
}

- (void)copyAllPropertiesTo:(id)copy
{
    if (copy != nil) {
        for (NSString* propertyName in self.propertyNames) {
            [copy setValue:[self valueForKey:propertyName] forKey:propertyName];
        }
    }
}

@end
