//
//  CoreGraphics+RoundedRect.h
//  PSFoundation
//
//  Created by Aleks Nesterow on 10/15/09.
//  Licensed under MIT.  Copyright 2010 Screen Customs s.r.o.
//

struct SCRoundedRect {
	CGFloat xLeft, xLeftCorner;
	CGFloat xRight, xRightCorner;
	CGFloat yTop, yTopCorner;
	CGFloat yBottom, yBottomCorner;
};
typedef struct SCRoundedRect SCRoundedRect;

SCRoundedRect SCRoundedRectMake(CGRect, CGFloat);

void SCContextAddRoundedRect(CGContextRef, CGRect, CGFloat);

void SCContextAddLeftRoundedRect(CGContextRef, CGRect, CGFloat);
void SCContextAddLeftTopRoundedRect(CGContextRef, CGRect, CGFloat);
void SCContextAddLeftBottomRoundedRect(CGContextRef, CGRect, CGFloat);

void SCContextAddRightRoundedRect(CGContextRef, CGRect, CGFloat);
void SCContextAddRightTopRoundedRect(CGContextRef, CGRect, CGFloat);
void SCContextAddRightBottomRoundedRect(CGContextRef, CGRect, CGFloat);
