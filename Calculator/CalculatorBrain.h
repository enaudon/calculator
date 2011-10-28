//
//  CalculatorBrain.h
//  Calculator
//
//  Created by Enrique S. Naudon on 9/13/11.
//  Copyright 2011 Bowdoin College. All rights reserved.

#import <Foundation/Foundation.h>
#import "GraphViewController.h"

#define VAR_PREFIX @"$"
#define DIV_ZERO   @"Err: Div by zero"

@interface CalculatorBrain : NSObject <Solver> {

@private
  double operand2;  //second operand
  NSString *waitingOperation;  //operation storage for
                               //2-operand operations
  double memory;  //storage for the calculator
  NSMutableArray *internalExpression;  //expression for evaluation
@public
  double operand1;  //first operand
}

//private properties
@property (retain) NSString *waitingOperation;

//public properties
@property (nonatomic) double operand;
@property (readonly) id expression;



/*-------------------------{ PROTOCOL  METHODS }-------------------------*/
//returns the y-value for given x-value
- (double) solveForYWithX:(double)x;

//returns a string representation of the expression
- (NSString *) formula;

/*---------------------------{ CLASS METHODS }---------------------------*/
//returns the result of the specified expression
+ (double) evaluateExpression:(id)expression
                withVariables:(NSDictionary *)variables;

//returns a set of the variables in the specified expression
+ (NSSet *)variablesInExpression:(id)expression;

//returns a string representation of the specified expression
+ (NSString *)descriptionOfExpression:(id)expression;

//returns a property list representation of the specified expression
+ (id)propertyListForExpression:(id)expression;

//returns an expression from the specifed propertylist
+ (id)expressionForPropertyList:(id)propertyList;


/*-------------------------{ INSTANCE  METHODS }-------------------------*/
//clears operands and waitingOperation
- (void) clear;

//returns the result of the specified operation
- (NSString *) performOperation:(NSString *)operation;

//adds variable to internalExpression
- (void) setVariableAsOperand:(NSString *)variable;


/*------------------------{ GETTERS AND SETTERS }------------------------*/
//getter for expression (internalExpression)
- (id) expression;

//setter for operand (operand1)
- (void) setOperand:(double)operand;


@end
