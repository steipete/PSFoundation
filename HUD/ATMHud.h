/*
 *  ATMHud.h
 *  atomHUD
 *
 *  Created by Marcel Müller on 12.12.10.
 *  Copyright (c) 2010, Marcel Müller (atomcraft)
 *  All rights reserved.
 *
 */

#import <UIKit/UIKit.h>
@class ATMHudView, ATMSoundFX;
@protocol ATMHudDelegate;

/**
	The position of the accessory.
 */
typedef enum {
	ATMHudAccessoryPositionTop = 0, /**< Accessory appears above the caption. */
	ATMHudAccessoryPositionRight, /**< Accessory appears to the right of the caption. */
	ATMHudAccessoryPositionBottom, /**< Accessory appears below the caption (Default). */
	ATMHudAccessoryPositionLeft /**< Accessory appears to the left of the caption. */
} ATMHudAccessoryPosition;

/**
	This is the HUD controller. You can manage everything with the properties and methods provided by this class.
	A proper use of this would be to allocate and initialize an ivar of the ATMHud class and add it's view to the view of your view controller.
	Required frameworks for this class are: AudioToolbox, UIKit, Foundation, CoreGraphics, QuartzCore
	
	Example (assuming that you have an ivar called "hud"):
	hud = [[ATMHud alloc] init];
	hud.delegate = self; // Optional
	[self.view addSubview:hud.view];
 
	@author Marcel Müller http://www.atomcraft.de development@atomcraft.de
 */
@interface ATMHud : UIViewController {
	/**
		Sets the spacing between the bounds and the content.
		Default is 10.
	 */
	CGFloat margin;

	/**
		Sets the spacing between the caption and the accessory.
		Default is 10.
	 */
	CGFloat padding;

	/**
		Sets the opacity of the background.
		Default is 0.7 (70 %).
	 */
	CGFloat alpha;
	
	/**
		Scale factor for the show animation.
		The HUD scales from this value to 1.0 during the animation.
		Default is 1.4.
	 */
	CGFloat appearScaleFactor;

	/**
		Scale factor for the hide animations.
		The HUD scales from 1.0 to this value during the animation.
		Default is 1.4.
	 */
	CGFloat disappearScaleFactor;


	/**
		Sets the radius of the progressbar's border.
		Default is 8.
	 */
	CGFloat progressBorderRadius;

	/**
		Sets the width of the progressbar's border.
		Default is 2.
	 */
	CGFloat progressBorderWidth;

	/**
		Sets the radius of the progressbar.
		Default is 5.
	 */
	CGFloat progressBarRadius;

	/**
		Sets the spacing between the progressbar and its border.
		Default is 3.
	 */
	CGFloat progressBarInset;
	
	/**
		Sets the center of the HUD.
		Default is CGPointZero.
		The property is reset on every hide.
		If the value is equal to CGPointZero, the HUD is auto-centered in its superview.
	 */
	CGPoint center;
	
	/**
		Enables or disables the shadow.
		Default is YES.
	 */
	BOOL shadowEnabled;

	/**
		Enables or disables the userDidTapHud: function.
		Default is NO. Some methods like hideAfter: and startQueue automatically set this to YES.
		@see ATMHudDelegate#userDidTapHud:
	 */
	BOOL blockTouches;
	
	/**
		If this is set to YES, the whole screen will be used for touch recognition instead of the visible HUD.
		Default is NO.
	 */
	BOOL maximizeTouchArea;

	
	/**
		Calculates the minimum size of every display and sets fixedSize to the largest calculated size.
		Only used if fixedSize is not CGSizeZero.
		Default is YES. (Recommended)
		@see ATMHud#addToQueueWithCaption:image:accessoryPosition:showActivity:
		@see ATMHud#addToQueueWithCaptions:images:accessoryPositions:showActivities:
	 */
	BOOL useSameSizeInQueue;
	
	/**
		If set to YES, the user interaction for the superview is blocked when the HUD is shown.
		Important: If the value is set to NO, the HUD will not respond to touches via userDidTapHud: anymore.
		You can either interact with the superview OR with the HUD.
		Default is YES.
	 */
	BOOL blockUserInteraction;

	
	/**
		The path to a sound which should play when the HUD shows.
		This property is reset on every hide.
		Example: [[NSBundle mainBundle] pathForResource:@"sound" ofType:@"wav"]
	 */
	NSString *showSound;

	/**
		The path to a sound which should play when the HUD updates.
		This property is reset on every hide.
		Example: [[NSBundle mainBundle] pathForResource:@"sound" ofType:@"wav"]
	 */
	NSString *updateSound;

	/**
		The path to a sound which should play when the HUD hides.
		This property is reset on every hide.
		Example: [[NSBundle mainBundle] pathForResource:@"sound" ofType:@"wav"]
	 */
	NSString *hideSound;


	/**
		The object that acts as the delegate of the receiving HUD.
	 */
	id <ATMHudDelegate> delegate;

	/**
		Defines the position where the accessory should appear.
		Please note that the progressbar only works in the ATMHudAccessoryPositionTop and ATMHudAccessoryPositionBottom modes.
	 */
	ATMHudAccessoryPosition accessoryPosition;
	
	@private
	ATMHudView *hudView;
	NSMutableArray *displayQueue;
	NSInteger queuePosition;
	BOOL useStandby;
	ATMSoundFX *sound;
}

@property (nonatomic, assign) CGFloat margin;
@property (nonatomic, assign) CGFloat padding;
@property (nonatomic, assign) CGFloat alpha;
@property (nonatomic, assign) CGFloat appearScaleFactor;
@property (nonatomic, assign) CGFloat disappearScaleFactor;
@property (nonatomic, assign) CGFloat progressBorderRadius;
@property (nonatomic, assign) CGFloat progressBorderWidth;
@property (nonatomic, assign) CGFloat progressBarRadius;
@property (nonatomic, assign) CGFloat progressBarInset;
@property (nonatomic, assign) CGPoint center;
@property (nonatomic, assign) BOOL shadowEnabled;
@property (nonatomic, assign) BOOL blockTouches;
@property (nonatomic, assign) BOOL maximizeTouchArea;
@property (nonatomic, assign) BOOL useSameSizeInQueue;
@property (nonatomic, assign) BOOL blockUserInteraction;
@property (nonatomic, retain) NSString *showSound;
@property (nonatomic, retain) NSString *updateSound;
@property (nonatomic, retain) NSString *hideSound;
@property (nonatomic, assign) id <ATMHudDelegate> delegate;
@property (nonatomic, assign) ATMHudAccessoryPosition accessoryPosition;

@property (nonatomic, retain) ATMHudView *hudView;
@property (nonatomic, retain) NSMutableArray *displayQueue;
@property (nonatomic, assign) NSInteger queuePosition;
@property (nonatomic, assign) BOOL useStandby;
@property (nonatomic, retain) ATMSoundFX *sound;

/**
	Returns the current build info.
	@returns A string with format BUILD • DATE
 */
+ (NSString *)buildInfo;


/**
	Initialises the HUD with the designated delegate.
	@param hudDelegate The designated delegate.
	@returns A HUD instance.
	@see ATMHudDelegate
 */
- (id)initWithDelegate:(id)hudDelegate;


/**
	The caption which should appear on the HUD.
	Default is an empty string.
	@param caption The caption you want to set or an empty string to remove it.
 */
- (void)setCaption:(NSString *)caption;

/**
	The image which should appear on the HUD.
	Default is nil.
	@param image The image you want to set or nil to remove it.
 */
- (void)setImage:(UIImage *)image;

/**
	Enables or disables the activity indicator.
	Default is NO.
	Settings this to YES while setting an empty string shows a large white activity indicator.
	@param flag A boolean value, either YES or NO.
 */
- (void)setActivity:(BOOL)flag;

/**
	Sets the style for the activity indicator.
	Default is UIActivityIndicatorViewStyleWhite.
	The value is reset on every hide.
	@param style The designated style.
 */
- (void)setActivityStyle:(UIActivityIndicatorViewStyle)style;

/**
	Sets a fixed size the HUD should have. The HUD will auto-expand to the minimum required size if necessary.
	Default is CGSizeZero.
	The value is reset on every hide.
	The large white activity indicator is not affected by this. 
	@param size The fixed size you want to set.
 */
- (void)setFixedSize:(CGSize)size;

/**
	Sets the progress of the progressbar between 0 (0 %) and 1 (100%).
	Default is 0.
	The progressbar will only show if the progress is larger than 0, otherwise it hides.
	@param progress The progress of the progressbar.
 */
- (void)setProgress:(CGFloat)progress;


/**
	Adds a single display to the queue.
	@param caption The designated caption.
	@param image The designated image.
	@param position The designated position. Use [NSNumber numberWithInt:] for conversion.
	@param flag The state of the activity indicator. Use [NSNumber numberWithBool:] for conversion.
	@see ATMHud#accessoryPosition
	@see http://developer.apple.com/library/ios/#documentation/Cocoa/Reference/Foundation/Classes/NSNumber_Class/Reference/Reference.html
 */
- (void)addToQueueWithCaption:(NSString *)caption image:(UIImage *)image accessoryPosition:(ATMHudAccessoryPosition)position showActivity:(BOOL)flag;

/**
	Adds multiple displays to the queue.
	@param captions An array of captions.
	@param images An array of images.
	@param positions An array of positions. Use [NSNumber numberWithInt:] for conversion.
	@param flags An array of activity indicator states. Use [NSNumber numberWithBool:] for conversion.
	@see ATMHud#accessoryPosition
	@see http://developer.apple.com/library/ios/#documentation/Cocoa/Reference/Foundation/Classes/NSNumber_Class/Reference/Reference.html
 */
- (void)addToQueueWithCaptions:(NSArray *)captions images:(NSArray *)images accessoryPositions:(NSArray *)positions showActivities:(NSArray *)flags;

/**
	Removes all displays from the queue.
 */
- (void)clearQueue;


/**
	Shows the HUD with the current settings.
	This requires that the HUD's view has been added to a superview.
 */
- (void)show;

/**
	Adds the HUD to the designated view and shows it.
	The HUD will be auto-removed from the superview after it has hidden.
	Do not mix this system with the show function.
	@param pView The view you want to add the HUD to.
 */
- (void)showInParentView:(UIView *)pView;

/**
	Updates the HUD with the current settings.
 */
- (void)update;

/**
	Immediately hides the HUD. After it did hide, the following settings are reset:
	caption, image, progress, activity, accessoryPosition
 */
- (void)hide;

/**
	Hides the HUD after a specific time interval. After it did hide, the following settings are reset:
	caption, image, progress, activity, accessoryPosition
	@param delay The designated delay.
 */
- (void)hideAfter:(NSTimeInterval)delay;


/**
	Shows the first display of the queue.
	Does nothing if no display has been added to the queue yet.
 */
- (void)startQueue;

/**
	Shows the next display in the queue.
	Hides the HUD if the last display has been reached.
 */
- (void)showNextInQueue;

/**
	Shows the display at a specific index.
	@param index The index of the designated display.
 */
- (void)showQueueAtIndex:(NSInteger)index;

/**
	Plays a sound.
	Should be called within the methods of ATMHudDelegate. Its purpose is to play a sound every time the HUD state changes.
	The soundPath is reset after it has been played.
	@param soundPath The path to a sound, e.g. [[NSBundle mainBundle] pathForResource:@"sound" ofType:@"wav"].
	@see ATMHudDelegate
 */
- (void)playSound:(NSString *)soundPath;


@end
