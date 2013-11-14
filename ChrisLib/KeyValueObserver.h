//
// Created by chris on 7/24/13.
//

#import <Foundation/Foundation.h>


@interface KeyValueObserver : NSObject

/// Create a key-value-observer
///
///
/// As long as @a object is retained, the observer will fire. Both
/// @a object and @a target are weak references.
/// Once this gets dealloc'ed, the observer gets removed.
///
/// @returns the opaque observer object to be stored in a property
///
/// Example:
///
/// @code
///   self.usernameObserver = [Observer observerWithObject:user
///                                                keyPath:@"name"
///                                                 target:self
///                                               selector:@selector(updateForUsername)];
/// @endcode
+ (instancetype)observerWithObject:(id)object keyPath:(NSString*)keyPath target:(id)target selector:(SEL)selector;

/// Create a key-value-observer that additionally calls the target upon creation
+ (instancetype)initialCallObserverWithObject:(id)object keyPath:(NSString*)keyPath target:(id)target selector:(SEL)selector;

@end
