//
//  GraphViewController.h
//  Calculator
//
//  Created by Enrique S. Naudon on 10/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GraphView.h"

#define MIN_X -100
#define MAX_X 100
#define MIN_Y -100
#define MAX_Y 100
#define STEP 100


@class GraphViewController;

@protocol Solver
  - (double) solveForYWithX:(double)x;
@end


@interface GraphViewController : UIViewController <GraphViewDelegate> {

@private
	IBOutlet GraphView *graph;
  id <Solver> solver;
  
@public
  NSArray *yValues;
  double minX, maxX,
         minY, maxY;
  double step;
}

//private properties
@property (retain) IBOutlet GraphView *graph;

//public properties
@property (readonly, retain) NSArray *xValues;
@property (nonatomic, retain) NSArray *yValues;
@property double minX, maxX,
                 minY, maxY;
@property (readonly) double xRange, yRange;
@property double step;


/*-------------------------{ PROTOCOL  METHODS }-------------------------*/
//returns x-values for graphing
- (NSArray *) xValuesForCurve:(GraphView *)requestor;

//returns y-values for graphing
- (NSArray *) yValuesForCurve:(GraphView *)requestor;

/*------------------------{ GETTERS AND SETTERS }------------------------*///setter for yValue
- (void) setYValues:(NSArray *)newYs;

//getter for xValue
- (NSArray *) xValues;

//getter for ranges
- (double) xRange;
- (double) xRange;

/*---------------------------{ OTHER METHODS }---------------------------*/
-(id)initWithSolver:(id)brain;


@end
