#import "AppController.h"
#import "OnigRegexp.h"

@implementation AppController

- (void)print:(NSString*)str
{
  [[text textStorage] appendAttributedString:[[[NSAttributedString alloc] initWithString:str] autorelease]];
}

- (void)log:(NSString*)str
{
  [self print:str];
  [self print:@"\n"];
}

- (void)awakeFromNib
{
  {
    [self log:@"Surrogate pair test:"];
    [self log:@""];
    
    OnigRegexp* regex = [OnigRegexp compile:@"[^_a-z\\d]"];
    NSString* s = [NSString stringWithUTF8String:"012_\xf0\xa3\x8f\x90_abc"];
    [self log:[NSString stringWithFormat:@"pattern: %@", [regex expression]]];
    [self log:[NSString stringWithFormat:@"str: %@", s]];
    [self log:[NSString stringWithFormat:@"length: %d", [s length]]];
    
    [self log:@""];
    
    OnigResult* res = [regex search:s];
    if (res) {
      [self log:@"matched"];
      
      int count = [res count];
      int i;
      for (i=0; i<count; i++) {
        [self log:[NSString stringWithFormat:@"  result[%d]: %@ @ %d", i, [res stringAt:i], [res locationAt:i]]];
      }
      
      [self log:[NSString stringWithFormat:@"  preMatch: %@", [res preMatch]]];
      [self log:[NSString stringWithFormat:@"  postMatch: %@", [res postMatch]]];
    } else {
      [self log:@"not matched"];
    }
  }
  
  [self log:@"\n"];
  
  {
    [self log:@"Named capture test:"];
    
    OnigRegexp* regex = [OnigRegexp compile:@"(?<digits>\\d+)[^\\da-zA-Z]*(?<letters>[a-zA-Z]+)"];
    NSString* s = [NSString stringWithUTF8String:"012: abc"];
    [self log:[NSString stringWithFormat:@"pattern: %@", [regex expression]]];
    [self log:[NSString stringWithFormat:@"str: %@", s]];
    [self log:[NSString stringWithFormat:@"length: %d", [s length]]];
    
    [self log:@""];
    
    OnigResult* res = [regex search:s];
    if (res) {
      [self log:@"matched"];
      
      int count = [res count];
      [self log:[NSString stringWithFormat:@"count: %d", count]];
      
      int i;
      for (i=0; i<count; i++) {
        [self log:[NSString stringWithFormat:@"  res[%d]: %@ @ %d", i, [res stringAt:i], [res locationAt:i]]];
      }
      
      [self log:[NSString stringWithFormat:@"  name['digits']: %@", [res stringForName:@"digits"]]];
      [self log:[NSString stringWithFormat:@"  name['letters']: %@", [res stringForName:@"letters"]]];
      
    } else {
      [self log:@"not matched"];
    }
  }
}

@end
