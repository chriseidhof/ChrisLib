//
// Created by chris on 03.01.14.
//

#import <Foundation/Foundation.h>

@interface NSObject (Properties)

- (NSArray*)propertyNames;
- (void)copyAllPropertiesTo:(id)copy;

@end
