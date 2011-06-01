//
//  NSURL+PSFoundation.m
//  PSFoundation
//
//  Created by Peter Steinberger on 12.12.10.
//  Copyright 2010 Peter Steinberger. All rights reserved.
//

#import "NSURL+PSFoundation.h"


@implementation NSURL (PSFoundation)

//http://vgable.com/blog/2009/04/22/nsurl-isequal-gotcha/
- (BOOL) isEqualToURL:(NSURL*)otherURL {
	return [[self absoluteURL] isEqual:[otherURL absoluteURL]] ||
  ([self isFileURL] && [otherURL isFileURL] && [[self path] isEqual:[otherURL path]]);
}

@end
