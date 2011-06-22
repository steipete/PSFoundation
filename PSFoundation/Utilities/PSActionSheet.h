//
//  PSActionSheet.h
//  PSFoundation
//
//  Created by Landon Fuller on 7/3/09.
//  Copyright 2009 Plausible Labs. All rights reserved.
//

DEPRECATED_ATTRIBUTE @interface PSActionSheet : NSObject {
@private
  UIActionSheet *sheet_;
}

@property (nonatomic, retain, readonly) UIActionSheet *sheet;

+ (id)sheetWithTitle:(NSString *)title;

- (id)initWithTitle:(NSString *)title;

- (void)setCancelButtonWithTitle:(NSString *) title block:(BKBlock) block;
- (void)setDestructiveButtonWithTitle:(NSString *) title block:(BKBlock) block;
- (void)addButtonWithTitle:(NSString *) title block:(BKBlock) block;

- (void)showInView:(UIView *)view;
- (void)showFromBarButtonItem:(UIBarButtonItem *)item animated:(BOOL)animated;
- (void)showFromRect:(CGRect)rect inView:(UIView *)view animated:(BOOL)animated;

@end
