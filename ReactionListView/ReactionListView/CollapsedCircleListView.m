//
//  CollapsedCircleListView.m
//  ReactionListView
//
//  Created by Thomas Günzel on 11/10/2016.
//  Copyright © 2016 Thomas Günzel. All rights reserved.
//

#import "CollapsedCircleListView.h"
#import "InsetImageView.h"

@interface CollapsedCircleListView()

@property(readwrite,nonatomic,strong) NSLayoutConstraint *aspectRatioConstraint;

@property(readwrite,nonatomic,strong) NSMutableArray<InsetImageView*> *imageViews;

@end

@implementation CollapsedCircleListView

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
	self.imageViews = [[NSMutableArray alloc] init];
	self.offsetFactor = 0.5;
	
}

-(void)setImages:(NSArray<UIImage *> *)images {
	if(_images == images) {
		return;
	}
	
	NSUInteger oldCount = _images.count;
	
	_images = images;
	
	if(oldCount != _images.count) {
		[self createConstraint];
		
		while(_images.count < self.imageViews.count) {
			InsetImageView *last = self.imageViews.lastObject;
			[last removeFromSuperview];
			[self.imageViews removeLastObject];
		}
		while(_images.count > self.imageViews.count) {
			InsetImageView *imageView = [[InsetImageView alloc] init];
			imageView.layer.masksToBounds = YES;
			imageView.imageInsets = UIEdgeInsetsMake(self.circleBorderWidth, self.circleBorderWidth, self.circleBorderWidth, self.circleBorderWidth);
			imageView.layer.borderWidth = self.circleBorderWidth;
			imageView.layer.borderColor = self.circleBorderColor.CGColor;
			[self.imageViews addObject:imageView];
			[self addSubview:imageView];
		}
		
		[self setNeedsLayout];
	}
	
	if(_images.count != self.imageViews.count) {
		NSLog(@"FATAL ERROR: images and imageViews have different count");
		return;
	}
	
	NSEnumerator<UIImage*> *imageEnumerator = [_images objectEnumerator];
	NSEnumerator<InsetImageView*> *imageViewEnumerator = [self.imageViews objectEnumerator];
	UIImage *image = nil;
	InsetImageView *imageView = nil;
	
	while ((image = [imageEnumerator nextObject]) && (imageView = [imageViewEnumerator nextObject])) {
		imageView.image = image;
	}
	
}

-(void)layoutSubviews {
	[super layoutSubviews];
	
	CGRect imageRect;
	CGFloat height = self.bounds.size.height;
	CGFloat cornerRadius = 0.5*self.bounds.size.height;
	imageRect.size.height = height;
	imageRect.size.width = height;
	imageRect.origin.x = 0.0;
	imageRect.origin.y = 0.0;
	
	NSUInteger idx = 0;
	
	for (UIImageView *imageView in self.imageViews) {
		imageRect.origin.x = (idx * (height * self.offsetFactor));
		imageView.frame = imageRect;
		imageView.layer.cornerRadius = cornerRadius;
		idx++;
	}
}


-(void)createConstraint {
	// we have to create a new constraint, as someone thought it would be a good idea to make multiplier read-only.
	
	// delete old one
	if(_aspectRatioConstraint) {
		_aspectRatioConstraint.active = NO;
		_aspectRatioConstraint = nil;
	}
	
	// no images => no width
	if(_images.count == 0) {
		_aspectRatioConstraint = [self.widthAnchor constraintEqualToConstant:0.0];
		_aspectRatioConstraint.active = YES;
		return;
	}
	
	CGFloat multiplier = 1.0;
	if(_images.count > 1) {
		multiplier += ((_images.count-1) * _offsetFactor);
	}
	
	_aspectRatioConstraint = [self.widthAnchor constraintEqualToAnchor:self.heightAnchor multiplier:multiplier];
	_aspectRatioConstraint.active = YES;
}

-(void)setCircleBorderWidth:(CGFloat)circleBorderWidth {
	if(_circleBorderWidth == circleBorderWidth) {
		return;
	}
	
	_circleBorderWidth = circleBorderWidth;
	UIEdgeInsets insets = UIEdgeInsetsMake(self.circleBorderWidth, self.circleBorderWidth, self.circleBorderWidth, self.circleBorderWidth);

	[self.imageViews enumerateObjectsUsingBlock:^(InsetImageView *imageView, NSUInteger idx, BOOL *stop) {
		imageView.layer.borderWidth = circleBorderWidth;
		imageView.imageInsets = insets;

	}];
}

-(void)setCircleBorderColor:(UIColor *)circleBorderColor {
	if(_circleBorderColor == circleBorderColor) {
		return;
	}
	
	_circleBorderColor = circleBorderColor;
	CGColorRef cgCircleBorderColor = _circleBorderColor.CGColor;
	
	[self.imageViews enumerateObjectsUsingBlock:^(InsetImageView *imageView, NSUInteger idx, BOOL *stop) {
		imageView.layer.borderColor = cgCircleBorderColor;
	}];
}

@end
