//
//  MTSplashScreen.m
//  PSFoundation
//
//  Created by Matthias Tretter on 03.06.11.
//  Copyright 2011 @myell0w. All rights reserved.
//
//  Taken from Book iOS Recipes - The Pragmatic Programmers b4: Recipe 1
//  Originally Created by Matt Drance on 10/1/10.
//  Copyright 2010 Bookhouse Software, LLC. All rights reserved.
//

#import "MTSplashScreen.h"
#import "MTUniversalHelper.h"
#import "UIViewControllerHelper.h"

@implementation MTSplashScreen

@synthesize splashImage, showsStatusBarOnDismissal, delegate, delay;

////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Lifecycle
////////////////////////////////////////////////////////////////////////

+ (MTSplashScreen *)splashScreen {
    PS_RETURN_AUTORELEASED([[MTSplashScreen alloc] initWithNibName:nil bundle:nil]);
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]))
        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    return self;
}

- (void)dealloc {
    PS_RELEASE_NIL(splashImage);
    PS_DEALLOC();
}

////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark UIView
////////////////////////////////////////////////////////////////////////

- (void)loadView {
    UIImageView *iv = PS_AUTORELEASE([[UIImageView alloc] initWithImage:self.splashImage]);
    
    iv.autoresizingMask = UIViewAutoresizingFlexibleWidth |  UIViewAutoresizingFlexibleHeight;
    iv.contentMode = UIViewContentModeBottom;
    self.view = iv;
}

- (void)viewDidUnload {
    [super viewDidUnload];
    
    self.splashImage = nil;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if ([self.delegate respondsToSelector:@selector(splashScreenDidAppear:)]) {
        [self.delegate splashScreenDidAppear:self];
    }
    
    [self performSelector:@selector(hide) withObject:nil afterDelay:self.delay];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if ([self.delegate respondsToSelector:@selector(splashScreenWillDisappear:)]) {
        [self.delegate splashScreenWillDisappear:self];
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    if ([self.delegate respondsToSelector:@selector(splashScreenDidDisappear:)]) {
        [self.delegate splashScreenDidDisappear:self];
    }
}

////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Rotation
////////////////////////////////////////////////////////////////////////

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return kRotateOnIPad(toInterfaceOrientation);
}


////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Getter
////////////////////////////////////////////////////////////////////////

- (UIImage *)splashImage {
    if (!splashImage) {
        if (isIPad()) {
            // first try orientation-specific launch images
            if (PSAppStatusBarOrientation == UIInterfaceOrientationPortraitUpsideDown) {
                self.splashImage = [UIImage imageNamed:@"Default-PortraitUpsideDown.png"];
            } else if (PSAppStatusBarOrientation == UIInterfaceOrientationLandscapeLeft) {
                self.splashImage = [UIImage imageNamed:@"Default-LandscapeLeft.png"];
            } else if (PSAppStatusBarOrientation == UIInterfaceOrientationLandscapeRight) {
                self.splashImage = [UIImage imageNamed:@"Default-LandscapeRight.png"];
            }
            
            // if there wasn't found a orientation-specific launch-image
            // try the ones for only Portrait/Landscape
            if (UIInterfaceOrientationIsPortrait(PSAppStatusBarOrientation)) {
                self.splashImage = [UIImage imageNamed:@"Default-Portrait.png"];
            } else {
                self.splashImage = [UIImage imageNamed:@"Default-Landscape.png"];
            }
        }
        
        // iPhone, or still no image found on iPad -> use Default.png
        if (!splashImage) {
            self.splashImage = [UIImage imageNamed:@"Default.png"];
        }
    }
    
    return splashImage;
}

////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark MTSplashScreen 
////////////////////////////////////////////////////////////////////////

- (void)hide {
    if (self.showsStatusBarOnDismissal) {
        UIApplication *app = [UIApplication sharedApplication];
        [app setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    }
    
    [self dismissModalViewControllerAnimated:YES];
}

@end
