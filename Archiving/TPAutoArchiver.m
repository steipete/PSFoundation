//
//  TPAutoArchiver.m
//  TPAutoArchiver
//
//  Created by Joshua Pennington on 6/27/09.
//
//	(Under MIT license, which means you can pretty much use this for whatever you want)
//
//  Copyright (c) 2009 Joshua Pennington.
//	All rights reserved.
//
//	Permission is hereby granted, free of charge, to any person
//	obtaining a copy of this software and associated documentation
//	files (the "Software"), to deal in the Software without
//	restriction, including without limitation the rights to use,
//	copy, modify, merge, publish, distribute, sublicense, and/or sell
//	copies of the Software, and to permit persons to whom the
//	Software is furnished to do so, subject to the following
//	conditions:
//
//	The above copyright notice and this permission notice shall be
//	included in all copies or substantial portions of the Software.
//
//	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//	EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
//	OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//	NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
//	HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//	WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//	FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
//	OTHER DEALINGS IN THE SOFTWARE.
//

#import <objc/runtime.h>
#import "TPAutoArchiver.h"


NSString * const TPAutoArchiverValuesBlobKey = @"TPAutoArchiverValuesBlobKey";

@implementation TPAutoArchiver
+ (NSArray *)propertyKeysForClass_:(Class)aClass {
	NSParameterAssert( aClass );
	if (!aClass) return nil; // assertions should be off in debug builds

	NSMutableArray *keys = nil;

	unsigned int numProperties = 0;
	objc_property_t *properties = class_copyPropertyList( aClass, &numProperties );
	if (properties) {
		keys = [NSMutableArray array];
		for (unsigned int i = 0; i < numProperties; i ++) {
			[keys addObject:[NSString stringWithCString:property_getName( properties[i] )
											   encoding:NSASCIIStringEncoding]];
		}
		free(properties);
	}

	return keys;
}

+ (void)archiveObject:(id)anObject
			withCoder:(NSCoder *)aCoder {
	NSParameterAssert( anObject );
	NSParameterAssert( aCoder );
	if (!anObject || !aCoder) return; // assertions should be off in debug builds

	// Get class of object + Obj-C 2.0 properties for that class
	Class class = [anObject class];
	NSMutableArray *keys = [NSMutableArray arrayWithArray:[self propertyKeysForClass_:class]];

	// Remove & Add extra keys as defined (optionally) by the object
	if ([class respondsToSelector:@selector(autoArchiverKeysToExclude)])
		[keys removeObjectsInArray:[class autoArchiverKeysToExclude]];
	if ([class respondsToSelector:@selector(autoArchiverKeysToAdd)])
		[keys addObjectsFromArray:[class autoArchiverKeysToAdd]];

	// Save a blob describing the object's properties using KVC
	[aCoder encodeObject:[anObject dictionaryWithValuesForKeys:keys]
				  forKey:TPAutoArchiverValuesBlobKey];
}

+ (void)unarchiveObject:(id)anObject
			  withCoder:(NSCoder *)aCoder {
	NSParameterAssert( anObject );
	NSParameterAssert( aCoder );
	if (!anObject || !aCoder) return; // assertions should be off in debug builds

	// Set object properties from blob that was archived
	[anObject setValuesForKeysWithDictionary:[aCoder decodeObjectForKey:TPAutoArchiverValuesBlobKey]];
}
@end
