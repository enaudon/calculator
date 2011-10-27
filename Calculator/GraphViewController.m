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
@synthesize dotDraw;


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

/*Adds the specified gesture recognizer to the graph view.
 *
 *@param recognizer the recognizer to be added to the graph
 */
- (void) addRecognizerToGraph:(UIGestureRecognizer *)recognizer
{
  [self.graph addGestureRecognizer:recognizer];
  [recognizer setDelegate:self.graph];
}

/*Sets up the graph as a gesture recognizer.
 */
- (void) setUpGestures
{
  //general gesture recognizer
  UIGestureRecognizer *recognizer;
  
  //setup graph for pinch gestures
  recognizer = [[UIPinchGestureRecognizer alloc]
                initWithTarget:self.graph
                        action:@selector(pinch:)];
  [self addRecognizerToGraph:recognizer];
  
  //setup graph for pan gestures
  recognizer = [[UIPanGestureRecognizer alloc]
                initWithTarget:self.graph
                action:@selector(pan:)];
  [self addRecognizerToGraph:recognizer];
  
  //setup graph for tap gestures
  recognizer = [[UITapGestureRecognizer alloc]
                initWithTarget:self.graph
                        action:@selector(tap:)];
  [(UITapGestureRecognizer *)recognizer setNumberOfTapsRequired:2];
  [self addRecognizerToGraph:recognizer];
  
  //release our general purpose recognizer
  [recognizer release];
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
 *Declare self as the graph's delgate and redraw the UI.
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
