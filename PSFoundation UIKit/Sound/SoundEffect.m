//
// SoundEffect.m
// PSFoundation
//
// Copyright 2008 Apple Inc. All rights reserved.
// Licensed under the Apple Sample License.
//

#import "SoundEffect.h"
#import "NSObject+BlocksKit.h"
#import "NSObject+Utilities.h"

@implementation SoundEffect

+ (id)soundEffectWithContentsOfFile:(NSString *)aPath {
    return [[[SoundEffect alloc] initWithContentsOfFile:aPath] autorelease];
}

- (id)initWithContentsOfFile:(NSString *)path {
    if (path.empty)
        return nil;
    
    NSURL *aFileURL = [NSURL fileURLWithPath:path isDirectory:NO];
    
    if (aFileURL.empty)
        return nil;
    
    SystemSoundID aSoundID;
    OSStatus error = AudioServicesCreateSystemSoundID((CFURLRef)aFileURL, &aSoundID);
    
    if (error != kAudioServicesNoError) {
        DDLogError(@"Error %d loading sound at path: %@", error, path);
        return nil;
    }
    
    AudioFileID fileID;
    AudioFileOpenURL((CFURLRef)aFileURL, kAudioFileReadPermission, 0, &fileID);
    NSTimeInterval seconds;
    UInt32 propertySize = sizeof(seconds);
    AudioFileGetProperty(fileID, kAudioFilePropertyEstimatedDuration, &propertySize, &seconds);
    AudioFileClose(fileID);
    
    if ((self = [super init])) {
        soundID = aSoundID;
        length = seconds + 0.2;        
    }
    return self;
}

-(void)dealloc {
    [NSObject performBlock:^{
        AudioServicesDisposeSystemSoundID(soundID);
    } afterDelay:length];
    [super dealloc];
}

- (void)play {
    AudioServicesPlaySystemSound(soundID);
}

static void SoundEffectAutoDestruction(SystemSoundID soundID, void *userInfo) {
    AudioServicesDisposeSystemSoundID(soundID);
}

+ (void)playSoundEffectWithContentsOfFile:(NSString *)path {
    if (path.empty)
        return;

    SoundEffect *instance = [SoundEffect soundEffectWithContentsOfFile:path];
    AudioServicesAddSystemSoundCompletion(instance->soundID, CFRunLoopGetCurrent(), kCFRunLoopDefaultMode, SoundEffectAutoDestruction, NULL);
    [instance play];
}

+ (void)vibrate {
	AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

@end
