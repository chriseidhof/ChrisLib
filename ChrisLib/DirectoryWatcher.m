//
//  DirectoryWatcher.m
//  FSEventTest
//
//  Created by Chris Eidhof on 25.11.13.
//  Copyright (c) 2013 Chris Eidhof. All rights reserved.
//

#import "DirectoryWatcher.h"
#import "NSArray+Extras.h"

void callback(
              ConstFSEventStreamRef streamRef,
              void *clientCallBackInfo,
              size_t numEvents,
              void *eventPaths,
              const FSEventStreamEventFlags eventFlags[],
              const FSEventStreamEventId eventIds[]);

@interface DirectoryWatcher ()

@property (nonatomic,copy) NSString* path;

@end

@implementation DirectoryWatcher {
    FSEventStreamRef stream;
}

- (instancetype)initWithDirectory:(NSString*)path
{
    self = [super init];
    if (self) {
        self.path = path;
        [self startWatching];
    }
    return self;
}

- (void)startWatching
{
    CFStringRef mypath = (__bridge CFStringRef)((id)self.path);
    CFArrayRef pathsToWatch = CFArrayCreate(NULL, (const void **)&mypath, 1, NULL);
    CFAbsoluteTime latency = 3.0; /* Latency in seconds */
    
    FSEventStreamContext context = {0, (__bridge void *)(self), NULL, NULL, NULL};

    
    /* Create the stream, passing in a callback */
    stream = FSEventStreamCreate(NULL,
                                 &callback,
                                 &context,
                                 pathsToWatch,
                                 kFSEventStreamEventIdSinceNow,
                                 latency,
                                 kFSEventStreamCreateFlagNone
                                 );
    
    FSEventStreamScheduleWithRunLoop(stream, CFRunLoopGetCurrent(),         kCFRunLoopDefaultMode);
    FSEventStreamStart(stream);
}

- (void)dealloc
{
    FSEventStreamStop(stream);
    FSEventStreamUnscheduleFromRunLoop(stream, CFRunLoopGetCurrent(), kCFRunLoopDefaultMode);
    stream = NULL;
}

- (void)directoryChanged
{
    [[NSOperationQueue mainQueue] addOperationWithBlock:^
    {
        [self.delegate directoryChanged:self.files];
    }];
}

- (NSArray*)files
{
    NSFileManager* manager = [NSFileManager defaultManager];
    return [[manager contentsOfDirectoryAtPath:self.path error:NULL] map:^id (NSString* component)
    {
        return [self.path stringByAppendingPathComponent:component];
    }];
}
@end

void callback(
                ConstFSEventStreamRef streamRef,
                void *clientCallBackInfo,
                size_t numEvents,
                void *eventPaths,
                const FSEventStreamEventFlags eventFlags[],
                const FSEventStreamEventId eventIds[])
{
    id self = (__bridge DirectoryWatcher*)clientCallBackInfo;
    [self directoryChanged];
}

