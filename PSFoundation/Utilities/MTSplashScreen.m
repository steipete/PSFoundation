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


@implementation MTSplashScreen

@synthesize splashImage = splashImage_;
@synthesize showsStatusBarOnDismissal = showsStatusBarOnDismissal_;
@synthesize delegate = delegate_;

////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Lifecycle
////////////////////////////////////////////////////////////////////////

+ (MTSplashScreen *)splashscreen {
    MTSplashScreen *splashScreen = [[[MTSplashScreen alloc] initWithNibName:nil bundle:nil] autorelease];
    
    return splashScreen;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        if (isIPad()) {
            showsStatusBarOnDismissal_ = YES;
            self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        }
    }
    
    return self;
}

- (void)dealloc {
    MCRelease(splashImage_);
    
    [super dealloc];
}

////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark UIView
////////////////////////////////////////////////////////////////////////

- (void)loadView {
    UIImageView *iv = [[[UIImageView alloc] initWithImage:self.splashImage] autorelease];
    
    iv.autoresizingMask = UIViewAutoresizingFlexibleWidth |  UIViewAutoresizingFlexibleHeight;
    iv.contentMode = UIViewContentModeCenter;
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
    
    [self hide];
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
    if (splashImage_ == nil) {
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
        if (splashImage_ == nil) {
            self.splashImage = [UIImage imageNamed:@"Default.png"];
        }
    }
    
    return splashImage_;
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
