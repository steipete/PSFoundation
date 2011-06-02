//
//  PSAlertView.h
//  PSFoundation
//
//  Created by Peter Steinberger on 17.03.10.
//  Licensed under MIT. All rights reserved.
//

DEPRECATED_ATTRIBUTE @interface PSAlertView : NSObject {
@private
  UIAlertView *view_;
}

@property (nonatomic, retain) UIAlertView *alertView;

+ (PSAlertView *)alertWithTitle:(NSString *)title;
+ (PSAlertView *)alertWithTitle:(NSString *)title message:(NSString *)message;

- (id)initWithTitle:(NSString *)title message:(NSString *)message;

- (void)setCancelButtonWithTitle:(NSString *)title block:(void (^)())block;
- (void)addButtonWithTitle:(NSString *)title block:(void (^)())block;

- (void)show;
- (void)dismissWithClickedButtonIndex:(NSInteger)buttonIndex animated:(BOOL)animated;

@end
