//
//  PSSoundEffect.h
//  PSFoundation
//

/** Abstracts the AudioToolbox API for playing sound effects.

 You can use PSSoundEffect to play short (30 seconds or shorter) sounds
 one at a time to provide audible alerts with vibration on supported
 devices.
 
 Includes code by the following:
 
 - Apple, Inc - 2008. Apple Sample License.
 - [Zach Waldowski](https://github.com/zwaldowski) - 2011. MIT.
 
 */
@interface PSSoundEffect : NSObject {
    NSTimeInterval length;
    UInt32 soundID;
}

/** Creates and raturns a sound effect for the sound at the given path.
 
 @param path A path to a supported sound file type.
 @return Newly initialized sound effect with the specified properties.
 */
- (id)initWithContentsOfFile:(NSString *)path;

/** Plays the sound effect once. */
- (void)play;

/** A convenience method that creates a sound effect object,
 plays a sound, and deallocates once the sound finishes playing.
 
 @param path A path to a supported sound file type.
 */
+ (void)playSoundEffectWithContentsOfFile:(NSString *)path;

/** A convenience method that plays a system sound as
 well as a slight vibration on supported iOS devices.
 */
+ (void)vibrate;

@end

