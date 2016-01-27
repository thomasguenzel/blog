//
//  ViewController.m
//  GNGridViewController
//
//  Created by Thomas Günzel on 26.01.16.
//  Copyright © 2016 Thomas Günzel. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet GNGridView *gridView;

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	_gridView.size = GNGridSizeMake(3, 4);
	_gridView.spacing = 4.0;
	
	UILabel *headerLabel = [[UILabel alloc] init];
	headerLabel.text = @"Header Goes Here";
	headerLabel.numberOfLines = 0;
	[_gridView addSubview:headerLabel inBlock:GNGridBlockMake(0, 0, 2, 1) edgeInsets:UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0)];
	
	UIButton *pressMe = [[UIButton alloc] init];
	pressMe.backgroundColor = [UIColor blueColor]; // https://open.spotify.com/track/5FgtdSf7I5lClThz2ptWvl
	[pressMe setTitle:@"Press me!" forState:UIControlStateNormal];
	[pressMe setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[pressMe addTarget:self action:@selector(pressMePressed:) forControlEvents:UIControlEventTouchUpInside];
	[_gridView addSubview:pressMe inBlock:GNGridBlockMake(0, 1, 3, 3)];
	
	
	UIButton *toggleDebug = [[UIButton alloc] init];
	toggleDebug.backgroundColor = [UIColor grayColor];
	[toggleDebug setTitle:@"Debug Mode" forState:UIControlStateNormal];
	[toggleDebug setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	[toggleDebug addTarget:self action:@selector(toggleDebug:) forControlEvents:UIControlEventTouchUpInside];
	[_gridView addSubview:toggleDebug inBlock:GNGridBlockMake(2, 0, 1, 1)];
	
//	for (NSUInteger x = 0; x < _gridView.size.width; x++) {
//		for (NSUInteger y = 0; y < _gridView.size.height; y++) {
//			UIView *v = [[UIView alloc] init];
//			v.backgroundColor = [UIColor redColor];
//			[_gridView addSubview:v inBlock:GNGridBlockMake(x, y, 1, 1)];
//		}
//	}
}

-(void)toggleDebug:(UIButton*)sender {
	_gridView.debugModeEnabled = !_gridView.debugModeEnabled;
}

-(void)pressMePressed:(UIButton*)sender {
	[_gridView removeSubview:sender];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
