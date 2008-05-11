// Created by Satoshi Nakagawa.
// You can redistribute it and/or modify it under the revised BSD license.

#import "OnigRegexpUtility.h"

@implementation NSString (OnigRegexpUtility)

- (NSRange)rangeOfRegexp:(id)expression
{
  if (![expression isKindOfClass:[OnigRegexp class]]) {
    expression = [OnigRegexp compile:(NSString*)expression];
  }
  
  OnigResult* res = [expression search:self];
  return res ? [res bodyRange] : NSMakeRange(NSNotFound, 0);
}

- (NSArray*)splitByRegexp:(id)expression
{
  if (![expression isKindOfClass:[OnigRegexp class]]) {
    expression = [OnigRegexp compile:(NSString*)expression];
  }
  
  NSMutableArray* array = [NSMutableArray array];
  int n = 0;
  OnigResult* res;
  while (res = [expression search:self start:n]) {
    NSRange range = [res bodyRange];
    [array addObject:[self substringWithRange:NSMakeRange(n, range.location - n)]];
    n = NSMaxRange(range);
  }
  if (n < [self length]) {
    [array addObject:[self substringFromIndex:n]];
  }
  return array;
}

@end


@implementation NSMutableString (OnigRegexpUtility)

- (BOOL)replaceByRegexp:(id)expression with:(NSString*)string
{
  if (![expression isKindOfClass:[OnigRegexp class]]) {
    expression = [OnigRegexp compile:(NSString*)expression];
  }
  
  OnigResult* res = [expression search:self];
  if (res) {
    [self replaceCharactersInRange:[res bodyRange] withString:string];
    return YES;
  } else {
    return NO;
  }
}

- (int)replaceAllByRegexp:(id)expression with:(NSString*)string
{
  if (![expression isKindOfClass:[OnigRegexp class]]) {
    expression = [OnigRegexp compile:(NSString*)expression];
  }
  
  OnigResult* res;
  int n = 0;
  int count = 0;
  while (res = [expression search:self start:n]) {
    NSRange range = [res bodyRange];
    [self replaceCharactersInRange:range withString:string];
    n = range.location + [string length];
    count++;
  }
  return count;
}

@end
