//
//  MTSplashScreen.h
//  PSFoundation
//
//  Created by Matthias Tretter on 03.06.11.
//  Copyright 2011 @myell0w. All rights reserved.
//
//  Taken from Book iOS Recipes - The Pragmatic Programmers b4: Recipe 1
//  Originally Created by Matt Drance on 10/1/10.
//  Copyright 2010 Bookhouse Software, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MTSplashScreenDelegate.h"


@interface MTSplashScreen : UIViewController {
    UIImage *splashImage_;
    BOOL showsStatusBarOnDismissal_;
    id<MTSplashScreenDelegate> delegate_;
}


@property (nonatomic, retain) UIImage *splashImage;
@property (nonatomic, assign) BOOL showsStatusBarOnDismissal;
@property (nonatomic, assign) id<MTSplashScreenDelegate> delegate;

+ (MTSplashScreen *)splashScreen;

- (void)hide;

@end
