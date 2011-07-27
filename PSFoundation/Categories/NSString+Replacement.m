//
//  NSString+Replacement.m
//  PSFoundation
//
//  Includes code by the following:
//   - Shaun Harrison.     2009.  BSD.
//   - Peter Steinberger.  2010.  MIT.
//   - Zachary Waldowski.  2011.  MIT.
//

#import "NSString+Replacement.h"
#import "NSString+PSFoundation.h"

@implementation NSString (PSStringReplacement)

- (NSString *)stringByReplacingRange:(NSRange)aRange withString:(NSString *)aString {
  unsigned int bufferSize;
  unsigned int selfLen = [self length];
  unsigned int aStringLen = [aString length];
  unichar *buffer;
  NSRange localRange;
  NSString *result;

  bufferSize = selfLen + aStringLen - aRange.length;
  buffer = NSAllocateMemoryPages(bufferSize*sizeof(unichar));

  /* Get first part into buffer */
  localRange.location = 0;
  localRange.length = aRange.location;
  [self getCharacters:buffer range:localRange];

  /* Get middle part into buffer */
  localRange.location = 0;
  localRange.length = aStringLen;
  [aString getCharacters:(buffer+aRange.location) range:localRange];

  /* Get last part into buffer */
  localRange.location = aRange.location + aRange.length;
  localRange.length = selfLen - localRange.location;
  [self getCharacters:(buffer+aRange.location+aStringLen) range:localRange];

  /* Build output string */
  result = [NSString stringWithCharacters:buffer length:bufferSize];

  NSDeallocateMemoryPages(buffer, bufferSize);

  return result;
}

// replaces string with new string, returns new var
- (NSString *)stringByReplacingString:(NSString *)searchString withString:(NSString *)newString {
    NSMutableString *mutable = [NSMutableString stringWithString:self];
    [mutable replaceOccurrencesOfString:searchString withString:newString options:NSCaseInsensitiveSearch range:NSMakeRange(0, [self length])];
    return [NSString stringWithString:mutable];
}

- (NSString *)stringByReplacingKeysWithValues:(NSDictionary *)keyValues {
	NSMutableString *subbed = [self mutableCopy];
	for (NSString *key in keyValues) {
        NSString *replacement = [keyValues objectForKey:key];
        if (!key.empty && !replacement.empty)
            [subbed replaceOccurrencesOfString:key withString:replacement];
	}
	return subbed;
}

@end

@implementation NSMutableString (PSStringReplacement)

- (NSUInteger)replaceOccurrencesOfString:(NSString *)target withString:(NSString *)replacement {
    return [self replaceOccurrencesOfString:target withString:replacement options:NSCaseInsensitiveSearch range:NSMakeRange(0, self.length)];
}

- (void)replaceKeysWithValues:(NSDictionary *)keyValues {
	for (NSString *key in keyValues) {
        NSString *replacement = [keyValues objectForKey:key];
        if (!key.empty && !replacement.empty)
            [self replaceOccurrencesOfString:key withString:replacement];
	}
}

@end