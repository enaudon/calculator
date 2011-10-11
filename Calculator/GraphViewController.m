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
@synthesize yValues, points;


/*Ask the UI to redraw itself.
 */
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
  //release the old as needed and copy the new set of points
  if (points) [points release];
  points = [newPts retain];
  
  //redraw
  [self updateUI];
}

/*Setter for points property.
 *
 *@param newPts the new set of points.
 */
- (void) setYValues:(NSArray *)newYs
{
  //release the old as needed and copy the new set of points
  if (points) [yValues release];
  points = [newYs retain];
  
  //redraw
  [self updateUI];
}

/*Getter for xValues property.
 *The xValues array is dynamically generated using the width of the graph.
 *
 *@return the xValues
 */
- (NSArray *) xValues
{
  //array to hold x-values
  NSMutableArray *values = [[[NSMutableArray alloc] init] autorelease];
  float width = self.graph.width;
  
  //space STEPS x-values out over the graph's width
  register int x;
  for (x = 0; x < width; x+=width/STEP)
    [values addObject:[NSNumber numberWithDouble:x]];
  
  return values;
}

/*Called after the GVC (self) load.
 *Declare GVC (self) as the graph's delgate and redraw the UI.
 */
- (void)viewDidLoad
{
  [super viewDidLoad];
  self.graph.delegate = self;
  [self updateUI];
}

/*Release local objects.
 */
- (void)releaseOutlets
{
  [graph release];
  [points release];
}

/*Called after the GVC (self) unloads.
 *Relinquish memory resources.
 */
- (void)viewDidUnload
{
	[self releaseOutlets];  //release subviews
  [super viewDidUnload];
}

/*Destructor.
 */
- (void)dealloc
{
	[self releaseOutlets];  //release subviews
  [super dealloc];
}

/*Returns the set of points for graphing.
 *The points have to be translated to display properly on a plane where
 *the origin is not at (0,0) before they are returned.
 *
 *@param requestor the object that is requesting the
 */
- (NSArray *)pointsForCurve:(GraphView *)requestor
{
  //create array to hold tranlated points and selectors for the x- and y-
  //values
  NSMutableArray *translated = [[[NSMutableArray alloc] init] autorelease];
  double x, y;
  
  //loop through the points, translating them according to the requestor's
  //dimentions
  register int i;
  for (i = 0; i < [self.points count]; i+=2)
  {
    //grab and translate x value
    x = [[self.points objectAtIndex:i] doubleValue];
    x += requestor.width/2;
    
    //grab and translate y value
    y = [[self.points objectAtIndex:i+1] doubleValue];
    y += requestor.height/2 - 2*y;
    
    //store x- and y-values
    [translated addObject:[NSNumber numberWithDouble:x]];
    [translated addObject:[NSNumber numberWithDouble:y]];
  }
  
  return translated;
}


/*Returns the set of x-values for graphing.
 *The points have to be translated to display properly on a plane where
 *the origin is not at (0,0) before they are returned.
 *
 *@param requestor the object that is requesting the
 */
- (NSArray *) xValuesForCurve:(GraphView *)requestor
{
  //create array to hold tranlated points and selectors for the x- and y-
  //values
  NSMutableArray *translated = [[[NSMutableArray alloc] init] autorelease];
  double x;
  
  //loop through the points, translating them according to the requestor's
  //dimentions
  register int i;
  for (i = 0; i < [self.xValues count]; i+=2)
  {
    //grab and translate
    x = [[self.xValues objectAtIndex:i] doubleValue];
    x += requestor.width/2;
    
    //store
    [translated addObject:[NSNumber numberWithDouble:x]];
  }
  
  return translated;
}


/*Returns the set of y-values for graphing.
 *The points have to be translated to display properly on a plane where
 *the origin is not at (0,0) before they are returned.
 *
 *@param requestor the object that is requesting the
 */
- (NSArray *) yValuesForCurve:(GraphView *)requestor
{
  //create array to hold tranlated points and selectors for the x- and y-
  //values
  NSMutableArray *translated = [[[NSMutableArray alloc] init] autorelease];
  double y;
  
  //loop through the points, translating them according to the requestor's
  //dimentions
  register int i;
  for (i = 0; i < [self.yValues count]; i+=2)
  {
    //grab and translate
    y = [[self.yValues objectAtIndex:i+1] doubleValue];
    y += requestor.height/2 - 2*y;
    
    //store
    [translated addObject:[NSNumber numberWithDouble:y]];
  }
  
  return translated;
}


@end
