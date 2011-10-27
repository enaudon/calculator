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
  IBOutlet UISwitch *drawMethod;
  id <Solver> solver;
}

//private properties
@property (retain) IBOutlet GraphView *graph;
@property (readonly) IBOutlet UISwitch *drawMethod;
@property (retain) id <Solver> solver;

//public properties
@property (readonly) bool dotDraw;


/*-------------------------{ PROTOCOL  METHODS }-------------------------*/
//returns y-value for given x-value
- (CGFloat) yValueForX:(float)x;

/*-------------------------{ INSTANCE  METHODS }-------------------------*/
//called when the drawing method is changed.  redraws graph.
- (IBAction) drawMethodSwitched:(UISwitch *)sender;

//ask for graph redraw
- (void)updateUI;


@end
