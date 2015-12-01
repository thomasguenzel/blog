//
//  ViewController.m
//  PhonePopover
//
//  Created by Thomas Günzel on 01.12.15.
//  Copyright © 2015 Thomas Günzel. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIPopoverPresentationControllerDelegate> {
	UIViewController *popoverViewController;
}

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}
- (IBAction)openPopup:(id)sender {
	if(popoverViewController == nil) {
		popoverViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"popover"];
		
	}
	
	popoverViewController.preferredContentSize = CGSizeMake(320, 100);
	popoverViewController.modalPresentationStyle = UIModalPresentationPopover;
	UIPopoverPresentationController *popoverController = popoverViewController.popoverPresentationController;
	popoverController.permittedArrowDirections = UIPopoverArrowDirectionDown | UIPopoverArrowDirectionUp;
	popoverController.delegate = self;
	popoverController.sourceView = self.view;
	popoverController.sourceRect = [sender frame];
	
	[self presentViewController:popoverViewController animated:YES completion:nil];
}

-(UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller {
	return UIModalPresentationNone;
}

@end
