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
@synthesize yValues,
            minX, maxX, minY, maxY,
            xRange, yRange,
            step;


/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
/*--------------------------{ PRIVATE METHODS }--------------------------*/
/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

/*Ask the UI to redraw itself.
 */
- (void)updateUI
{
	[self.graph setNeedsDisplay];
}

/*Release local objects.
 */
- (void)releaseOutlets
{
  [graph release];
  [yValues release];
}


/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
/*-------------------------{ PROTOCOL  METHODS }-------------------------*/
/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

/*Returns the corresponding y-value for the specified x-value.
 *The y-value must be translated to display properly on a plane where the
 *origin is not at (0,0) before it is returned.
 *
 *@return y the (translated) corresponding y-value
 */
- (float) yValueForX:(float)x
{
  return [solver solveForYWithX:x];
}

/*Returns the set of x-values for graphing.
 *The x-values have to be translated to display properly on a plane where
 *the origin is not at (0,0) before they are returned.
 *
 *@param requestor the object that is requesting the
 */
- (NSArray *) xValuesForCurve:(GraphView *)requestor
{
  //create array to hold tranlated x-values and a selector for the
  //original x-values
  NSMutableArray *translated = [[[NSMutableArray alloc] init] autorelease];
  double x;
  
  //loop through the x-values, translating them according to the
  //requestor's dimentions
  register int i;
  for (i = 0; i < [self.xValues count]; ++i)
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
 *The y-values have to be translated to display properly on a plane where
 *the origin is not at (0,0) before they are returned.
 *
 *@param requestor the object that is requesting the
 */
- (NSArray *) yValuesForCurve:(GraphView *)requestor
{
  //create array to hold tranlated y-values and a selector for the
  //original y-values
  NSMutableArray *translated = [[[NSMutableArray alloc] init] autorelease];
  double y;
  
  //loop through the y-values, translating them according to the
  //requestor's dimentions
  register int i;
  for (i = 0; i < [self.yValues count]; ++i)
  {
    //grab and translate
    y = [[self.yValues objectAtIndex:i] doubleValue];
    y += requestor.height/2 - 2*y;
    
    //store
    [translated addObject:[NSNumber numberWithDouble:y]];
  }
  
  return translated;
}


/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
/*------------------------{ GETTERS AND SETTERS }------------------------*/
/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

/*Setter for yValues property.
 *
 *@param newYs the new set of y-values.
 */
- (void) setYValues:(NSArray *)newYs
{
  //release the old as needed and copy the new set of y-values
  if (yValues) [yValues release];
  yValues = [newYs retain];
  
  //redraw
  [self updateUI];
}

/*Getter for xValues property.
 *The x-values array is generated using the dimentions of the graph.
 *
 *@return the xValues
 */
- (NSArray *) xValues
{
  //array to hold x-values
  NSMutableArray *values = [[[NSMutableArray alloc] init] autorelease];
  
  //space STEP x-values out over the graph's x-value range
  register int x;
  for (x = 0; x <= graph.width; ++x)
    [values addObject:[NSNumber numberWithDouble:x]];
  
  return values;
}

/*Getter for the xRange property.
 *the x-value range is generated dynamically using min and max x-values.
 *
 *@return the x-value range
 */
- (double) xRange
{
  return self.maxX - self.minX;
}

/*Getter for the yRange property.
 *the y-value range is generated dynamically using min and max y-values.
 *
 *@return the y-value range
 */
- (double) yRange
{
  return self.maxY - self.minY;
}


/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
/*---------------------------{ OTHER METHODS }---------------------------*/
/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

/*Called after the GVC (self) load.
 *Declare GVC (self) as the graph's delgate and redraw the UI.
 */
- (void)viewDidLoad
{
  [super viewDidLoad];
  
  //declare self as GV's delegate
  self.graph.delegate = self;
  
  //redraw
  [self updateUI];
}

/*Called after the GVC (self) unloads.
 *Relinquish memory resources.
 */
- (void)viewDidUnload
{
	[self releaseOutlets];  //release subviews
  [super viewDidUnload];
}

/*Constructor.
 */
-(id)initWithSolver:(id)brain
{
  if ([super init])
  {
    //store solver
    solver = brain;
    
    //initialize scale to default values
    self.minX = MIN_X;
    self.maxX = MAX_X;
    self.minY = MIN_Y;
    self.maxY = MAX_Y;
    self.step = STEP;
  }
  return self;
}

/*Destructor.
 */
- (void)dealloc
{
	[self releaseOutlets];  //release subviews
  [super dealloc];
}


@end
