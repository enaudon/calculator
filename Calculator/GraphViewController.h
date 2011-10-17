//
//  GraphViewController.h
//  Calculator
//
//  Created by Enrique S. Naudon on 10/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GraphView.h"

#define MINIMUM_SCALE 1
#define DEFAULT_SCALE 18
#define MAXIMUM_SCALE 125
#define DEFAULT_DRAW_METHOD 


@class GraphViewController;

@protocol Solver
  - (double) solveForYWithX:(double)x;

@end


@interface GraphViewController : UIViewController <GraphViewDelegate> {

@private
	IBOutlet GraphView *graph;
  IBOutlet UISlider *magnifier;
  IBOutlet UISwitch *drawMethod;
  id <Solver> solver;
@public
  CGFloat scale;
}

//private properties
@property (retain) IBOutlet GraphView *graph;
@property (readonly) IBOutlet UISlider *magnifier;
@property (readonly) IBOutlet UISwitch *drawMethod;
@property (retain) id <Solver> solver;

//public properties
@property (readonly) CGFloat scale;
@property (readonly) bool dotDraw;


/*-------------------------{ PROTOCOL  METHODS }-------------------------*/
//returns y-value for given x-value
- (CGFloat) yValueForX:(float)x;

//getter for the scale parameter
- (CGFloat) scale;

/*-------------------------{ INSTANCE  METHODS }-------------------------*/
//called when magnification is changed.  redraws graph.
- (IBAction) mangificationChanged:(UISlider *)sender;

//called when the drawing method is changed.  redraws graph.
- (IBAction) drawMethodSwitched:(UISwitch *)sender;


@end
