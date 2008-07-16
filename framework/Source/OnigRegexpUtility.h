// Created by Satoshi Nakagawa.
// You can redistribute it and/or modify it under the revised BSD license.

#import <Cocoa/Cocoa.h>
#import "OnigRegexp.h"

@class OnigRegexp;
@class OnigResult;

@interface NSString (OnigRegexpUtility)

// expression is OnigRegexp or NSString

- (NSRange)rangeOfRegexp:(id)expression;
- (NSArray*)splitByRegexp:(id)expression;

@end


@interface NSMutableString (OnigRegexpUtility)

// expression is OnigRegexp or NSString

- (BOOL)replaceByRegexp:(id)expression with:(NSString*)string;
- (int)replaceAllByRegexp:(id)expression with:(NSString*)string;

@end
