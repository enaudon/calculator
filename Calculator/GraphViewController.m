//
//  GraphViewController.m
//  Calculator
//
//  Created by Enrique S. Naudon on 10/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GraphViewController.h"


@implementation GraphViewController

@synthesize graph, magnifier, solver;
@synthesize scale;


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
  self.solver = nil;
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
- (CGFloat) yValueForX:(float)x
{
  return [solver solveForYWithX:x];
}


/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
/*-------------------------{ PROTOCOL  METHODS }-------------------------*/
/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

/*Called when the magnifcation slider is changed.
 *Stores the new scale value and asks the graph to redraw.
 *
 *@param sender the triggering slider
 */
- (IBAction) mangificationChanged:(UISlider *)sender;
{
  //update scale
  self.scale = [sender value];
  
  //redraw graph
  [self updateUI];
}


/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
/*---------------------------{ OTHER METHODS }---------------------------*/
/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

/*Called just before the GVC is displayed.
 *
 *@param animated true if the GVC is animated
 */
- (void) viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  [self updateUI];
}

/*Called after the GVC (self) load.
 *Declare self as the graph's delgate, set min and max scale values, and
 *redraw the UI.
 */
- (void)viewDidLoad
{
  [super viewDidLoad];
  
  //declare self as GV's delegate
  self.graph.delegate = self;
  
  //set min and max scale values
  self.magnifier.minimumValue = MINIMUM_SCALE;
  self.magnifier.maximumValue = MAXIMUM_SCALE;
  self.magnifier.value        = DEFAULT_SCALE;
  
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
- (id) init
{
  if ([super init]) {
    //initialize scale
    self.scale = DEFAULT_SCALE;
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
