//
//  NSString+GSub.m
//  
//
//  Created by Ryan Daigle on 7/31/08.
//  Copyright 2008 yFactorial, LLC. All rights reserved.
//

#import "NSString+GSub.h"

@implementation NSString (GSub)

- (NSString *)gsub:(NSDictionary *)keyValues {
	
	NSMutableString *subbed = [NSMutableString stringWithString:self];
	
	for (NSString *key in keyValues) {
		NSString *value = [NSString stringWithFormat:@"%@", [keyValues objectForKey:key]];
		NSArray *splits = [subbed componentsSeparatedByString:key];
		[subbed setString:[splits componentsJoinedByString:value]];
	}
	return subbed;
}

@end
