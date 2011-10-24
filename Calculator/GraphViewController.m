//
//  GraphViewController.m
//  Calculator
//
//  Created by Enrique S. Naudon on 10/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GraphViewController.h"


@implementation GraphViewController

@synthesize graph, drawMethod, solver;
@synthesize scale, dotDraw;


/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
/*--------------------------{ PRIVATE METHODS }--------------------------*/
/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

/*Release local objects.
 */
- (void)releaseOutlets
{
  [graph release];
  self.solver = nil;
}

/*Sets up the graph as a gesture recognizer.
 */
- (void) setUpGestures
{
  //setup graph for pinch gestures
  UIGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc]
                                initWithTarget:self.graph
                                action:@selector(pinch:)];
  [self.graph addGestureRecognizer:pinch];
  [pinch setDelegate:self.graph];
  [pinch release]; 
  
  //setup graph for pan gestures
  UIGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]
                                initWithTarget:self.graph
                                action:@selector(pan:)];
  [self.graph addGestureRecognizer:pan];
  [pan setDelegate:self.graph];
  [pan release]; 
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

/*Called when the application is in a split-view controller, and that
 *split-view controller is about to hide its left-hand view (typically in
 *response the a rotation).
 *Adds a button the the toolbar that generates a pop-over containing the
 *hidden view (in this case the calculator view).
 *
 *@param svc            the calling split-view controller
 *@param viewController the view that is about to be hidden
 *@param barButton      a button that will generate the pop-over
 *@param pc             the pop-over controller
 */
- (void) splitViewController:(UISplitViewController*)svc
      willHideViewController:(UIViewController *)viewController
           withBarButtonItem:(UIBarButtonItem *)barButton
        forPopoverController:(UIPopoverController *)pc
{
}

/*Called when the application is in a split-view controller, and that
 *split-view controller is about to reveal its left-hand view (typically
 *in response the a rotation).
 *Removes the toolbar button that was added by the above method because
 *it (the button) is now useless since the view is visible.
 *
 *@param svc            the calling split-view controller
 *@param viewController the view that is about to be revealed
 *@param barButton      the now-useless button
 */
- (void) splitViewController:(UISplitViewController*)svc
      willShowViewController:(UIViewController *)aViewController
   invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
  
}


/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
/*-------------------------{ INSTANCE  METHODS }-------------------------*/
/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

/*Called when the magnifcation slider is changed.
 *Stores the new scale value and asks the graph to redraw.
 *
 *@param sender the triggering slider
 */
- (IBAction) mangificationChanged:(UISlider *)sender;
{
  //update scale
  scale = [sender value];
  
  //redraw graph
  [self updateUI];
}

/*Called when the drawing method switch is flipped.
 *Records the state of the switch and asks the graph to redraw.
 */
- (IBAction) drawMethodSwitched:(UISwitch *)sender
{
  //update drawing method
  dotDraw = sender.on;
  
  //redraw graph
  [self updateUI];
}

/*Ask the UI to redraw itself.
 */
- (void)updateUI
{
	[self.graph setNeedsDisplay];
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
- (void) viewDidLoad
{
  [super viewDidLoad];
  
  //set title
  NSString *temp = [solver formula];
  if ([temp length])
    self.title = temp;
  
  //declare self as GV's delegate and setup GV gestures
  self.graph.delegate = self;
  self.graph.scale = DEFAULT_SCALE;
  self.graph.x_offset = 0;
  self.graph.y_offset = 0;
  [self setUpGestures];
  
  self.drawMethod.on = false;
  
  //redraw
  [self updateUI];
}

/*Called after the GVC (self) unloads.
 *Relinquish memory resources.
 */
- (void) viewDidUnload
{
	[self releaseOutlets];  //release subviews
  [super viewDidUnload];
}

/*Tells the caller that the GVC (self) can rototate.
 *
 *@return true
 */
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
  return YES;
}

/*Called after the GVC (self) rotates.
 *Asks the graph to redraw itself.
 */
- (void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)oldOrientation
{
  [self updateUI];
}

/*Constructor.
 */
- (id) init
{
  if ([super init]) {
    //set title
    self.title = DEFAULT_TITLE;
    
    //initialize variables
    scale = DEFAULT_SCALE;
    dotDraw = 0;
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
