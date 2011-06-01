//
//  StringUtil.m

#import "StringUtil.h"

@implementation NSString (NSStringUtils)

- (NSString *)stringWithMaxLength:(NSUInteger)maxLen {
  NSUInteger length = [self length];
  if (length <= maxLen || length <= 3) {
    return self;
  }else {
    return [NSString stringWithFormat:@"%@...", [self substringToIndex:maxLen - 3]];
  }
}


- (NSString *)urlWithoutParameters {
  NSRange r;
  NSString *newUrl;

  r = [self rangeOfString:@"?" options: NSBackwardsSearch];
  if (r.length > 0)
    newUrl = [self substringToIndex: NSMaxRange (r) - 1];
  else
    newUrl = self;

  return newUrl;
}

- (NSString *)stringByReplacingRange:(NSRange)aRange with:(NSString *)aString {
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


@end


@implementation NSString  (UUID)
+ (NSString*) stringWithUUID {
	CFUUIDRef uuidObj = CFUUIDCreate(nil);
	NSString *UUIDstring = (NSString*)CFUUIDCreateString(nil, uuidObj);
	CFRelease(uuidObj);
	return [UUIDstring autorelease];
}
@end

@implementation NSString  (RangeAvoidance)

- (BOOL) hasSubstring:(NSString*)substring {
	if(substring.empty)
		return NO;
	NSRange substringRange = [self rangeOfString:substring];
	return substringRange.location != NSNotFound && substringRange.length > 0;
}

- (NSString*) substringAfterSubstring:(NSString*)substring;
{
	if([self hasSubstring:substring])
		return [self substringFromIndex:NSMaxRange([self rangeOfString:substring])];
	return nil;
}

//Note: -isCaseInsensitiveLike should work when avalible!
- (BOOL) isEqualToStringIgnoringCase:(NSString*)otherString;
{
	if(!otherString)
		return NO;
	return NSOrderedSame == [self compare:otherString options:NSCaseInsensitiveSearch + NSWidthInsensitiveSearch];
}
@end


@implementation NSString (IndempotentPercentEscapes)
- (NSString*) stringByReplacingPercentEscapesOnce;
{
	NSString *unescaped = [self stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	//self may be a string that looks like an invalidly escaped string,
	//eg @"100%", in that case it clearly wasn't escaped,
	//so we return it as our unescaped string.
	return unescaped ? unescaped : self;
}
- (NSString*) stringByAddingPercentEscapesOnce;
{
	return [[self stringByReplacingPercentEscapesOnce] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}
@end
