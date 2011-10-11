//
//  GraphViewController.h
//  Calculator
//
//  Created by Enrique S. Naudon on 10/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GraphView.h"

#define STEP 100

@interface GraphViewController : UIViewController <GraphViewDelegate> {
  
@private
	IBOutlet GraphView *graph;
  
@public
  NSArray *points;
}

//private properties
@property (retain) IBOutlet GraphView *graph;

//public properties
@property (nonatomic, retain) NSArray *points;
@property (readonly, retain) NSArray *xValues;
@property (nonatomic, retain) NSArray *yValues;

@end
