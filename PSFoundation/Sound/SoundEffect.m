//
// SoundEffect.m
// PSFoundation
//
// Copyright 2008 Apple Inc. All rights reserved.
// Licensed under the Apple Sample License.
//

#import "SoundEffect.h"
#import <AudioToolbox/AudioToolbox.h>
#import "NSObject+BlocksKit.h"

@implementation SoundEffect

+ (id)soundEffectWithContentsOfFile:(NSString *)aPath {
    return PS_AUTORELEASE([[SoundEffect alloc] initWithContentsOfFile:aPath]);
}

- (id)initWithContentsOfFile:(NSString *)path {
    if (path.empty)
        return nil;
    
    NSURL *aFileURL = [NSURL fileURLWithPath:path isDirectory:NO];
    
    if (aFileURL.empty)
        return nil;
    
    SystemSoundID aSoundID;
    OSStatus error = AudioServicesCreateSystemSoundID(ps_unretainedPointer(aFileURL), &aSoundID);
    
    if (error != kAudioServicesNoError) {
        DDLogError(@"Error %d loading sound at path: %@", error, path);
        return nil;
    }
    
    AudioFileID fileID;
    AudioFileOpenURL(ps_unretainedPointer(aFileURL), kAudioFileReadPermission, 0, &fileID);
    NSTimeInterval seconds;
    UInt32 propertySize = sizeof(seconds);
    AudioFileGetProperty(fileID, kAudioFilePropertyEstimatedDuration, &propertySize, &seconds);
    AudioFileClose(fileID);
    
    self = [super init];
    _soundID = aSoundID;
    _length = seconds + 0.2;
    return self;
}

-(void)dealloc {
    [NSObject performBlock:^(void) {
        AudioServicesDisposeSystemSoundID(_soundID);
    } afterDelay:_length];
    PS_DEALLOC();
}

- (void)play {
    AudioServicesPlaySystemSound(_soundID);
}

static void SoundEffectAutoDestruction(SystemSoundID soundID, void *userInfo) {
    AudioServicesDisposeSystemSoundID(soundID);
}

+ (void)playSoundEffectWithContentsOfFile:(NSString *)path {
    if (path.empty)
        return;

    SoundEffect *instance = [SoundEffect soundEffectWithContentsOfFile:path];
    AudioServicesAddSystemSoundCompletion(instance->_soundID, CFRunLoopGetCurrent(), kCFRunLoopDefaultMode, SoundEffectAutoDestruction, NULL);
    [instance play];
}

+ (void)vibrate {
	AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

@end
