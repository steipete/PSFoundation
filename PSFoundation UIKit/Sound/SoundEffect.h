//
//  SoundEffect.h
//  PSFoundation
//
//  Copyright 2008 Apple Inc. All rights reserved.
//  Licensed under the Apple Sample License.
//

#import <AudioToolbox/AudioToolbox.h>

@interface SoundEffect : NSObject {
    NSTimeInterval length;
    SystemSoundID soundID;
}

+ (id)soundEffectWithContentsOfFile:(NSString *)aPath;
- (id)initWithContentsOfFile:(NSString *)path;
- (void)play;

+ (void)playSoundEffectWithContentsOfFile:(NSString *)path;
+ (void)vibrate;

@end

