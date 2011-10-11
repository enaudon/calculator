//
//  GraphView.m
//  Calculator
//
//  Created by Enrique S. Naudon on 10/9/11.
//  Copyright 2011 Bowdoin College. All rights reserved.
//

#import <UIKit/UIKit.h>


@class GraphView;

@protocol GraphViewDelegate
  - (NSArray *)pointsForCurve:(GraphView *)requestor;
  - (NSArray *) xValuesForCurve:(GraphView *)requestor;
  - (NSArray *) yValuesForCurve:(GraphView *)requestor;
@end


@interface GraphView : UIView {

@private
  id <GraphViewDelegate> delegate;
  CGFloat width, height;
}

//private property
@property (assign) id <GraphViewDelegate> delegate;

//public properties
@property (readonly) float width, height;

@end
