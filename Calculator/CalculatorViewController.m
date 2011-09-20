//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Enrique S. Naudon on 9/13/11.
//  Copyright 2011 Bowdoin College. All rights reserved.

#import "CalculatorViewController.h"

@implementation CalculatorViewController

/*Supplies the calculator brain object.
 *Only allows one to be created.
 *
 *@return a pointer to our calculator brain object
 */
- (CalculatorBrain *) brain
{
    if (!brain) brain = [[CalculatorBrain alloc] init];
    return brain;
}

/*Called when the clear button is pressed.
 *Clears the display, operands and waitingOperation
 *
 *@param sender the triggering button
 */
- (IBAction) clearPressed:(UIButton *)sender
{
    [[self brain] clear];    //clear brain variables
    [display setText:@"0"];  //zero display
    typing = 0;              //clear typing
    real = 0;                //clear real
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
    if ([digit isEqual:@"."])
      if      (!real) real = 1;
      else if (real)  return;
    
    //display digit
    //if the user is typing, append
    if (typing)
      [display setText:[[display text]
                        stringByAppendingString:digit]];
    //otherwise, overwrite current display
    else {
      [display setText:digit];
      typing = 1;
    }
}

/*Called when an operation-button is pressed.
 *Stores the operand and attempts to perform the specified
 *operation.
 *
 *@param sender the triggering button
 */
- (IBAction) operationPressed:(UIButton *)sender
{    
    //if the user is typing, grab and store operand
    //and clear real
    if (typing) {
      double operand = [[display text] doubleValue];
      [[self brain] setOperand1:operand];
      typing = 0;
      real = 0;
    }
    
    //grab and perform operation
    NSString *operation = [[sender titleLabel] text];
    double result = [[self brain] performOperation:operation];
    
    //display result
    [display setText:[NSString stringWithFormat:@"%g", result]];
}

/*Called when a memory-opertion button is pressed.
 *Performs the specified operation, stores the result in
 *the memory varible, and prints it to the display.  The
 *only two available operations are mem+ (add display to
 *memory) and mem- (subtract display from memory).
 *
 *@param sender the triggering button
 */
- (IBAction) memOpPressed:(UIButton *)sender
{
    //grab and store operand, and clear typing and real
    double operand = [[display text] doubleValue];
    [[self brain] setOperand1:operand];
    typing = 0;
    real = 0;
  
    //grab and perform operation
    NSString *operation = [[sender titleLabel] text];
    double result = [[self brain] performMemOp:operation];
  
    //display result
    [display setText:[NSString stringWithFormat:
                      @"%g", result]];
}

@end
