//
//  GraphViewController.h
//  Calculator
//
//  Created by Enrique S. Naudon on 10/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GraphView.h"

#define DEFAULT_TITLE @"Graph"


@class GraphViewController;

@protocol Solver
  - (double) solveForYWithX:(double)x;
  - (NSString *) formula;

@end


@interface GraphViewController : UIViewController <GraphViewDelegate,
UISplitViewControllerDelegate> {

@private
	IBOutlet GraphView *graph;
  IBOutlet UISwitch *dotDraw;
  id <Solver> solver;
}

//private properties
@property (retain) IBOutlet GraphView *graph;
@property (retain) id <Solver> solver;


/*-------------------------{ PROTOCOL  METHODS }-------------------------*/
//returns y-value for given x-value
- (CGFloat) yValueForX:(float)x;

//handles the popover when the calculator view is about to be hidden
- (void) splitViewController:(UISplitViewController*)svc
      willHideViewController:(UIViewController *)viewController
           withBarButtonItem:(UIBarButtonItem *)barButton
        forPopoverController:(UIPopoverController *)pc;

//handles the popover when the calculator view is about to be revealed
- (void) splitViewController:(UISplitViewController*)svc
      willShowViewController:(UIViewController *)aViewController
   invalidatingBarButtonItem:(UIBarButtonItem *)barButton;

/*-------------------------{ INSTANCE  METHODS }-------------------------*/
//ask for graph redraw
- (void)updateUI;

//called when dotDraw is switched.  refreshes the graph
- (void) drawModeChanged;

/*------------------------{ GETTERS AND SETTERS }------------------------*/
//returns the value of the dotDraw switch
- (BOOL) dotDraw;


@end
