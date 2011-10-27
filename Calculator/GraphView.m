//
//  GraphView.m
//  Calculator
//
//  Created by Enrique S. Naudon on 10/9/11.
//  Copyright 2011 Bowdoin College. All rights reserved.
//

#import "GraphView.h"


@implementation GraphView

@synthesize x_offset, y_offset, scale, delegate;

/*Handles pinch gestures.
 *Zooms by changing the graph's scale.
 *
 *@param pinch the gesture object
 */
- (void) pinch:(UIPinchGestureRecognizer *)pinch
{
  scale *= pinch.scale;  //update scale
  
  //enforce min/max scale constraints
  if      (scale < MINIMUM_SCALE) scale = MINIMUM_SCALE;
  else if (scale > MAXIMUM_SCALE) scale = MAXIMUM_SCALE;
  
  //reset the gesture's scale
  pinch.scale = 1;
  
  //refresh display
  [self setNeedsDisplay];
}

/*Handles pan gestures.
 *"Moves" the view to another portion of the graph by changing the origin.
 *
 *@param pan the gesture object
 */
- (void) pan:(UIPanGestureRecognizer *)pan
{
  if (pan.state == UIGestureRecognizerStateChanged ||
      pan.state == UIGestureRecognizerStateEnded)
  {
    //grab offsets
    CGPoint translation = [pan translationInView:self];
    
    //adjust graph offset
    offset.x += translation.x;
    offset.y += translation.y;
    
    //reset the gesture's offsets
    [pan setTranslation:CGPointZero
                 inView:self];
    
    //refresh display
    [self setNeedsDisplay];
  }
}

/*Handles tap gestures.
 *Zooms by changing the graph's scale.
 *
 *@param tap the gesture object
 */
- (void) tap:(UITapGestureRecognizer *)tap
{
  //reset scale and offset
  scale = DEFAULT_SCALE;
  offset = CGPointZero;
  
  //refresh display
  [self setNeedsDisplay];
}

/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
/*--------------------------{ PRIVATE METHODS }--------------------------*/
/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

/*Graphs a curve through the specified points.
 *
 *@param numPts the number of points
 *@param points the points the curve intersects
 */
- (void) drawCurveInContext:(CGContextRef)context
{
  
  //rect for drawing dots
  CGRect dot; CGPoint dotOrigin; CGSize dotSize;
  
  //convert initial display x-value (0) to coordinate value
  CGFloat disp_x  = 0,
          coord_x = (disp_x - origin.x)/scale;

  //convert initial coordinate y-value to display value
  CGFloat coord_y = [delegate yValueForX:coord_x],
          disp_y  = coord_y*scale + origin.y - 2*(coord_y*scale);

  if ([delegate dotDraw])
  {
    //setup rect size
    dotSize.width = 1; dotSize.height = 1;
    dot.size = dotSize;
  }
  else
  {
    //push context and start path
    UIGraphicsPushContext(context);
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, disp_x, disp_y);
  }
  
  //build path
  register int i;
  for (i = 1; i <= 2*(origin.x - offset.x); ++i) {
    
    //grab display x-value and convert to coordinate x-value
    disp_x = i;
    coord_x = (disp_x - origin.x)/scale;
    
    //get coordinate y-value from delegate and convert to display y-value
    coord_y = [delegate yValueForX:coord_x];
    disp_y  = coord_y*scale + origin.y - 2*(coord_y*scale);
    
    if ([delegate dotDraw])
    {
      //set pixel location
      dotOrigin.x = disp_x;
      dotOrigin.y = disp_y;
      dot.origin = dotOrigin;
      
      //color pixel (i.e. draw rect over pixel)
      CGContextFillRect(context, dot);
    }
    else
    {
      //connect display point to curve
      CGContextAddLineToPoint(context, disp_x, disp_y);
    }
  }
  
  //draw curve and pop context
	CGContextStrokePath(context);
	UIGraphicsPopContext();
}

/*Sets instance variables to their default values.
 */
- (void) setDefaults
{
  //initialize scale and offset
  scale = DEFAULT_SCALE;
  offset = CGPointZero;
}


/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
/*---------------------------{ OTHER METHODS }---------------------------*/
/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

/*Draws a set of (x,y) axes into the specified rect.
 *
 *@param rect the rect to draw into
 */
- (void) drawRect:(CGRect)rect
{
  //get origin, scale and context
  CGPoint temp;
  temp.x = self.bounds.size.width/2 + offset.x;
  temp.y = self.bounds.size.height/2 + offset.y;
  origin = temp;
	CGContextRef context = UIGraphicsGetCurrentContext();
  
  //draw axes
  [AxesDrawer drawAxesInRect:rect
               originAtPoint:temp
                       scale:scale];
  
  //draw curve
  [self drawCurveInContext:context];
}

/*Constructor.
 *This particular constructor must be overridden instead of
 *initWithFrame:, because the graph view is loaded from the a xib file.
 */
- (id)initWithCoder:(NSCoder *)decoder
{
  if ([super initWithCoder:decoder])
  {
    [self setDefaults];
  }
  return self;
}

/*Constructor.
 *For the sake of reusability--and just to be safe--, this constructor is
 *overriden too.  (Now even if the code is changed such that the graph is
 *view is not loaded from a xib file, it *should* still initialize
 *properly.
 */
- (id) init {
  if ([super init])
  {
    [self setDefaults];
  }
  return self;
}

/*Destructor.
 */
- (void) dealloc
{
  self.delegate = nil;
  [super dealloc];
}

@end
