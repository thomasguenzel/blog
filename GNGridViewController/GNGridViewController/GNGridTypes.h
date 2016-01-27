//
//  GNGridTypes.h
//  GNGridViewController
//
//  Created by Thomas Günzel on 26.01.16.
//  Copyright © 2016 Thomas Günzel. All rights reserved.
//

#ifndef GNGridTypes_h
#define GNGridTypes_h

typedef struct GNGridPoint {
	NSUInteger x;
	NSUInteger y;
} GNGridPoint;

typedef struct GNGridSize {
	NSUInteger width;
	NSUInteger height;
} GNGridSize;

typedef struct GNGridBlock {
	GNGridPoint origin;
	GNGridSize size;
} GNGridBlock;

static inline GNGridPoint
GNGridPointMake(NSUInteger x, NSUInteger y)
{
	GNGridPoint p;
	p.x = x; p.y = y;
	return p;
}

static inline GNGridSize
GNGridSizeMake(NSUInteger width, NSUInteger height)
{
	GNGridSize size;
	size.width = width; size.height = height;
	return size;
}

static inline GNGridBlock
GNGridBlockMake(NSUInteger x, NSUInteger y, NSUInteger width, NSUInteger height)
{
	GNGridBlock block;
	block.origin.x = x; block.origin.y = y;
	block.size.width = width; block.size.height = height;
	return block;
}

#endif /* GNGridTypes_h */
