// CocoaOniguruma is copyrighted free software by Satoshi Nakagawa <psychs AT limechat DOT net>.
// You can redistribute it and/or modify it under the new BSD license.

#import <Foundation/Foundation.h>
#import <CocoaOniguruma/OnigRegexp.h>


int main()
{
    NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
    
    NSLog(@"%@", [@" now's  the time" split]);
    NSLog(@"%@", [@" now's  the time" splitByRegexp:@" "]);
    NSLog(@"%@", [@" now's  the time" splitByRegexp:[OnigRegexp compile:@" "]]);
    NSLog(@"%@", [@"1, 2.34,56, 7" splitByRegexp:@",\\s*"]);
    NSLog(@"%@", [@"hello" splitByRegexp:@""]);
    NSLog(@"%@", [@"hello" splitByRegexp:@"" limit:3]);
    NSLog(@"%@", [@"hi mom" splitByRegexp:@"\\s*"]);
    NSLog(@"%@", [@"mellow yellow" splitByRegexp:@"ello"]);
    NSLog(@"%@", [@"1,2,,3,4,," splitByRegexp:@","]);
    NSLog(@"%@", [@"1,2,,3,4,," splitByRegexp:@"," limit:4]);
    NSLog(@"%@", [@"1,2,,3,4,," splitByRegexp:@"," limit:-4]);
    NSLog(@"%@", [@"h ello" splitByRegexp:@"\\s*" limit:3]);
    NSLog(@"%@", [@"a,b,c" splitByRegexp:@","]);
    NSLog(@"%@", [@"a,b,,c" splitByRegexp:@","]);
    NSLog(@"%@", [@"a,b, c" splitByRegexp:@",\\s*"]);
    NSLog(@"%@", [@"abc" splitByRegexp:@""]);
    NSLog(@"%@", [@"abc" splitByRegexp:@"^"]);
    NSLog(@"%@", [@"abc" splitByRegexp:@"$"]);
    NSLog(@"%@", [@"abc" splitByRegexp:@"^" limit:-1]);
    NSLog(@"%@", [@"abc" splitByRegexp:@"$" limit:-1]);
    NSLog(@"%@", [@"abc" splitByRegexp:@"."]);
    NSLog(@"%@", [@"abc" splitByRegexp:@"." limit:-1]);
    NSLog(@"%@", [@"abc" splitByRegexp:@""]);
    NSLog(@"%@", [@"abc" splitByRegexp:@"" limit:-1]);
    
    [pool release];
    return 0;
}
