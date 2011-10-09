//
//  GraphViewController.m
//  Calculator
//
//  Created by Enrique S. Naudon on 10/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GraphViewController.h"


@implementation GraphViewController

@synthesize gv;

- (void)viewDidLoad
{
  [super viewDidLoad];
}

- (void)releaseOutlets
{
  
}

- (void)viewDidUnload
{
	//release subviews
	[self releaseOutlets];
  [super viewDidUnload];
}

- (void)dealloc
{
	//release subviews
	[self releaseOutlets];
  [super dealloc];
}

@end
