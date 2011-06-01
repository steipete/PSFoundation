//
//  NSMutableString+PSAdditions.h
//  PSFoundation
//
//  Created by Peter Steinberger on 15.10.10.
//  Copyright 2010 Peter Steinberger. All rights reserved.
//

@interface NSMutableString (PSAdditions)

- (NSUInteger)replaceOccurrencesOfString:(NSString *)target withString:(NSString *)replacement;

// append a parameter to an url
- (NSMutableString *)appendParameter:(id)paramter name:(NSString *)name;

@end
