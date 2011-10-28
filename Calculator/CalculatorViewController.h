//
//  CalculatorViewController.h
//  Calculator
//
//  Created by Enrique S. Naudon on 9/13/11.
//  Copyright 2011 Bowdoin College. All rights reserved.

#import <UIKit/UIKit.h>
#import "CalculatorBrain.h"
#import "GraphViewController.h"

@interface CalculatorViewController : UIViewController {

@private
  CalculatorBrain   *brain;     //class that performs calculations
  GraphViewController  *graph;  //class that graphs expressions
  IBOutlet UILabel  *display;   //calculator's display
  IBOutlet UIButton *eval;      //evaluation button
  BOOL typing;  //0 = user done specifying operand
                //1 = user specifying operand
  BOOL real;    //0 = user has specified an integer
                //1 = user has specified real number
  BOOL expr;    //0 = user is not typing an expression
                //1 = user is typing an expression
}

//private properties
@property (retain, nonatomic) CalculatorBrain  *brain;
@property (retain, readonly)  GraphViewController  *graph;
@property (copy)              NSString *displayText;    //display's text
@property (readonly)          UIButton *eval;
@property (nonatomic)         BOOL expr;


/*-------------------------{ INSTANCE  METHODS }-------------------------*/
//called when clear is pressed.  clears display and vars.
- (IBAction) clearPressed:(UIButton *)sender;

//called when digit is pressed.  updates display.
- (IBAction) digitPressed:(UIButton *)sender;

//called when operation is pressed.  performs operation.
- (IBAction) operationPressed:(UIButton *)sender;

//called when variable is pressed.  adds variable to expression.
- (IBAction) variablePressed:(UIButton *)sender;

//called when graph is pressed.  graphs the brain's expression.
- (IBAction) graphPressed;

/*------------------------{ GETTERS AND SETTERS }------------------------*/
//setter for expr property
- (void) setExpr:(BOOL)state;

//getter for displayText property (display's text)
- (NSString *) displayText;

//setter for displayText property (display's text)
- (void) setDisplayText:(NSString *)text;

//getter for brain property
- (CalculatorBrain *) brain;

//getter for brain property
- (GraphViewController *) graph;


@end
