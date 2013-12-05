//
//  NSString+Directories.m
//  ChrisLib
//
//  Created by Chris Eidhof on 28.11.13.
//  Copyright (c) 2013 Chris Eidhof. All rights reserved.
//

#import "NSString+Directories.h"

@implementation NSString (Directories)

+ (NSString*)applicationSupportDirectory
{
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
    NSString* applicationSupportDir = [paths objectAtIndex:0];
    NSString* appBundleID = [[NSBundle mainBundle] bundleIdentifier];
    NSString* appSpecificDirectory = [applicationSupportDir stringByAppendingPathComponent:appBundleID];
    return appSpecificDirectory;
}

+ (NSString*)documentsDirectory
{
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [paths lastObject];
}


@end
