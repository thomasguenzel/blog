//
//  InsetImageView.h
//  ReactionListView
//
//  Created by Thomas Günzel on 11/10/2016.
//  Copyright © 2016 Thomas Günzel. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface InsetImageView : UIView

/**
 @brief the image view's image
 */
@property(readwrite,nonatomic) IBInspectable UIImage *image;

/**
 @brief the image view's insets
 */
@property(readwrite,nonatomic) IBInspectable UIEdgeInsets imageInsets;


/**
 @brief the image view that actually displays the image, can be used for setting properties other than .image
 */
@property(readwrite,nonatomic,strong) UIImageView *underlyingImageView;

@end
