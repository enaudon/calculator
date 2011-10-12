//
//  GraphView.m
//  Calculator
//
//  Created by Enrique S. Naudon on 10/9/11.
//  Copyright 2011 Bowdoin College. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AxesDrawer.h"


@class GraphView;

@protocol GraphViewDelegate
  - (CGFloat) yValueForX:(float)x;
  - (CGFloat) scale;

@end


@interface GraphView : UIView {

@private
  id <GraphViewDelegate> delegate;
  CGPoint origin;
}

//private property
@property (assign) id <GraphViewDelegate> delegate;

@end
