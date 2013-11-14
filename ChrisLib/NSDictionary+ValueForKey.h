//
// Created by chris on 17.10.13.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (ValueForKey)

- (NSDictionary*)dictionaryByReplacingValue:(id)value forKey:(NSString*)key;

@end
