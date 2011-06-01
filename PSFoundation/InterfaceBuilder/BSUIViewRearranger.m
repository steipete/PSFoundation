//
//  BSUIViewRearranger.m
//  BSUIViewRearranger
//
//  Created by Karsten Kusche on 09.08.10.
//  Copyright 2010 Briksoftware.com. All rights reserved.
//

#import "BSUIViewRearranger.h"


@implementation BSUIViewRearranger

+ (void)rearrangeView:(UIView*)targetView accordingTo:(UIView*)sourceView
{
	// set the frame according to the source
	targetView.frame = sourceView.frame;
	
	// recursivelly walk through the subviews and adjust their frames likewise
	NSArray* targetViews = [targetView subviews];
	NSArray* sourceViews = [sourceView subviews];
	NSInteger i;
	
	if ([targetViews count] != [sourceViews count]) 
	{
		// one could assert here and yell, but returning silently seems the most sane solution
		return;
	}
	
	NSInteger count = [targetViews count];
	for (i = 0; i < count; i++)
	{
		[self rearrangeView:[targetViews objectAtIndex:i]
				accordingTo:[sourceViews objectAtIndex:i]];
	}
}

+ (void)rearrangeView:(UIView*)mainView accordingToNib:(NSString*)nibName usingClass:(Class) aClass
{
	// load the nib using our controller class and rearrange the view
	UIViewController* controller = [[aClass alloc] initWithNibName: nibName bundle:[NSBundle bundleForClass: aClass]];
	UIView* sourceView = controller.view;
	
	[self rearrangeView: mainView accordingTo: sourceView];
	
	[controller release];
}

+ (void)rearrangeView:(UIView*)mainView toMode:(UIInterfaceOrientation)orientation usingLandscapeNib:(NSString*)landscapeName portraitNib:(NSString*)portraitNib controllerClass:(Class) aClass
{
	// choose the nib according to the orientation then rearrange
	NSString* name = portraitNib;
	if (orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight)
	{
		name = landscapeName;
	}
	[self rearrangeView:mainView accordingToNib:name usingClass: aClass];
}
@end
