//
//  GNGridViewController.h
//  GNGridViewController
//
//  Created by Thomas Günzel on 26.01.16.
//  Copyright © 2016 Thomas Günzel. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GNGridTypes.h"

/**
 *  Style your interface with the most sophisticated, innovative technology. A grid.
 */
@interface GNGridView : UIView

//! the grid's size
@property(readwrite,nonatomic) GNGridSize size;

//! spacing between the blocks
@property(readwrite,nonatomic) CGFloat spacing;

/**
 draw a red border around the subviews
 setting this to yes will change the layer border of the subviews
 */
@property(readwrite,nonatomic) BOOL debugModeEnabled;




/**
 adds a subview to the grid with UIEdgeInsetsZero
 @param view the view to add
 @param block where to add the view
 */
-(void)addSubview:(UIView*)view inBlock:(const GNGridBlock)block;

/**
 adds a subview to the grid
 @param view the view to add
 @param block where to add the view
 @param insets specify a margin for the view
 */
-(void)addSubview:(UIView*)view inBlock:(const GNGridBlock)block edgeInsets:(UIEdgeInsets)insets;

/**
 remove a subview from the grid
 @param view the view to remove
 */
-(void)removeSubview:(UIView*)view;

@end
