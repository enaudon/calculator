//
//  CalculatorViewController.h
//  Calculator
//
//  Created by Enrique S. Naudon on 9/13/11.
//  Copyright 2011 Bowdoin College. All rights reserved.

#import <UIKit/UIKit.h>
#import "CalculatorBrain.h"

@interface CalculatorViewController : UIViewController {
@private
  CalculatorBrain *brain;     //class that performs calculations
  IBOutlet UILabel *display;  //calculator's display
  BOOL typing;  //0 = user done specifying operand
                //1 = user specifying operand
  BOOL real;    //0 = user has specified an integer
                //1 = user has specified real number
}
//private properties
@property (retain, nonatomic) CalculatorBrain  *brain;
@property (retain)            IBOutlet UILabel *display;


/*--------------------------{INSTANCE  METHODS}--------------------------*/
//called when clear is pressed.  clears display and vars.
- (IBAction) clearPressed:(UIButton *)sender;

//called when digit is pressed.  updates display.
- (IBAction) digitPressed:(UIButton *)sender;

//called when operation is pressed.  performs operation.
- (IBAction) operationPressed:(UIButton *)sender;

//called when variable is pressed.  adds variable to expression.
- (IBAction) variablePressed:(UIButton *)sender;


/*-----------------{GETTERS, SETTERS AND OTHER  METHODS}-----------------*/
//called when Eval is pressed.  evaluates the brain's expression.
- (IBAction) evaluateBrainsExpression;


//-----------------------------
/*ASSIGNMENT 3 STUFF FOLLOWS*/
//-----------------------------


@end
