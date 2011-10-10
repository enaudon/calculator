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


- (void)updateUI
{
	[self.graph setNeedsDisplay];
}

/*Setter for points property.
 *
 *@param newPts the new set of points.
 */
- (void) setPoints:(NSArray *)newPts
{
  [newPts retain];
  if (points) [points release];
  points = newPts;
  [self updateUI];
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
