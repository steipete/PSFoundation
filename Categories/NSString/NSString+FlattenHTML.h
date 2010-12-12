//
//  NSString+FlattenHTML.h
//
//  Created by Peter Steinberger on 18.01.10.
//

// http://stackoverflow.com/questions/277055/remove-html-tags-from-an-nsstring-on-the-iphone

@interface NSString(FlattenHTML)
- (NSString *)removeWhitespace;
- (NSString *)removeAllWhitespaces;
- (NSString *)replaceAllWhitespacesWithSpace;
@end
