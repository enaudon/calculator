//
//  GraphViewController.m
//  Calculator
//
//  Created by Enrique S. Naudon on 10/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GraphViewController.h"


@implementation GraphViewController

@synthesize graph;
@synthesize points;



/*Getter for graph property.
 *
 *@return a pointer to our calculator graph object
 */
- (GraphView *) graph
{
  if (!graph)
    graph = [[GraphView alloc] init];
  return graph;
}
  
- (void)updateUI
{
	[self.graph setNeedsDisplay];
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  self.graph.delegate = self;
  [self updateUI];
}

- (void)releaseOutlets
{
  [graph release];
  [points release];
}

- (void)viewDidUnload
{
	[self releaseOutlets];  //release subviews
  [super viewDidUnload];
}

- (void)dealloc
{
	[self releaseOutlets];  //release subviews
  [super dealloc];
}

- (NSArray *)pointsForCurve:(GraphView *)requestor
{
  return self.points;
}


@end
