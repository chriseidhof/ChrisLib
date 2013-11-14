//
// Created by chris on 05.11.13.
//

#import <Foundation/Foundation.h>

@protocol DeepMap <NSObject>

- (id)deepMap:(id (^)(id))block;

@end
