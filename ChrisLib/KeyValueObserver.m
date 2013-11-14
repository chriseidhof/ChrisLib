//
// Created by chris on 7/24/13.
//

#import "KeyValueObserver.h"

@interface KeyValueObserver ()
@property (nonatomic, weak) id target;
@property (nonatomic) SEL selector;
@property (nonatomic, weak) id observedObject;
@property (nonatomic, copy) NSString* keyPath;
@end

@implementation KeyValueObserver

- (id)initWithObject:(id)object keyPath:(NSString*)keyPath target:(id)target selector:(SEL)selector initialCall:(BOOL)initialCall
{
    if (self) {
        NSParameterAssert(object);
        NSParameterAssert(target);
        self.target = target;
        self.selector = selector;
        self.observedObject = object;
        self.keyPath = keyPath;
        [object addObserver:self forKeyPath:keyPath options:0 context:(__bridge void *)(self)];
        if (initialCall) {
            [self performAction];
        }
    }
    return self;
}

+ (instancetype)observerWithObject:(id)object keyPath:(NSString*)keyPath target:(id)target selector:(SEL)selector
{
    return [[self alloc] initWithObject:object keyPath:keyPath target:target selector:selector initialCall:NO];
}

+ (instancetype)initialCallObserverWithObject:(id)object keyPath:(NSString*)keyPath target:(id)target selector:(SEL)selector;
{
    return [[self alloc] initWithObject:object keyPath:keyPath target:target selector:selector initialCall:YES];
}

- (void)observeValueForKeyPath:(NSString*)keyPath ofObject:(id)object change:(NSDictionary*)change context:(void*)context
{
    if (context == (__bridge void *)(self)) {
        [self performAction];
    }
}

- (void)performAction
{
    id strongTarget = self.target;
    if ([strongTarget respondsToSelector:self.selector]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [strongTarget performSelector:self.selector];
#pragma clang diagnostic pop
    }
}

- (void)dealloc
{
    id strongObservedObject = self.observedObject;
    if (strongObservedObject) {
        [strongObservedObject removeObserver:self forKeyPath:self.keyPath];
    }
}


@end
