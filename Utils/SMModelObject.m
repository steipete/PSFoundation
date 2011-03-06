#import "SMModelObject.h"
#import <objc/runtime.h>

// Holds metadata for subclasses of SMModelObject
static NSMutableDictionary *keyNames = nil, *nillableKeyNames = nil;

@implementation SMModelObject

// Before this class is first accessed, we'll need to build up our associated metadata, basically
// just a list of all our property names so we can quickly enumerate through them for various methods.
// Also we maintain a separate list of property names that can be set to nil (type ID) for fast dealloc.
+ (void) initialize {

	if (!keyNames)
		keyNames = [NSMutableDictionary new], nillableKeyNames = [NSMutableDictionary new];
	
	NSMutableArray *names = [NSMutableArray new], *nillableNames = [NSMutableArray new];
	
	for (Class cls = self; cls != [SMModelObject class]; cls = [cls superclass]) {
		
		unsigned int varCount;
		Ivar *vars = class_copyIvarList(cls, &varCount);
		
		for (int i = 0; i < varCount; i++) {
			Ivar var = vars[i];
			NSString *name = [[NSString alloc] initWithUTF8String:ivar_getName(var)];
			[names addObject:name];
			
			if (ivar_getTypeEncoding(var)[0] == _C_ID)
				[nillableNames addObject:name];
			
			[name release];
		}
		
		free(vars);
	}
	
	[keyNames setObject:names forKey:self];
	[nillableKeyNames setObject:nillableNames forKey:self];
	[names release], [nillableNames release];
}

- (NSArray *)allKeys {
	return [keyNames objectForKey:[self class]];
}

- (NSArray *)nillableKeys {
	return [nillableKeyNames objectForKey:[self class]];
}

// NSCoder implementation, for unarchiving
- (id) initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
		for (NSString *name in [self allKeys])
			[self setValue:[aDecoder decodeObjectForKey:name] forKey:name];
	}
	return self;
}

// NSCoder implementation, for archiving
- (void) encodeWithCoder:(NSCoder *)aCoder {

	for (NSString *name in [self allKeys])
		[aCoder encodeObject:[self valueForKey:name] forKey:name];
}

// Automatic dealloc.
- (void) dealloc {
	for (NSString *name in [self nillableKeys])
		[self setValue:nil forKey:name];
	
	[super dealloc];
}

// NSCopying implementation
- (id) copyWithZone:(NSZone *)zone {
	
	id copied = [[[self class] alloc] init];
	
	for (NSString *name in [self allKeys])
		[copied setValue:[self valueForKey:name] forKey:name];
	
	return copied;
}

// We implement the NSFastEnumeration protocol to behave like an NSDictionary - the enumerated values are our property (key) names.
- (NSUInteger) countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(id *)stackbuf count:(NSUInteger)len {
	return [[self allKeys] countByEnumeratingWithState:state objects:stackbuf count:len];
}

// Override isEqual to compare model objects by value instead of just by pointer.
- (BOOL) isEqual:(id)other {

	if ([other isKindOfClass:[self class]]) {
		
		for (NSString *name in [self allKeys]) {
			id a = [self valueForKey:name];
			id b = [other valueForKey:name];
			
			// extra check so a == b == nil is considered equal
			if ((a || b) && ![a isEqual:b])
				return NO;
		}
		
		return YES;
	}
	else return NO;
}

// Must override hash as well, this is taken directly from RMModelObject, basically
// classes with the same layout return the same number.
- (NSUInteger)hash {
	return (NSUInteger)[self allKeys];
}

- (void)writeLineBreakToString:(NSMutableString *)string withTabs:(NSUInteger)tabCount {
	[string appendString:@"\n"];
	for (int i=0;i<tabCount;i++) [string appendString:@"\t"];
}

// Prints description in a nicely-formatted and indented manner.
- (void) writeToDescription:(NSMutableString *)description withIndent:(NSUInteger)indent {
	
	[description appendFormat:@"<%@ %p", NSStringFromClass([self class]), self];
	
	for (NSString *name in [self allKeys]) {
		
		[self writeLineBreakToString:description withTabs:indent];
		
		id object = [self valueForKey:name];
		
		if ([object isKindOfClass:[SMModelObject class]]) {
			[object writeToDescription:description withIndent:indent+1];
		}
		else if ([object isKindOfClass:[NSArray class]]) {
			
			[description appendFormat:@"%@ =", name];
			
			for (id child in object) {
				[self writeLineBreakToString:description withTabs:indent+1];
				
				if ([child isKindOfClass:[SMModelObject class]])
					[child writeToDescription:description withIndent:indent+2];
				else
					[description appendString:[child description]];
			}
		}
		else if ([object isKindOfClass:[NSDictionary class]]) {
			
			[description appendFormat:@"%@ =", name];
			
			for (id key in object) {
				[self writeLineBreakToString:description withTabs:indent];
				[description appendFormat:@"\t%@ = ",key];
				
				id child = [object objectForKey:key];
				
				if ([child isKindOfClass:[SMModelObject class]])
					[child writeToDescription:description withIndent:indent+2];
				else
					[description appendString:[child description]];
			}
		}
		else {
			[description appendFormat:@"%@ = %@", name, object];
		}
	}
		
	[description appendString:@">"];
}

// Override description for helpful debugging.
- (NSString *) description {
	NSMutableString *description = [NSMutableString string];
	[self writeToDescription:description withIndent:1];
	return description;
}

@end
