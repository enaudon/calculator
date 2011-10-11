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
- (void) drawCurveInContext1:(CGContextRef)context
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

/*Graphs a curve through the specified points.
 *
 *@param numPts the number of points
 *@param points the points the curve intersects
 */
- (void) drawCurveInContext:(CGContextRef)context
{
  //x- and y-value selector variables
  float x = (0 - width/2)/SCALE;
  float y = [delegate yValueForX:x] * SCALE;
  y += height/2 - 2*y;
  
  //push context and start path
	UIGraphicsPushContext(context);
  CGContextBeginPath(context);
  CGContextMoveToPoint(context, x, y);
  
  //build path
  register int i;
  for (i = 1; i <= width; ++i) {
    
    //get point coordinates
    x = (i - width/2)/SCALE;
    y = [delegate yValueForX:x] * SCALE;
    y += height/2 - 2*y;
    
    //add connect cuve to point
    CGContextAddLineToPoint(context, i, y);
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
  
  //get width, height and origin
  CGPoint origin;
  width  = self.bounds.size.width;
  height = self.bounds.size.height;
  origin.x = width/2;
  origin.y = height/2;
	
  //get context
	CGContextRef context = UIGraphicsGetCurrentContext();
  
  //draw axes
  [AxesDrawer drawAxesInRect:rect
               originAtPoint:origin
                       scale:SCALE];
  
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