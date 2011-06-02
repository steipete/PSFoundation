//
// SoundEffect.h
// PSFoundation
//
// Copyright 2008 Apple Inc. All rights reserved.
// Licensed under the Apple Sample License.
//

#import <AudioToolbox/AudioServices.h>

@interface SoundEffect : NSObject {
    SystemSoundID _soundID;
}

+ (id)soundEffectWithContentsOfFile:(NSString *)aPath;
- (id)initWithContentsOfFile:(NSString *)path;
- (void)play;

+ (void)playSoundEffectWithContentsOfFile:(NSString *)path;
+ (void)vibrate;

@end

