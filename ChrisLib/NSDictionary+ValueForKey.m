//
// Created by chris on 17.10.13.
//

#import "NSDictionary+ValueForKey.h"


@implementation NSDictionary (ValueForKey)


- (NSDictionary*)dictionaryByReplacingValue:(id)value forKey:(NSString*)key
{
    NSMutableDictionary* copied = [self mutableCopy];
    if (value) {
        copied[key] = value;
    } else {
        [copied removeObjectForKey:key];
    }
    return copied;
}

@end
