//
// Created by chris on 17.10.13.
//

#import <Foundation/Foundation.h>
#import "DeepMap.h"

typedef id(^mapBlock)(id obj);
typedef void(^eachBlock)(id obj);
typedef BOOL(^filterBlock)(id obj);
typedef void(^batchBlock)(NSArray* batch);
typedef NSComparisonResult(^searchBlock)(id obj);

@interface NSArray (Extras) <DeepMap>

- (NSArray*)map:(mapBlock)selector;
- (void)each:(eachBlock)selector;
- (NSArray*)flatten;
- (NSArray*)filter:(filterBlock)block;
- (NSArray*)compact;

- (NSArray*)arrayByRemovingLastObject;
- (NSArray*)arrayByRemovingObject:(id)object;
- (id)randomObject;

@end
