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

@end


@interface GraphView : UIView {

@private
  id <GraphViewDelegate> delegate;
}

//private property
@property (assign) id <GraphViewDelegate> delegate;

@end
