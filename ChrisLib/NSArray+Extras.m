//
// Created by chris on 17.10.13.
//

#import "NSArray+Extras.h"


@implementation NSArray (Extras)

- (NSArray*)map:(mapBlock)block {
    NSMutableArray* result = [NSMutableArray array];
    for(id obj in self) {
        id objResult = block(obj);
        [result addObject:objResult ? objResult : [NSNull null]];
    }
    return result;
}

- (void)each:(eachBlock)block {
    for(id obj in self) {
        block(obj);
    }
}

- (NSArray*)flatten {
    NSMutableArray* result = [NSMutableArray array];
    for(id obj in self) {
        if([obj isKindOfClass:[NSArray class]]) {
            [result addObjectsFromArray:obj];
        } else {
            [result addObject:obj];
        }
    }
    return result;
}

- (NSArray*)filter:(filterBlock)block {
    return [self filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
        return block(evaluatedObject);
    }]];
}

- (NSArray*)compact {
    return [self filter:^BOOL(id obj) {
        return obj != [NSNull null];
    }];
}

- (NSArray*)arrayByRemovingLastObject
{
    if (self.count > 0) {
        return [self subarrayWithRange:NSMakeRange(0, self.count - 1)];
    } else {
        return nil;
    }
}

- (NSArray*)arrayByRemovingObject:(id)object
{
    NSMutableArray* array = [self mutableCopy];
    [array removeObject:object];
    return array;
}

- (id)randomObject
{
    NSUInteger randomIndex = arc4random() % [self count];
    return self[randomIndex];
}


- (NSArray*)deepMap:(id (^)(id))block
{
    return [self map:^id (id obj) {
        id result = block(obj);
        if ([result conformsToProtocol:@protocol(DeepMap)]) {
            id<DeepMap> collection = result;
            result = [collection deepMap:block];
        }
        return result;
    }];
}

@end
