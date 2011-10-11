//
//  GraphViewController.h
//  Calculator
//
//  Created by Enrique S. Naudon on 10/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GraphView.h"


@class GraphViewController;

@protocol Solver
  - (double) solveForYWithX:(double)x;
@end


@interface GraphViewController : UIViewController <GraphViewDelegate> {

@private
	IBOutlet GraphView *graph;
  id <Solver> solver;
}

//private property
@property (retain) id <Solver> solver;

//private properties
@property (retain) IBOutlet GraphView *graph;


/*-------------------------{ PROTOCOL  METHODS }-------------------------*/
//returns y-value for given x-value
- (float) yValueForX:(float)x;


@end
