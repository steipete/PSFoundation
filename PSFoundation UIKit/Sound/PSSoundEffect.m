//
//  PSSoundEffect.m
//  PSFoundation
//

#import "PSSoundEffect.h"
#import <AudioToolbox/AudioToolbox.h>
#import "NSObject+BlocksKit.h"
#import "NSString+PSFoundation.h"
#import "NSURL+PSFoundation.h"

@implementation PSSoundEffect

- (id)initWithContentsOfFile:(NSString *)path {
    if (path.empty)
        return nil;
    
    NSURL *aFileURL = [NSURL fileURLWithPath:path isDirectory:NO];
    
    AudioFileID fileID;
    AudioFileOpenURL((CFURLRef)aFileURL, kAudioFileReadPermission, 0, &fileID);
    NSTimeInterval seconds;
    UInt32 propertySize = sizeof(seconds);
    AudioFileGetProperty(fileID, kAudioFilePropertyEstimatedDuration, &propertySize, &seconds);
    AudioFileClose(fileID);
    
    if (seconds > 30) {
        DDLogError(@"Sound too long at path: %@", path);
        return nil;
    }
    
    SystemSoundID aSoundID;
    OSStatus error = AudioServicesCreateSystemSoundID((CFURLRef)aFileURL, &aSoundID);
    
    if (error != kAudioServicesNoError) {
        DDLogError(@"Error %d loading sound at path: %@", error, path);
        return nil;
    }
    
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

+ (void)playSoundEffectWithContentsOfFile:(NSString *)path {
    if (path.empty)
        return;

    PSSoundEffect *instance = [[PSSoundEffect alloc] initWithContentsOfFile:path];
    [instance play];
    [instance release];
}

+ (void)vibrate {
	AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

@end
