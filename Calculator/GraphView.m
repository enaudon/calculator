//
//  GraphView.m
//  Calculator
//
//  Created by Enrique S. Naudon on 10/9/11.
//  Copyright 2011 Bowdoin College. All rights reserved.
//

#import "GraphView.h"


@implementation GraphView

@synthesize delegate;
@synthesize width, height;

- (id) initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {}
    return self;
}

/*Graphs a curve through the specified points.
 *
 *@param numPts the number of points
 *@param points the points the curve intersects
 */
- (void) drawCurveInContext:(CGContextRef)context
{
  //x- and y-value arrays and selector variables
  NSArray *xValues = [self.delegate xValuesForCurve:self];
  NSArray *yValues = [self.delegate yValuesForCurve:self];
  NSNumber *x = [xValues objectAtIndex: 0],
           *y = [yValues objectAtIndex: 0];
  
  //push context and start path
	UIGraphicsPushContext(context);
  CGContextBeginPath(context);
  CGContextMoveToPoint(context, [x floatValue], [y floatValue]);
  
  //build path
  register int i;
  for (i = 1; i < [xValues count]; ++i) {
    
    //get point coordinates
    x = [xValues objectAtIndex: i];
    y = [yValues objectAtIndex: i];
    
    //add connect cuve to point
    CGContextAddLineToPoint(context, [x floatValue], [y floatValue]);
  }
  
  //draw curve and pop context
	CGContextStrokePath(context);
	UIGraphicsPopContext();
}

/*Draws a set of (x,y) axes into the specified rect.
 *
 *@param rect the rect to draw into
 */
- (void) drawRect:(CGRect)rect
{
  NSLog(@"draw");
  
  //get width and height
  width  = self.bounds.size.width;
  height = self.bounds.size.height;
	
  //get context
	CGContextRef context = UIGraphicsGetCurrentContext();
  
  //draw x-axis
  CGContextBeginPath(context);
  CGContextMoveToPoint(context, 0, height/2);
  CGContextAddLineToPoint(context, width, height/2);
  CGContextDrawPath(context, kCGPathFillStroke);
  
  //draw y-axis
  CGContextBeginPath(context);
  CGContextMoveToPoint(context, width/2, 0);
  CGContextAddLineToPoint(context, width/2, height);
  CGContextDrawPath(context, kCGPathFillStroke);
  
  //draw curve
  [self drawCurveInContext:context];
}

/*Getter for width property.
 *Notice that the width variable is a CGFloat, while the property is a
 *float.  This is done to simplify the life of objects who use the GV's
 *width.
 */
- (float) width
{
  return (float)width;
}

/*Getter for height property.
 *Notice that the height variable is a CGFloat, while the property is a
 *float.  This is done to simplify the life of objects who use the GV's
 *height.
 */
- (float) height
{
  return (float)height;
}

/*Destructor.
 */
- (void) dealloc
{
  [super dealloc];
}

@end
