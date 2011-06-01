/*******************************************************************************
	JRSwizzle.h
		Copyright (c) 2007 Jonathan 'Wolf' Rentzsch: <http://rentzsch.com>
		Some rights reserved: <http://opensource.org/licenses/mit-license.php>

	***************************************************************************/

// swizzling is DANGEROUS. so at least use the most safe implementation out there.
// (there is no 64 bit api on simulator, so method_exchangeImplementations is not good)
// https://github.com/rentzsch/jrswizzle

// usage: [SomeClass jr_swizzle:@selector(foo) withMethod:@selector(my_foo) error:&error];

// see this link for the "default" implementation
// http://www.icab.de/blog/2010/04/07/changing-the-headers-for-uiwebkit-http-requests/

@interface NSObject (JRSwizzle)
+ (BOOL)jr_swizzleMethod:(SEL)origSel_ withMethod:(SEL)altSel_ error:(NSError**)error_;
+ (BOOL)jr_swizzleClassMethod:(SEL)origSel_ withClassMethod:(SEL)altSel_ error:(NSError**)error_;
@end
