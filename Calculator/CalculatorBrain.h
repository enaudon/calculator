//
//  CalculatorBrain.h
//  Calculator
//
//  Created by Enrique S. Naudon on 9/13/11.
//  Copyright 2011 Bowdoin College. All rights reserved.

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject {
  @public
    double operand1;  //first operand
  @private
    double operand2;  //second operand
    NSString *waitingOperation;  //operation storage for
                                 //2-operand operations
    double memory;  //storage for the calculator
    NSMutableArray *internalExpression;
}
//public properties
@property (nonatomic) double operand;

//private properties
@property (retain) NSString *waitingOperation;


//clears operands and waitingOperation
- (void) clear;

//returns the result of the specified operation
- (double) performOperation:(NSString *)operation;



//-----------------------------
/*ASSIGNMENT 3 STUFF FOLLOWS*/
//-----------------------------

- (void) setOperand:(double)operand;  //implemented
- (void) setVariableAsOperand:(NSString *)variable;  //implemented

//public properties
@property (readonly) id expression;

+ (double) evaluateExpression:(id)expression
               usingVariables:(NSDictionary *)variables;  //implemented
+ (NSSet *)variablesInExpression:(id)expression;
+ (NSString *)descriptionOfExpression:(id)expression;
+ (id)propertyListForExpression:(id)expression;
+ (id)expressionForPropertyList:(id)propertyList;

@end
