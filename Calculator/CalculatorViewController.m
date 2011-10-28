//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Enrique S. Naudon on 9/13/11.
//  Copyright 2011 Bowdoin College. All rights reserved.

#import "CalculatorViewController.h"

@implementation CalculatorViewController

@synthesize brain, graph, displayText, eval, expr;


/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
/*-------------------------{ INSTANCE  METHODS }-------------------------*/
/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

/*Called when the clear button is pressed.
 *Clears the display, operands and waitingOperation
 *
 *@param sender the triggering button
 */
- (IBAction) clearPressed:(UIButton *)sender
{
  [self.brain clear];  //clear brain variables
  typing = 0;          //clear typing
  real = 0;            //clear real
  self.expr = 0;            //clear expression
  self.displayText = @"0";  //zero display
}

/*Called when a digit-button is pressed.
 *Updates the display.
 *
 *@param sender the triggering button
 */
- (IBAction) digitPressed:(UIButton *)sender
{
  //grab digit
  NSString *digit = [[sender titleLabel] text];
  
  //remember when the user enters a decimal point,
  //and prevent more than one decimal point
  if ([digit isEqual:@"."]) {
    if      (!real) real = 1;
    else if (real)  return;
  }
  
  //display digit
  //if the user is typing, append
  if (typing)
    self.displayText = [self.displayText stringByAppendingString:digit];
  //otherwise, overwrite current display
  else {
    self.displayText = digit;
    typing = 1;
  }
}

/*Called when an operation-button is pressed.
 *Stores the operand and attempts to perform the specified operation.  The
 *display is updated with the result of the operation, or with the brain's
 *expression if a variable has been pressed.
 *
 *@param sender the triggering button
 */
- (IBAction) operationPressed:(UIButton *)sender
{
  //if the user is typing, grab and store operand
  //and clear real
  if (typing) {
    double operand = [self.displayText doubleValue];
    self.brain.operand = operand;
    typing = 0;
    real = 0;
  }
  
  //grab and perform operation
  NSString *operation = [[sender titleLabel] text];
  NSString *result    = [self.brain performOperation:operation];
  
  //display result
  if (expr)
    self.displayText = [CalculatorBrain descriptionOfExpression:
                        self.brain.expression];
  else
    self.displayText = result;
}

/*Called when a variable-button is pressed.
 *Adds the appropriate variable to the expression.
 *
 *@param sender the triggering button
 */
- (IBAction) variablePressed:(UIButton *)sender
{
  self.expr = 1;
  [self.brain setVariableAsOperand:[[sender titleLabel] text]];
}

/*Graphs the brain's current expression.
 */
- (IBAction) graphPressed
{
  //if the CVC (self) is in a navigation controller, push the graph
  if (self.navigationController)
    [self.navigationController pushViewController:self.graph animated:1];
  
  //otherwise, just redraw the graph
  else [self.graph updateUI];
  
}


/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
/*------------------------{ GETTERS AND SETTERS }------------------------*/
/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

/*Setter for expr property.
 *This method also enables/disables the eval button appropriately.
 *
 *@param state the new value for expr.
 */
- (void) setExpr:(BOOL)state
{
  if (state == 0) {
    expr = 0;
    self.eval.enabled = 0;
  }
  else if (state == 1) {
    expr = 1;
    self.eval.enabled = 1;
  }
}

/*Getter for displayText property.
 *
 *return the value of the display's text
 */
- (NSString *) displayText
{
  return [display text];
}

/*Setter for displayText property.
 *
 *@param the new value for the display's text.
 */
- (void) setDisplayText:(NSString *)text
{
  [display setText:text];
}

/*Getter for brain property.
 *
 *@return a pointer to our calculator brain object
 */
- (CalculatorBrain *) brain
{
  if (!brain) brain = [[CalculatorBrain alloc] init];
  return brain;
}

/*Getter for graph property.
 *
 *@return a pointer to our graph object
 */
- (GraphViewController *) graph
{
  if (!graph) {
    graph = [[GraphViewController alloc] init];
    graph.solver = self.brain;
  }
  return graph;
}


/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
/*---------------------------{ OTHER METHODS }---------------------------*/
/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

/*Tells the caller that the CVC (self) can rototate.
 *
 *@return true
 */
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
  return !self.navigationController;
}

/*Returns the size that the CVC (self) wants for popovers.
 *
 *@return a hardcoded size (there are better ways, but not at 1:13am.)
 */
- (CGSize) contentSizeForViewInPopover
{
  CGSize ret;
  ret.width = 320;
  ret.height = 415;
  return ret;
}

/*Constructor
 */
- (id) init
{
  if ([super init]) {
    self.title = @"Calculator";
  }
  return self;
}

/*Constructor
  */
- (id) initWithGraph:(GraphViewController *)gvc
{
  if ([super init]) {
    self.graph = gvc;
    graph.solver = self.brain;
  }
  return self;
}

/*Destructor.
 */
- (void) dealloc
{
  //release instance variables
  [display release];
  [brain   release];
  [graph release];
  
  //call super-class' destructor
  [super dealloc];
}

@end
