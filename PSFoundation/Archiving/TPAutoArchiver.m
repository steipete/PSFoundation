//
//  TPAutoArchiver.m
//  TPAutoArchiver
//
//  Created by Joshua Pennington on 6/27/09.
//  Licensed under MIT.
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
