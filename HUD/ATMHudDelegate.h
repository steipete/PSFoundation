/*
 *  ATMHudDelegate.h
 *  atomHUD
 *
 *  Created by Marcel Müller on 25.11.10.
 *  Copyright (c) 2010, Marcel Müller (atomcraft)
 *  All rights reserved.
 *
 */

#import <UIKit/UIKit.h>
@class ATMHud;

/**
	The delegate of a ATMHud object can adopt the ATMHudDelegate protocol. Optional methods of the protocol allow the delegate to manage touches and get notified about the view state.
 */
@protocol ATMHudDelegate

@optional
/**
	Called when the user taps the HUD.
	Can be blocked with the blockTouches property.
	@param _hud The hud which has been tapped.
 */
- (void)userDidTapHud:(ATMHud *)_hud;

/**
	Called before the HUD appears.
	@param _hud The hud which will appear.
 */
- (void)hudWillAppear:(ATMHud *)_hud;

/**
	Called when the HUD appeared.
	@param _hud The hud which did appear.
 */
- (void)hudDidAppear:(ATMHud *)_hud;

/**
	Called before the HUD updates.
	@param _hud The hud which will update.
 */
- (void)hudWillUpdate:(ATMHud *)_hud;

/**
	Called when the HUD updated.
	@param _hud The hud which did update.
 */
- (void)hudDidUpdate:(ATMHud *)_hud;

/**
	Called before the HUD disappears.
	@param _hud The hud which will disappear.
 */
- (void)hudWillDisappear:(ATMHud *)_hud;

/**
	Called when the HUD disappeared.
	@param _hud The hud which did disappear.
 */
- (void)hudDidDisappear:(ATMHud *)_hud;


@end
