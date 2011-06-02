//
//  UIToolbar+PSFoundation.h
//  PSFoundation
//
//  Includes code by the following:
//   - Facebook.           2009.  Apache.
//   - Peter Steinberger.  2010.  MIT.
//

@interface UIToolbar (PSFoundation)

// returns an adapted custom toolbar with corrected margin and autoresizing
+ (UIToolbar *)ps_customToolbarForView:(UIView *)view;

- (UIBarButtonItem *)itemWithTag:(NSInteger)tag;

@end