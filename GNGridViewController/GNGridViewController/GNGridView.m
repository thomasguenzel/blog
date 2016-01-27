//
//  GNGridViewController.m
//  GNGridViewController
//
//  Created by Thomas Günzel on 26.01.16.
//  Copyright © 2016 Thomas Günzel. All rights reserved.
//

#import "GNGridView.h"

#pragma mark Private Helper Class

@interface GNGridItem : NSObject

@property(readonly,nonatomic,strong) UIView *view;
@property(readonly,nonatomic) GNGridBlock block;
@property(readonly,nonatomic) UIEdgeInsets edgeInsets;

-(instancetype)initWithView:(UIView*)view inBlock:(const GNGridBlock)block edgeInsets:(UIEdgeInsets)insets;

@end

@implementation GNGridItem

- (instancetype)initWithView:(UIView *)view inBlock:(const GNGridBlock)block edgeInsets:(UIEdgeInsets)insets {
	self = [super init];
	if (self) {
		_view = view;
		_block = block;
		_edgeInsets = insets;
	}
	return self;
}

@end


#pragma mark - GridView

@interface GNGridView () {
	NSMutableArray<GNGridItem*> *_gridItems;
}

@end

@implementation GNGridView

#pragma mark - Allocation

- (instancetype)init
{
	self = [super init];
	if (self) {
		[self loadView];
	}
	return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		[self loadView];
	}
	return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
	self = [super initWithCoder:coder];
	if (self) {
		[self loadView];
	}
	return self;
}

-(void)loadView {
	_gridItems = [[NSMutableArray alloc] init];
}

#pragma mark - Getters and Setters

-(void)setSize:(GNGridSize)size {
	if(_size.width == size.width && _size.height == size.height) {
		return;
	}
	_size = size;
	[self setNeedsLayout];
}

-(void)setSpacing:(CGFloat)spacing {
	if(_spacing == spacing) {
		return;
	}
	_spacing = spacing;
	[self setNeedsLayout];
}

-(void)setDebugModeEnabled:(BOOL)debugModeEnabled {
	if(_debugModeEnabled == debugModeEnabled) {
		return;
	}
	_debugModeEnabled = debugModeEnabled;
	for (GNGridItem *itm in _gridItems) {
		[self adjustItemToDebugMode:itm];
	}
}

#pragma mark - Subview Management

-(void)addSubview:(UIView *)view inBlock:(const GNGridBlock)block {
	[self addSubview:view inBlock:block edgeInsets:UIEdgeInsetsZero];
}

-(void)addSubview:(UIView *)view inBlock:(const GNGridBlock)block edgeInsets:(UIEdgeInsets)insets {
	if([self viewExistsInBlock:block] == YES) {
		NSLog(@"Error! Can't add the view, there's already a view in the block.");
		return;
	}
	
	GNGridItem *itm = [[GNGridItem alloc] initWithView:view inBlock:block edgeInsets:insets];
	[_gridItems addObject:itm];
	[self adjustItemToDebugMode:itm];
	[self addSubview:view];
}

-(void)removeSubview:(UIView *)view {
	NSUInteger idx = 0;
	GNGridItem *item = nil;
	for (GNGridItem *itm in _gridItems) {
		if (itm.view == view) {
			item = itm;
			break;
		}
		idx++;
	}
	if (item == nil) {
		NSLog(@"Could not remove superview (not found)");
		return;
	}
	[_gridItems removeObjectAtIndex:idx];
	[item.view removeFromSuperview];
}


-(BOOL)viewExistsInBlock:(const GNGridBlock)block {
	for (GNGridItem *itm in _gridItems) {
		GNGridBlock blk = itm.block;
//		NSLog(@"%lu %lu %lu %lu",blk.origin.x,blk.origin.y,blk.size.width,blk.size.height);
		if(block.origin.x < blk.origin.x+blk.size.width && block.origin.x+block.size.width > blk.origin.x &&
		   block.origin.y < blk.origin.y+blk.size.height && block.origin.y+block.size.height > blk.origin.y) {
			return YES;
		}
		
	}
	return NO;
}

#pragma mark - Layout


-(void)layoutSubviews {
	if(_gridItems.count == 0) {
		return;
	}
	
	CGSize s = self.bounds.size;

	// extend the screen edge, so there is no white border when _spacing is used
	s.width += _spacing;
	s.height += _spacing;
	
	CGFloat *xGrid = malloc(sizeof(CGFloat)*(_size.width+1));
	CGFloat *yGrid = malloc(sizeof(CGFloat)*(_size.height+1));
	
	
	CGFloat width = (s.width/(CGFloat)_size.width);
	CGFloat height = (s.height/(CGFloat)_size.height);
	
	for (NSUInteger x = 0; x <= _size.width; x++) {
		xGrid[x] = round(width*(CGFloat)x);
	}
	for (NSUInteger y = 0; y <= _size.height; y++) {
		yGrid[y] = round(height*(CGFloat)y);
	}
	
	for (GNGridItem *itm in _gridItems) {
		GNGridBlock blk = itm.block;
		UIEdgeInsets insets = itm.edgeInsets;
		CGRect r;
		// as i barely understand the code myself, i decided to add comments
		
		// calculate origin and width, without spacing or insets
		r.origin.x = xGrid[blk.origin.x];
		r.size.width = xGrid[blk.origin.x+blk.size.width]-xGrid[blk.origin.x];
		
		// add the left inset to the origin and substract it from the width (the rect moves and 'scales')
		r.origin.x += insets.left;
		r.size.width -= insets.left;
		
		// subtract the right inset from the width
		r.size.width -= insets.right;
		// and the spacing
		r.size.width -= _spacing;
		
		// i'm too lazy to comment the same stuff for the y/height.
		// it's actually quite the same
		r.origin.y = yGrid[blk.origin.y];
		r.size.height = yGrid[blk.origin.y+blk.size.height]-yGrid[blk.origin.y];
		r.origin.y += insets.top;
		r.size.height -= insets.top;
		r.size.height -= insets.bottom;
		r.size.height -= _spacing;
		itm.view.frame = r;
	}
}

-(void)adjustItemToDebugMode:(GNGridItem*)itm {
	CALayer *lyr = itm.view.layer;
	if(_debugModeEnabled == YES) {
		lyr.borderColor = [UIColor redColor].CGColor;
		lyr.borderWidth = 1.0;
	} else {
		lyr.borderColor = nil;
		lyr.borderWidth = 0.0;
	}
}

@end
