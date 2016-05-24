//
//  GNTabViewItem.m
//
//  Created by Thomas Günzel on 25/05/16.
//  Copyright © 2016 Thomas Günzel. All rights reserved.
//

#import "GNTabViewItem.h"

@implementation GNTabViewItem

-(void)dealloc {
	[self.viewController removeObserver:self forKeyPath:@"title"];
}

-(void)setViewController:(NSViewController *)viewController {
	[self.viewController removeObserver:self forKeyPath:@"title"];
	[super setViewController:viewController];
	[self.viewController addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
	if([keyPath isEqualToString:@"title"] && object == self.viewController) {
		self.label = self.viewController.title;
		return;
	}
	[super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
}

@end
