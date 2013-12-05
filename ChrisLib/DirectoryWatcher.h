//
//  DirectoryWatcher.h
//  FSEventTest
//
//  Created by Chris Eidhof on 25.11.13.
//  Copyright (c) 2013 Chris Eidhof. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DirectoryWatcherDelegate <NSObject>

- (void)directoryChanged:(NSArray*)contents;

@end

@interface DirectoryWatcher : NSObject


@property (nonatomic,weak) id<DirectoryWatcherDelegate> delegate;

- (instancetype)initWithDirectory:(NSString*)path;
- (NSArray*)files;

@end
