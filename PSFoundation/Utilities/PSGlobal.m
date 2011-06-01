//
//  PSGlobal.m
//
//  Created by Peter Steinberger on 09.11.09.
//

#import "PSGlobal.h"

inline NSString *MTDocumentsDirectory() {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}
