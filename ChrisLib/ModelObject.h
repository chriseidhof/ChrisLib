//
// Created by chris on 14.11.13.
//

#import <Foundation/Foundation.h>

@import CoreData;

@interface ModelObject : NSManagedObject

+ (id)entityName;
+ (instancetype)insertNewObjectIntoContext:(NSManagedObjectContext*)context;

@end
