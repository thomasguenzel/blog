//
//  ViewController.m
//  ReactionListView
//
//  Created by Thomas Günzel on 11/10/2016.
//  Copyright © 2016 Thomas Günzel. All rights reserved.
//

#import "ViewController.h"

#import "CollapsedCircleListView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet CollapsedCircleListView *demoView;

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	_demoView.images = @[[UIImage imageNamed:@"1"],[UIImage imageNamed:@"2"],[UIImage imageNamed:@"3"]];
}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}


@end
