//
//  UIToolBar+PSLib.h
//
//  Created by Peter Steinberger on 31.03.10.
//

@interface UIToolbar (PSLib)

// returns an adapted custom toolbar with corrected margin and autoresizing
+ (UIToolbar *)ps_customToolbarForView:(UIView *)view;

@end
