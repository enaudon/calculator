//
//  CalculatorBrain.h
//  Calculator
//
//  Created by Enrique S. Naudon on 9/13/11.
//  Copyright 2011 Bowdoin College. All rights reserved.

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject {

@private
  double operand2;  //second operand
  NSString *waitingOperation;  //operation storage for
                               //2-operand operations
  double memory;  //storage for the calculator
  NSMutableArray *internalExpression;
@public
  double operand1;  //first operand
}

//private properties
@property (retain) NSString *waitingOperation;

//public properties
@property (nonatomic) double operand;
@property (readonly) id expression;


/*----------------------------{CLASS METHODS}----------------------------*/
//returns the result of the specified expression
+ (double) evaluateExpression:(id)expression
                withVariables:(NSDictionary *)variables;

//returns a set of the variables in the specified expression
+ (NSSet *)variablesInExpression:(id)expression;


/*--------------------------{INSTANCE  METHODS}--------------------------*/
//clears operands and waitingOperation
- (void) clear;

//returns the result of the specified operation
- (double) performOperation:(NSString *)operation;

//adds variable to internalExpression
- (void) setVariableAsOperand:(NSString *)variable;


/*-----------------{GETTERS, SETTERS AND OTHER  METHODS}-----------------*/
//getter for expression (internalExpression)
- (id) expression;

//setter for operand (operand1)
- (void) setOperand:(double)operand;


//-----------------------------
/*ASSIGNMENT 3 STUFF FOLLOWS*/
//-----------------------------

+ (NSString *)descriptionOfExpression:(id)expression;
+ (id)propertyListForExpression:(id)expression;
+ (id)expressionForPropertyList:(id)propertyList;

@end
