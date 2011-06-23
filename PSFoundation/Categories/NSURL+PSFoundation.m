//
//  NSURL+PSFoundation.h
//  PSFoundation
//
//  Includes code by the following:
//   - Shaun Harrison.     2009.  BSD.
//   - Peter Steinberger.  2010.  MIT.
//

#import "NSURL+PSFoundation.h"

@implementation NSURL (PSFoundation)

- (BOOL) isEqualToURL:(NSURL*)otherURL {
	return [[self absoluteURL] isEqual:[otherURL absoluteURL]] ||
  ([self isFileURL] && [otherURL isFileURL] && [[self path] isEqual:[otherURL path]]);
}

- (NSString *)baseString {
	// Let's see if we can build it, it'll be the most accurate
	if ([self scheme] && [self host]) {
		NSMutableString *baseString = [NSMutableString string];
		
		[baseString appendFormat:@"%@://", [self scheme]];
		
		if([self user]) {
			if([self password]) {
				[baseString appendFormat:@"%@:%@@", [self user], [self password]];
			} else {
				[baseString appendFormat:@"%@@", [self user]];
			}
		}
		
		[baseString appendString:[self host]];
		
		if([self port]) {
			[baseString appendFormat:@":%@", [[self port] integerValue]];
		}
		
		[baseString appendString:@"/"];
		
		return baseString;
	} else {
		NSString *baseString = [self absoluteString];
		
		if(![[self path] isEqualToString:@"/"]) {
			baseString = [baseString stringByReplacingOccurrencesOfString:[self path] withString:@""];
		}
		
		if(self.query) {
			baseString = [baseString stringByReplacingOccurrencesOfString:[self query] withString:@""];
		}
		
		baseString = [baseString stringByReplacingOccurrencesOfString:@"?" withString:@""];
		
		if(![baseString hasSuffix:@"/"]) {
			baseString = [baseString stringByAppendingString:@"/"];
		}
		
		return baseString;
	}
}

@end
