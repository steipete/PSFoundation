//
//  SCGrfx.m
//  TouchCustoms
//
//  Created by Aleks Nesterow on 10/15/09.
//  aleks.nesterow@gmail.com
//  
//  Copyright © 2009-2010 Screen Customs s.r.o.
//  All rights reserved.
//

#import "SCGrfx.h"

SCRoundedRect SCRoundedRectMake(CGRect rect, CGFloat cornerRadius) {

	SCRoundedRect result;
	
	result.xLeft = CGRectGetMinX(rect);
	result.xLeftCorner = result.xLeft + cornerRadius;
	
	result.xRight = CGRectGetMaxX(rect);
	result.xRightCorner = result.xRight - cornerRadius;
	
	result.yTop = CGRectGetMinY(rect);
	result.yTopCorner = result.yTop + cornerRadius;
	
	result.yBottom = CGRectGetMaxY(rect);
	result.yBottomCorner = result.yBottom - cornerRadius;
	
	return result;
}

void SCContextAddRoundedRect(CGContextRef c, CGRect rect, CGFloat cornerRadius) {
	
	SCRoundedRect roundedRect = SCRoundedRectMake(rect, cornerRadius);
	
	/* Begin */
	CGContextBeginPath(c);
	CGContextMoveToPoint(c, roundedRect.xLeft, roundedRect.yTopCorner);
	
	/* First corner */
	CGContextAddArcToPoint(c, roundedRect.xLeft, roundedRect.yTop, roundedRect.xLeftCorner, roundedRect.yTop, cornerRadius);
	CGContextAddLineToPoint(c, roundedRect.xRightCorner, roundedRect.yTop);
	
	/* Second corner */
	CGContextAddArcToPoint(c, roundedRect.xRight, roundedRect.yTop, roundedRect.xRight, roundedRect.yTopCorner, cornerRadius);
	CGContextAddLineToPoint(c, roundedRect.xRight, roundedRect.yBottomCorner);
	
	/* Third corner */
	CGContextAddArcToPoint(c, roundedRect.xRight, roundedRect.yBottom, roundedRect.xRightCorner, roundedRect.yBottom, cornerRadius);
	CGContextAddLineToPoint(c, roundedRect.xLeftCorner, roundedRect.yBottom);
	
	/* Fourth corner */
	CGContextAddArcToPoint(c, roundedRect.xLeft, roundedRect.yBottom, roundedRect.xLeft, roundedRect.yBottomCorner, cornerRadius);
	CGContextAddLineToPoint(c, roundedRect.xLeft, roundedRect.yTopCorner);
	
	/* Done */
	CGContextClosePath(c);
}

void SCContextAddLeftRoundedRect(CGContextRef c, CGRect rect, CGFloat radius) {

	SCRoundedRect roundedRect = SCRoundedRectMake(rect, radius);
	
	CGContextBeginPath(c);
	CGContextMoveToPoint(c, roundedRect.xLeft, roundedRect.yTopCorner);
	
	CGContextAddArcToPoint(c, roundedRect.xLeft, roundedRect.yTop, roundedRect.xLeftCorner, roundedRect.yTop, radius);
	
	CGContextAddLineToPoint(c, roundedRect.xRight, roundedRect.yTop);
	CGContextAddLineToPoint(c, roundedRect.xRight, roundedRect.yBottom);
	CGContextAddLineToPoint(c, roundedRect.xLeftCorner, roundedRect.yBottom);
	
	CGContextAddArcToPoint(c, roundedRect.xLeft, roundedRect.yBottom, roundedRect.xLeft, roundedRect.yBottomCorner, radius);
	
	CGContextClosePath(c);
}

void SCContextAddLeftTopRoundedRect(CGContextRef c, CGRect rect, CGFloat radius) {
	
	SCRoundedRect roundedRect = SCRoundedRectMake(rect, radius);
	
	CGContextBeginPath(c);
	CGContextMoveToPoint(c, roundedRect.xLeft, roundedRect.yTopCorner);
	
	CGContextAddArcToPoint(c, roundedRect.xLeft, roundedRect.yTop, roundedRect.xLeftCorner, roundedRect.yTop, radius);
	
	CGContextAddLineToPoint(c, roundedRect.xRight, roundedRect.yTop);
	CGContextAddLineToPoint(c, roundedRect.xRight, roundedRect.yBottom);
	CGContextAddLineToPoint(c, roundedRect.xLeft, roundedRect.yBottom);
	
	CGContextClosePath(c);
}

void SCContextAddLeftBottomRoundedRect(CGContextRef c, CGRect rect, CGFloat radius) {

	SCRoundedRect roundedRect = SCRoundedRectMake(rect, radius);
	
	CGContextBeginPath(c);
	CGContextMoveToPoint(c, roundedRect.xLeft, roundedRect.yTop);
	
	CGContextAddLineToPoint(c, roundedRect.xRight, roundedRect.yTop);
	CGContextAddLineToPoint(c, roundedRect.xRight, roundedRect.yBottom);
	CGContextAddLineToPoint(c, roundedRect.xLeftCorner, roundedRect.yBottom);
	
	CGContextAddArcToPoint(c, roundedRect.xLeft, roundedRect.yBottom, roundedRect.xLeft, roundedRect.yBottomCorner, radius);
	
	CGContextClosePath(c);
}

void SCContextAddRightRoundedRect(CGContextRef c, CGRect rect, CGFloat radius) {

	SCRoundedRect roundedRect = SCRoundedRectMake(rect, radius);
	
	CGContextBeginPath(c);
	CGContextMoveToPoint(c, roundedRect.xLeft, roundedRect.yTop);
	
	CGContextAddLineToPoint(c, roundedRect.xRightCorner, roundedRect.yTop);
	CGContextAddArcToPoint(c, roundedRect.xRight, roundedRect.yTop, roundedRect.xRight, roundedRect.yTopCorner, radius);
	CGContextAddLineToPoint(c, roundedRect.xRight, roundedRect.yBottomCorner);
	CGContextAddArcToPoint(c, roundedRect.xRight, roundedRect.yBottom, roundedRect.xRightCorner, roundedRect.yBottom, radius);
	CGContextAddLineToPoint(c, roundedRect.xLeft, roundedRect.yBottom);
	
	CGContextClosePath(c);
}

void SCContextAddRightTopRoundedRect(CGContextRef c, CGRect rect, CGFloat radius) {
	
	SCRoundedRect roundedRect = SCRoundedRectMake(rect, radius);
	
	CGContextBeginPath(c);
	CGContextMoveToPoint(c, roundedRect.xLeft, roundedRect.yTop);
	
	CGContextAddLineToPoint(c, roundedRect.xRightCorner, roundedRect.yTop);
	CGContextAddArcToPoint(c, roundedRect.xRight, roundedRect.yTop, roundedRect.xRight, roundedRect.yTopCorner, radius);
	CGContextAddLineToPoint(c, roundedRect.xRight, roundedRect.yBottom);
	CGContextAddLineToPoint(c, roundedRect.xLeft, roundedRect.yBottom); 
	
	CGContextClosePath(c);
}

void SCContextAddRightBottomRoundedRect(CGContextRef c, CGRect rect, CGFloat radius) {
	
	SCRoundedRect roundedRect = SCRoundedRectMake(rect, radius);
	
	CGContextBeginPath(c);
	CGContextMoveToPoint(c, roundedRect.xLeft, roundedRect.yTop);
	
	CGContextAddLineToPoint(c, roundedRect.xRight, roundedRect.yTop);
	CGContextAddLineToPoint(c, roundedRect.xRight, roundedRect.yBottomCorner);
	CGContextAddArcToPoint(c, roundedRect.xRight, roundedRect.yBottom, roundedRect.xRightCorner, roundedRect.yBottom, radius);
	CGContextAddLineToPoint(c, roundedRect.xLeft, roundedRect.yBottom);
	
	CGContextClosePath(c);
}
