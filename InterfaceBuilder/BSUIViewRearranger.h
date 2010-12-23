//
//  BSUIViewRearranger.h
//  BSUIViewRearranger
//
//  Created by Karsten Kusche on 09.08.10.
//  Copyright 2010 Briksoftware.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BSUIViewRearranger : NSObject {

}

// it's all handled on class side, no need to instanciate the rearranger

+ (void)rearrangeView: (UIView*)mainView                              // pass the view you want to rearrange
			   toMode: (UIInterfaceOrientation)orientation            // pass the orientation to which it is rotated
	usingLandscapeNib: (NSString*)landscapeName                       // pass the name of the nib that is used for landscape orientation
		  portraitNib: (NSString*)portraitNib                         // pass the name of the nib that is used for portrait orientation
	  controllerClass: (Class)aClass;                                 // pass the view's controller class. Typically that's the mainView's controller.

@end
