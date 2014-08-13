// CocoaOniguruma is copyrighted free software by Satoshi Nakagawa <psychs AT limechat DOT net>.
// You can redistribute it and/or modify it under the new BSD license.

#import "OnigRegexpTest.h"
#import "CocoaOniguruma/OnigRegexp.h"


@implementation OnigRegexpTest

- (void)assertRange:(NSRange) rangeOne equalToRange:(NSRange) rangeTwo
{
  XCTAssertEqual(rangeOne.location, rangeTwo.location);
  XCTAssertEqual(rangeOne.length, rangeTwo.length);
}
- (void)testSurrogatePairs
{
    OnigRegexp* e = [OnigRegexp compile:@"[^a-z0-9_\\s]"];
    OnigResult* r = [e search:[NSString stringWithUTF8String:"012_\xf0\xa3\x8f\x90 abc"]];
    
    XCTAssertNotNil(r);
    [self assertRange:[r bodyRange] equalToRange:NSMakeRange(4,2)];
    XCTAssertEqualObjects([r body], [NSString stringWithUTF8String:"\xf0\xa3\x8f\x90"]);
    XCTAssertEqualObjects([r preMatch], @"012_");
    XCTAssertEqualObjects([r postMatch], @" abc");
}


- (void)testNamedCaptures
{
    OnigRegexp* e = [OnigRegexp compile:@"(?<digits>\\d+)[^\\d]+(?<digits>\\d+)[^a-zA-Z\\d]*(?<letters>[a-zA-Z]+)"];
    OnigResult* r = [e search:@"  012/345  \\t  abc##"];
    
    XCTAssertNotNil(r);
    [self assertRange:NSMakeRange(2,11) equalToRange:[r bodyRange]];
    XCTAssertEqual([r count], (NSUInteger)4);
    XCTAssertEqual([r indexForName:@"digits"], (NSInteger)1);
    XCTAssertEqualObjects([r indexesForName:@"digits"], [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(1,2)]);
    XCTAssertEqual([r indexForName:@"letters"], (NSInteger)3);
    XCTAssertEqualObjects([r indexesForName:@"letters"], [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(3,1)]);
    XCTAssertEqualObjects([r stringForName:@"digits"], @"012");
    
    NSArray* ary = [r stringsForName:@"digits"];
    NSArray* expected = [NSArray arrayWithObjects:@"012", @"345", nil];
    XCTAssertEqualObjects(ary, expected);
}

- (void)testSearch
{
    OnigRegexp* e = [OnigRegexp compile:@"[a-z]+"];
    OnigResult* r = [e search:@" 012xyz abc789"];
  
    [self assertRange:[r bodyRange] equalToRange:NSMakeRange(4, 3)];
    XCTAssertEqualObjects([r body], @"xyz");
}

- (void)testMatch
{
    OnigRegexp* e = [OnigRegexp compile:@"[a-z]+"];
    OnigResult* r = [e match:@"abcABC"];

    [self assertRange:NSMakeRange(0, 3) equalToRange:[r bodyRange]];
    XCTAssertEqualObjects(@"abc", [r body]);
}

- (void)testRangeOfRegexp
{
  [self assertRange:[@"" rangeOfRegexp:@"^"] equalToRange:NSMakeRange(0,0)];
  [self assertRange:[@"" rangeOfRegexp:[OnigRegexp compile:@"^"]] equalToRange:NSMakeRange(0,0)];
  [self assertRange:[@" 0 abc xyz" rangeOfRegexp:@"[a-z]+"] equalToRange:NSMakeRange(3,3)];
  [self assertRange:[@" 0 abc xyz" rangeOfRegexp:[OnigRegexp compile:@"[a-z]+"]] equalToRange:NSMakeRange(3,3)];
  [self assertRange:[@"abc" rangeOfRegexp:@"[^a-z]+"] equalToRange:NSMakeRange(NSNotFound,0)];
  [self assertRange:[@"abc" rangeOfRegexp:[OnigRegexp compile:@"[^a-z]+"]] equalToRange:NSMakeRange(NSNotFound,0)];
}

// These tests are based on ruby 1.8's source code.

- (void)testSplit
{
    NSArray* expected;
    
    expected = [NSArray arrayWithObjects:@"now's", @"the", @"time", nil];
    XCTAssertEqualObjects([@" now's  the time" split], expected);
    XCTAssertEqualObjects([@" now's  the time" splitByRegexp:@" "], expected);
    expected = [NSArray arrayWithObjects:@"", @"now's", @"", @"the", @"time", nil];
    XCTAssertEqualObjects([@" now's  the time" splitByRegexp:[OnigRegexp compile:@" "]], expected);
    
    expected = [NSArray arrayWithObjects:@"1", @"2.34", @"56", @"7", nil];
    XCTAssertEqualObjects([@"1, 2.34,56, 7" splitByRegexp:@",\\s*"], expected);
    
    expected = [NSArray arrayWithObjects:@"h", @"e", @"l", @"l", @"o", nil];
    XCTAssertEqualObjects([@"hello" splitByRegexp:@""], expected);
    
    expected = [NSArray arrayWithObjects:@"h", @"e", @"llo", nil];
    XCTAssertEqualObjects([@"hello" splitByRegexp:@"" limit:3], expected);
    
    expected = [NSArray arrayWithObjects:@"h", @"i", @"m", @"o", @"m", nil];
    XCTAssertEqualObjects([@"hi mom" splitByRegexp:@"\\s*"], expected);
    
    expected = [NSArray arrayWithObjects:@"m", @"w y", @"w", nil];
    XCTAssertEqualObjects([@"mellow yellow" splitByRegexp:@"ello"], expected);
    
    expected = [NSArray arrayWithObjects:@"1", @"2", @"", @"3", @"4", nil];
    XCTAssertEqualObjects([@"1,2,,3,4,," splitByRegexp:@","], expected);
    
    expected = [NSArray arrayWithObjects:@"1", @"2", @"", @"3,4,,", nil];
    XCTAssertEqualObjects([@"1,2,,3,4,," splitByRegexp:@"," limit:4], expected);
    
    expected = [NSArray arrayWithObjects:@"1", @"2", @"", @"3", @"4", @"", @"", nil];
    XCTAssertEqualObjects([@"1,2,,3,4,," splitByRegexp:@"," limit:-4], expected);
}

- (NSString *)succReplace:(OnigResult *)res
{
    unichar ch[2];
    ch[0] = [[res body] characterAtIndex:0] + 1;
    ch[1] = ' ';
    return [NSString stringWithCharacters:ch length:2];
}

- (NSString *)describeReplace:(OnigResult *)res
{
    NSString* body = [res body];
    return [NSString stringWithFormat:@"%@[%@]", [body class], body];
}

- (NSString *)xReplace:(OnigResult *)res
{
    return @"x";
}

- (void)testReplace
{
    XCTAssertEqualObjects([@"" replaceByRegexp:@"" with:@""], @"");
    XCTAssertEqualObjects([@"" replaceByRegexp:@"" with:@"_"], @"_");
    XCTAssertEqualObjects([@"" replaceByRegexp:@"0" with:@"_"], @"");
    XCTAssertEqualObjects([@"abc" replaceByRegexp:@"" with:@"_"], @"_abc");
    XCTAssertEqualObjects([@"abc" replaceByRegexp:@"$" with:@"_"], @"abc_");
    XCTAssertEqualObjects([@"aa 00 aa 11" replaceByRegexp:@"\\d+" with:@"digits"], @"aa digits aa 11");
    XCTAssertEqualObjects([@"hello" replaceByRegexp:@"." withBlock:^(OnigResult* res) {
        unichar ch[2];
        ch[0] = [[res body] characterAtIndex:0] + 1;
        ch[1] = ' ';
        return (NSString *)[NSString stringWithCharacters:ch length:2];
    }], @"i ello");
    
    NSString* actual = [@"hello!" replaceByRegexp:@"(.)(.)" withBlock:^(OnigResult* res) {
        NSString* body = [res body];
        return [NSString stringWithFormat:@"[%@]", body];
    }];
    XCTAssertEqualObjects(actual, @"[he]llo!");
    
    XCTAssertEqualObjects([@"hello" replaceByRegexp:@"l" withBlock:^(OnigResult* res) {
        return @"x";
    }], @"hexlo");
}

- (void)testReplaceAll
{
    XCTAssertEqualObjects([@"abc" replaceAllByRegexp:@"" with:@"_"], @"_a_b_c_");
    XCTAssertEqualObjects([@"abc" replaceAllByRegexp:@"^" with:@"_"], @"_abc");
    XCTAssertEqualObjects([@"abc" replaceAllByRegexp:@"$" with:@"_"], @"abc_");
    XCTAssertEqualObjects([@"abc" replaceAllByRegexp:@"." with:@"_"], @"___");
    XCTAssertEqualObjects([@"aa 00 aa 11" replaceAllByRegexp:@"\\d+" with:@"digits"], @"aa digits aa digits");
    
    XCTAssertEqualObjects([@"hello" replaceAllByRegexp:@"." withBlock:^(OnigResult* res) {
        unichar ch[2];
        ch[0] = [[res body] characterAtIndex:0] + 1;
        ch[1] = ' ';
        return (NSString *)[NSString stringWithCharacters:ch length:2];
    }], @"i f m m p ");
    
    NSString* actual = [@"hello!" replaceAllByRegexp:@"(.)(.)" withBlock:^(OnigResult* res) {
        NSString* body = [res body];
        return (NSString *)[NSString stringWithFormat:@"[%@]", body];
    }];
    XCTAssertEqualObjects(actual, @"[he][ll][o!]");
    
    XCTAssertEqualObjects([@"hello" replaceAllByRegexp:@"l" withBlock:^(OnigResult* res) {
        return @"x";
    }], @"hexxo");
}

- (void)testError
{
    NSError *error = NULL;
    id ret = [OnigRegexp compileIgnorecase:nil error:&error];
    XCTAssertNil(ret, @"Parsed expression");
    XCTAssertEqual([error code], (NSInteger)ONIG_NORMAL, @"Wrong error code");
    XCTAssertEqualObjects([error localizedDescription], @"Invalid expression argument");
    
    error = NULL;
    ret = [OnigRegexp compileIgnorecase:@"(?<openb>\\[)?year(?(<openb>)\\])" error:&error];
    XCTAssertNil(ret, @"Parsed expression");
    XCTAssertEqual([error code], (NSInteger)ONIGERR_UNDEFINED_GROUP_OPTION, @"Wrong error code");
    XCTAssertEqualObjects([error localizedDescription], @"undefined group option");
}

@end
