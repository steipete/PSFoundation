//
// SoundEffect.m
// PSFoundation
//
// Copyright 2008 Apple Inc. All rights reserved.
// Licensed under the Apple Sample License.
//

#import "SoundEffect.h"
#import "NSObject+BlocksKit.h"

@implementation SoundEffect

+ (id)soundEffectWithContentsOfFile:(NSString *)aPath {
    if (!aPath.empty)
        return [[[SoundEffect alloc] initWithContentsOfFile:aPath] autorelease];
    return nil;
}

- (id)initWithContentsOfFile:(NSString *)path {
    if ((self = [super init])) {
        if (!path.empty) {
            NSURL *aFileURL = [NSURL fileURLWithPath:path isDirectory:NO];
            if (!aFileURL) {
                SystemSoundID aSoundID;
                OSStatus error = AudioServicesCreateSystemSoundID((CFURLRef)aFileURL, &aSoundID);
                
                if (error == kAudioServicesNoError) { // success
                    _soundID = aSoundID;
                } else {
                    DDLogError(@"Error %d loading sound at path: %@", error, path);
                    [self release];
                    return nil;
                }
            } else {
                DDLogError(@"NSURL is nil for path: %@", path);
                [self release];
                return nil;
            }
        }
    }
    return self;
}

-(void)dealloc {
    // to do:  find the length of the audio clip, so it has time to play in an autoreleased situation
    [NSObject performBlock:^(void) {
        AudioServicesDisposeSystemSoundID(_soundID);
    } afterDelay:3.0];
    [super dealloc];
}

- (void)play {
    AudioServicesPlaySystemSound(_soundID);
}

static void SoundEffectAutoDestruction(SystemSoundID soundID, void *userInfo) {
    AudioServicesDisposeSystemSoundID(soundID);
    SoundEffect *instance = (SoundEffect *)userInfo;
    [instance release];
    instance = nil;
}

+ (void)playSoundEffectWithContentsOfFile:(NSString *)path {
    if (!path.empty) {
        SoundEffect *instance = [[SoundEffect alloc] initWithContentsOfFile:path];
        AudioServicesAddSystemSoundCompletion(instance->_soundID, CFRunLoopGetCurrent(), kCFRunLoopDefaultMode, SoundEffectAutoDestruction, self);
        [instance play];
    }
}

+ (void)vibrate {
	AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

@end
