//
//  PSFoundation-UIKit.h
//  PSFoundation
//
//  Created by Zachary Waldowski on 7/7/11.
//  Copyright 2011 Dizzy Technology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#import "PSMacros+UIKit.h"
#import "PSFoundation.h"

#import "DSActivityView.h"
#import "MBProgressHUD.h"
#import "TDSemiModal.h"
#import "EGOImageView.h"
#import "NYXImagesUtilities.h"

#import "LRPopoverManager.h"

// first class tableview cells!
#import "PSGenericCell.h"
#import "PSGenericView.h"
#import "PSShadowView.h"
#import "PSTableViewController.h"
#import "DTCustomColoredAccessory.h"

// ui components
#import "PSNonEditableTextView.h"

// helper for settings
#import "PSSettingsUtil.h"
#import "PSStatusBarSaver.h"

#import "SoundEffect.h"

// InterfaceBuilder
#import "BSUIViewRearranger.h"
#import "UIView+CWNibLocalizations.h"

// ScrollView
#import "PSScrollContentView.h"

// Splash Screen
#import "MTSplashScreen.h"

// Universal
#import "MTUniversalHelper.h"

// Core Graphics
#import "CoreGraphics+PSFoundation.h"
#import "CoreGraphics+RoundedRect.h"

#import "IKNetworkActivityManager.h"

#import "SKProduct+LocalizedPrice.h"

// showWithMessage fromTabBar|fromToolbar|inView
#import "UIActionSheet+SCMethods.h"

// alertViewFromError, showWithMessage, showWithTitle message
#import "UIAlertView+SCMethods.h"

// setApplicationStyle animated
#import "UIApplication+PSFoundation.h"

#if IS_IOS // not all of the CG stuff is available in Chameleon yet.
// setPathToRoundedRect, drawGlossyRect, setBackgroundToGlossyRectOfColor
#import "UIButton+Glossy.h"
#import "UIButton+Presets.h"
#endif

#import "UIColor+PSFoundation.h"

// availableMemory, platform, isJailbroken, debugInfo
#import "UIDevice+PSFoundation.h"

// hasAlpha, imageWithAlpha, transparentBorderImage
#import "UIImage+Alpha.h"

// roundedCornerImage
#import "UIImage+RoundedCorner.h"

// imageWithContentsOfURL, scaleToSize (...), colorizeImage
#import "UIImageHelper.h"

// cachedImageWithContentsOfFile, initWithContentsOfResolutionIndependentFile
#import "UIImage+Cache.h"
#import "UIImage+Tint.h"
#import "UIImage+MTCache.h"
#import "UIImage+MTTiling.h"
#import "UIImage+MTUniversalAdditions.h"

// (UIImageView *)imageViewNamed:(NSString *)imageName;
#import "UIImageView+PSFoundation.h"

// + (UILabel *)labelWithText:(NSString *)text;
#import "UILabel+PSFoundation.h"

#import "UINavigationBar+CustomBackground.h"

#import "UIScreen+PSFoundation.h"

#import "UIScrollView+MTUIAdditions.h"

#import "UITableView+PSFoundation.h"

#import "UIToolbar+PSFoundation.h"

#import "UIView+Sizes.h"
#import "UIView+Animation.h"
#import "UIView+PSAdditions.h"
#import "UIView+MTRotation.h"
#import "UIView+MTUIAdditions.h"
#import "UIView+Hierarchy.h"
#import "UIViewHelper.h"

#import "UIViewControllerHelper.h"
#import "UIViewController+MTUIAdditions.h"