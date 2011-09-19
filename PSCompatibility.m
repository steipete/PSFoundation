//
//  PSCompatibility.m
//  PSFoundation
//
//  Created by Peter Steinberger on 09.09.10.
//  Copyright 2010 Peter Steinberger. All rights reserved.
//

#import "PSCompatibility.h"

BOOL isIPad(void) {
    return [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad;
}
