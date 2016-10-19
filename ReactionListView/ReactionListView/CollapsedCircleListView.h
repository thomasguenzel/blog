//
//  CollapsedCircleListView.h
//  ReactionListView
//
//  Created by Thomas Günzel on 11/10/2016.
//  Copyright © 2016 Thomas Günzel. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 @class CollapsedCircleListView
 @brief shows multiple circular images next to each other
 @discussion
 the images specified are added as circles, with an optional border.
 each image is offset from the last, using the offsetFactor.
 
 if a small gap should exist between the circles, the borderWidth/borderColor
 can be used.
 */
IB_DESIGNABLE
@interface CollapsedCircleListView : UIView

/**
 @brief how far each circle is from the previous one.
 if 0, it's obscures the previous, if 1, it's right next to the previous.
 */
@property(readwrite,nonatomic) IBInspectable CGFloat offsetFactor;

/**
 @brief the border for each circle. this generates a small gap between multiple items
 */
@property(readwrite,nonatomic) IBInspectable CGFloat circleBorderWidth;

/**
 @brief the color for each circle's border
 */
@property(readwrite,nonatomic) IBInspectable UIColor *circleBorderColor;

/**
 @brief the images to show.
 */
@property(readwrite,nonatomic,strong) NSArray<UIImage*> *images;

@end
