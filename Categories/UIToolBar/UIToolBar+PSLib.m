//
//  UIToolBar+PSLib.m
//
//  Created by Peter Steinberger on 31.03.10.
//

@implementation UIToolbar (PSLib)

#define kToolBarHeight 44

+ (UIToolbar *)ps_customToolbarForView:(UIView *)view {
  UIToolbar *toolbar = [[[UIToolbar alloc] initWithFrame:
                         CGRectMake(0, view.size.height - kToolBarHeight, view.width, kToolBarHeight)] autorelease];
  
  // UIToolbar has a weird margin. this *slightly* expands the toolbar to look consistent with the navbar
#define kToolBarExtraMargin 7
  toolbar.width = toolbar.width + kToolBarExtraMargin * 2;
  toolbar.left = toolbar.left - kToolBarExtraMargin;
  
  toolbar.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth; 
  [view addSubview:toolbar];
  return toolbar;
}

@end
