/*
 *  CoreGraphicsHelper.h
 *  PSFoundation
 *
 *  Created by Matthias Tretter on 16.02.11.
 *  Copyright 2011 @myell0w. All rights reserved.
 *
 *	Taken from http://iphonedevelopment.blogspot.com/2011/02/couple-cgaffinetransform-goodies.html
 */



// returns a matrix that rotates and translates at one time
#define CGAffineTransformMakeRotateTranslate(angle, dx, dy) CGAffineTransformMake(cosf(angle), sinf(angle), -sinf(angle), cosf(angle), dx, dy)

// returns a matrix that scales and translates at one time
#define CGAffineTransformMakeScaleTranslate(sx, sy, dx, dy) CGAffineTransformMake(sx, 0.f, 0.f, sy, dx, dy)
