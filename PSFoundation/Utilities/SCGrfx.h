//
//  SCGrfx.h
//  TouchCustoms
//
//  Created by Aleks Nesterow on 10/15/09.
//  aleks.nesterow@gmail.com
//  
//  Copyright © 2009, Screen Customs s.r.o.
//  All rights reserved.
//  
//  Purpose
//	Contains extension methods for Core Graphics.
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
