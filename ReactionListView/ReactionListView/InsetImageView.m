//
//  InsetImageView.m
//  ReactionListView
//
//  Created by Thomas Günzel on 11/10/2016.
//  Copyright © 2016 Thomas Günzel. All rights reserved.
//

#import "InsetImageView.h"

@implementation InsetImageView
@dynamic image;

- (instancetype)init {
	self = [super init];
	if (self) {
		[self setup];
	}
	return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
	self = [super initWithCoder:coder];
	if (self) {
		[self setup];
	}
	return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		[self setup];
	}
	return self;
}

-(void)setup {
	self.underlyingImageView = [[UIImageView alloc] init];
	[self addSubview:self.underlyingImageView];
	
}

-(void)layoutSubviews {
	[super layoutSubviews];
	
	self.underlyingImageView.frame = UIEdgeInsetsInsetRect(self.bounds, _imageInsets);
}

-(void)setImage:(UIImage *)image {
	self.underlyingImageView.image = image;
}

-(UIImage *)image {
	return self.underlyingImageView.image;
}

@end
